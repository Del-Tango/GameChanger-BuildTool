#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# ACTIONS

function action_change_the_game () {
    ARGUMENTS=( `format_game_changer_arguments` )
    debug_msg "(${BLUE}$SCRIPT_NAME${RESET}) arguments"\
        "(${MAGENTA}${ARGUMENTS[@]}${RESET})"
#   trap 'trap - SIGINT SIGTERM SIGHUP; echo ''[ SIGINT ]: Game Changer Terminated.''; return 0' SIGINT SIGTERM SIGHUP
    echo; ${GC_CARGO['game-changer']} ${ARGUMENTS[@]}
    return $?
}

function action_set_expiration_date () {
    echo; info_msg "Type expiration date (dd/mm/yyyy)"\
        "or (${MAGENTA}.back${RESET})."
    XDATE=`fetch_data_from_user 'ExpiresOn'`
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_expiration_date "$XDATE"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set expiration date (${GREEN}$XDATE${RESET})."
    else
        ok_msg "Successfully set expiration date (${GREEN}$XDATE${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_expiration_message () {
    echo; info_msg "Type message to display past expiration date"\
        "or (${MAGENTA}.back${RESET})."
    XMSG=`fetch_data_from_user 'Message'`
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_expiration_message "$XMSG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set expiration message"\
            "(${RED}${XMSG:0:10}${RESET}...)."
    else
        ok_msg "Successfully set expiration message"\
            "(${GREEN}${XMSG:0:10}${RESET}...)."
    fi
    return $EXIT_CODE
}

function action_set_compose_files () {
    echo; info_msg "Type compose files as comma separated paths"\
        "or (${MAGENTA}.back${RESET}) -"
    info_msg "Setting compose files to (${MAGENTA}-${RESET})"\
        "remove the previous value."
    symbol_msg "${BLUE}EXAMPLE${RESET}" \
        "${GREEN}/path/to/file1,/path/to/file2,/path/to/file3${RESET}..."\
        "or ${GREEN}-${RESET}"
    CFILES=`fetch_data_from_user 'FilePaths'`
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    if [[ "$CFILES" == '-' ]]; then
        CFILES=''
    fi
    set_compose_file_paths "$CFILES"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set compose file paths (${RED}$CFILES${RESET})."
    else
        ok_msg "Successfully set compose file paths"\
            "(${GREEN}$CFILES${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_compose_directories () {
    echo; info_msg "Type compose directories as comma separated paths"\
        "or (${MAGENTA}.back${RESET}) -"
    info_msg "Setting compose directories to (${MAGENTA}-${RESET})"\
        "remove the previous value."
    symbol_msg "${BLUE}EXAMPLE${RESET}" \
        "${GREEN}/path/to/dir1,/path/to/dir2,/path/to/dir3${RESET}..."\
        "or ${GREEN}-${RESET}"
    CDIRS=`fetch_data_from_user 'DirPaths'`
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    if [[ "$CDIRS" == '-' ]]; then
        CDIRS=''
    fi
    set_compose_directory_paths "$CDIRS"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set compose directory paths (${RED}$CDIRS${RESET})."
    else
        ok_msg "Successfully set compose directory paths"\
            "(${GREEN}$CDIRS${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_target_script () {
    echo; info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        if [ $? -ne 0 ]; then
            echo; info_msg "Aborting action."
            return 0
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            echo; warning_msg "File (${RED}$FILE_PATH${RESET}) does not exists."
            echo
        fi; break
    done
    set_target_file "$FILE_PATH"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) target shell script."
    else
        ok_msg "Successfully set target shell script (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_output_file () {
    echo; info_msg "Type absolute file path or (${MAGENTA}.back${RESET})."
    FILE_PATH=`fetch_data_from_user 'FilePath'`
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    set_output_file "$FILE_PATH"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set (${RED}$FILE_PATH${RESET}) as"\
            "(${BLUE}$SCRIPT_NAME${RESET}) output file."
    else
        ok_msg "Successfully set output file (${GREEN}$FILE_PATH${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_hardened_build () {
    echo; info_msg "Bourne Shell (sh) scripts required -"
    fetch_ultimatum_from_user \
        "Should binary be protected against dumping, code injection, cat /proc/pid/cmdline, ptrace, etc..? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_hardened_build_flag "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set hardened build flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set hardened build flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_verbose_flag () {
    echo; fetch_ultimatum_from_user \
        "Do you want more verbose output during compilation? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_verbose_flag "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set verbose flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set verbose flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_compose_mode () {
    echo; fetch_ultimatum_from_user \
        "Do you want to compose a single shell script from multiple files instead of compiling one? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_compose_mode "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set compose mode flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set compose mode flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_setuid_flag () {
    echo; fetch_ultimatum_from_user \
        "Should the Game Changer switch on SETUID for root callable programs? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_setuid_flag "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set SETUID flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set SETUID flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_keep_c_code () {
    echo; fetch_ultimatum_from_user \
        "Do you want to keep the C source code used to compile the binary? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_keep_c_code "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set keep C code flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set keep C code flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_debug_exec () {
    echo; fetch_ultimatum_from_user \
        "Should the Game Changer switch on debug exec calls? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_debug_exec "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set debug exec flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set debug exec flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_relax_security () {
    echo; fetch_ultimatum_from_user \
        "Should the Game Changer relax security and make a redistributable binary? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_relax_security "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set relax security flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set relax security flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_untraceable () {
    echo; fetch_ultimatum_from_user \
        "Make binary be untraceable by tools like strace, ptrace, truss? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_untraceable "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set untraceable flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set untraceable flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_set_build_for_busybox () {
    echo; fetch_ultimatum_from_user \
        "Should the Game Changer compile your script for busybox? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        local FLAG='off'
    else
        local FLAG='on'
    fi
    set_build_for_busybox "$FLAG"
    EXIT_CODE=$?
    echo; if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set compile for busybox flag (${RED}$FLAG${RESET})."
    else
        ok_msg "Successfully set compile for busybox flag (${GREEN}$FLAG${RESET})."
    fi
    return $EXIT_CODE
}

function action_project_self_destruct () {
    echo; info_msg "You are about to delete all (${RED}$SCRIPT_NAME${RESET})"\
        "project files from directory (${RED}${MD_DEFAULT['project-path']}${RESET})."
    fetch_ultimatum_from_user "${YELLOW}Are you sure about this? Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 0
    fi
    check_safety_on
    if [ $? -ne 0 ]; then
        echo; warning_msg "Safety is (${GREEN}ON${RESET})!"\
            "Aborting self destruct sequence."
        return 0
    fi; echo
    symbol_msg "${RED}$SCRIPT_NAME${RESET}" "Initiating self destruct sequence!"
    action_self_destruct
    local EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "(${RED}$SCRIPT_NAME${RESET}) self destruct sequence failed!"
    else
        ok_msg "Destruction complete!"\
            "Project (${GREEN}$SCRIPT_NAME${RESET}) removed from system."
    fi
    return $EXIT_CODE
}
