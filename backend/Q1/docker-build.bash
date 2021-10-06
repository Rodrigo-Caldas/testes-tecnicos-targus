#!/bin/bash
# Mede o tempo de execução de cada estágio de build Docker
# uso: bash docker-build.bash [parâmetros]

DATE_FORMAT="+%s"

(
    # Output da linha inicial
    echo "$(date $DATE_FORMAT) | - 0 - START"

    docker build $* | \
        grep "^Step" | \
        while read line ;
        do
            echo "$(date $DATE_FORMAT) | $line";
        done;

    # Output da linha final
    echo "$(date $DATE_FORMAT) | - -1 - END"
) | (
    # Gera o JSON de saída:
    # - Estágio inicial: 0
    # - Estágio final: -1

    echo "["
    FIRST_RUN=true
    while read line ;
    do
        [[ -z "$FIRST_RUN" ]] && echo ","

        lineArray=($line)
        time="${lineArray[0]}"
        step="${lineArray[3]}"
        cmd="${lineArray[@]:5}"

        stepNum=${step/\/*/}
        escapedCmd="${cmd//\"/\\\"}"  # escape de aspas duplas

        echo "  {"
        echo "    \"time\": $time,"
        echo "    \"step\": $stepNum,"
        echo "    \"cmd\": \"$escapedCmd\""
        echo -n "  }"

        unset FIRST_RUN
    done
    echo
    echo "]"
)
