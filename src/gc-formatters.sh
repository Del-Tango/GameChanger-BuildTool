#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# FORMATTERS

function format_game_changer_arguments () {
    local ARGUMENTS=(
        "--expiration-date=${MD_DEFAULT['exp-date']}"
        "--expired-message=${MD_DEFAULT['exp-msg']}"
        "--target-file=${MD_DEFAULT['target-file']}"
        "--output-file=${MD_DEFAULT['output-file']}"
    )
    if [ "${MD_DEFAULT['verbose']}" == 'on' ]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} "--verbose" )
    fi
    if [ "${MD_DEFAULT['setuid']}" == 'on' ]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} "--setuid" )
    fi
    if [ "${MD_DEFAULT['debug-exec']}" == 'on' ]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} "--debug-exec" )
    fi
    if [ "${MD_DEFAULT['relax-sec']}" == 'on' ]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} "--relax-security" )
    fi
    if [ "${MD_DEFAULT['untraceable']}" == 'on' ]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} "--untraceable" )
    fi
    if [ "${MD_DEFAULT['hardened']}" == 'on' ]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} "--hardened" )
    fi
    if [ "${MD_DEFAULT['busybox']}" == 'on' ]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} "--busybox" )
    fi
    if [ "${MD_DEFAULT['keep-c-code']}" == 'on' ]; then
        local ARGUMENTS=( ${ARGUMENTS[@]} "--keep-source-code" )
    fi
    if [[ ${MD_DEFAULT['compose']} == 'on' ]]; then
        if [ ! -z "${MD_DEFAULT['compose-dirs']}" ]; then
            for dir_path in `echo ${MD_DEFAULT['compose-dirs']} | tr ',' ' '`; do
                local ARGUMENTS=( ${ARGUMENTS[@]} "--compose-directory=$dir_path" )
            done
        fi
        if [ ! -z "${MD_DEFAULT['compose-fls']}" ]; then
            for file_path in `echo ${MD_DEFAULT['compose-fls']} | tr ',' ' '`; do
                local ARGUMENTS=( ${ARGUMENTS[@]} "--compose-file=$file_path" )
            done
        fi
    fi
    echo -n "${ARGUMENTS[@]}"
    return $?
}
