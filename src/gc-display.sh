#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# DISPLAY

function display_banner_file () {
    local CLEAR_SCREEN=${1:-clear-screen-on}
    cat "${MD_DEFAULT['banner-file']}" > "${MD_DEFAULT['tmp-file']}"
    case "$CLEAR_SCREEN" in
        'clear-screen-on')
            clear
            ;;
    esac; echo "${RED} `cat ${MD_DEFAULT['tmp-file']}` ${RESET}"
    return 0
}

function display_banner () {
    local CLEAR_SCREEN=${1:-clear-screen-on}
    display_banner_file "$CLEAR_SCREEN"
    display_script_banner "clear-screen-off"
    return $?
}

function display_formatted_settings () {
    display_formatted_setting_conf_file
    display_formatted_setting_log_file
    display_formatted_setting_target_script
    display_formatted_setting_output_file
    display_formatted_setting_expiration_date
    display_formatted_setting_expiration_message
    display_formatted_setting_compose_files
    display_formatted_setting_compose_dirs
    display_formatted_setting_log_lines
    display_formatted_setting_verbose_flag
    display_formatted_setting_compose_flag
    display_formatted_setting_setuid_flag
    display_formatted_setting_keep_c_code_flag
    display_formatted_setting_debug_exec_flag
    display_formatted_setting_relax_security_flag
    display_formatted_setting_untraceable
    display_formatted_setting_busybox
    display_formatted_setting_hardened
    return 0
}

function display_project_settings () {
    display_formatted_settings | column
    echo; return 0
}

# GENERAL

function display_formatted_setting_expiration_date () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    echo "[ ${CYAN}Expiration Date${RESET}     ]: ${MAGENTA}${MD_DEFAULT['exp-date']:-${RED}Unspecified}${RESET}"
    return $?
}

function display_formatted_setting_expiration_message () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    DISPLAY_MSG="${MD_DEFAULT['exp-msg']}"
    SHORT="${DISPLAY_MSG:0:25}..."
    echo "[ ${CYAN}Expiration Message${RESET}  ]: ${SHORT:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_target_script () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    if [ ! -z ${MD_DEFAULT['target-file']} ]; then
        SHORT=`shorten_file_path "${MD_DEFAULT['target-file']}"`
    else
        SHORT=""
    fi
    echo "[ ${CYAN}Target Shell Script${RESET} ]: ${SHORT:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_output_file () {
    if [ ! -z ${MD_DEFAULT['output-file']} ]; then
        SHORT=`shorten_file_path "${MD_DEFAULT['output-file']}"`
    else
        SHORT=""
    fi
    echo "[ ${CYAN}Output File${RESET}         ]: ${YELLOW}${SHORT:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_compose_files () {
    if [ "${MD_DEFAULT['compose']}" != 'on' ]; then
        return 1
    fi
    DISPLAY_CSV="${MD_DEFAULT['compose-fls']}"
    SHORT="${YELLOW}${DISPLAY_CSV:0:10}${RESET}..."
    echo "[ ${CYAN}Compose Files${RESET}       ]: ${SHORT:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_compose_dirs () {
    if [ "${MD_DEFAULT['compose']}" != 'on' ]; then
        return 1
    fi
    DISPLAY_CSV="${MD_DEFAULT['compose-dirs']}"
    SHORT="${BLUE}${DISPLAY_CSV:0:10}${RESET}..."
    echo "[ ${CYAN}Compose Directories${RESET} ]: ${SHORT:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_verbose_flag () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    FLAG=`format_flag_colors "${MD_DEFAULT['verbose']}"`
    echo "[ ${CYAN}Verbose Compilation${RESET} ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_compose_flag () {
    FLAG=`format_flag_colors "${MD_DEFAULT['compose']}"`
    echo "[ ${CYAN}Compose Mode${RESET}        ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_setuid_flag () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    FLAG=`format_flag_colors "${MD_DEFAULT['setuid']}"`
    echo "[ ${CYAN}SETUID${RESET}              ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_keep_c_code_flag () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    FLAG=`format_flag_colors "${MD_DEFAULT['keep-c-code']}"`
    echo "[ ${CYAN}Keep C Source Code${RESET}  ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_debug_exec_flag () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    FLAG=`format_flag_colors "${MD_DEFAULT['debug-exec']}"`
    echo "[ ${CYAN}Debug Exec Calls${RESET}    ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_relax_security_flag () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    FLAG=`format_flag_colors "${MD_DEFAULT['relax-sec']}"`
    echo "[ ${CYAN}Relax Security${RESET}      ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_untraceable () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    FLAG=`format_flag_colors "${MD_DEFAULT['untraceable']}"`
    echo "[ ${CYAN}Untraceable${RESET}         ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_busybox () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    FLAG=`format_flag_colors "${MD_DEFAULT['busybox']}"`
    echo "[ ${CYAN}Compile For Busybox${RESET} ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_hardened () {
    if [ "${MD_DEFAULT['compose']}" != 'off' ]; then
        return 1
    fi
    FLAG=`format_flag_colors "${MD_DEFAULT['hardened']}"`
    echo "[ ${CYAN}Hardened Build${RESET}      ]: ${FLAG:-${RED}Unspecified${RESET}}"
    return $?
}

function display_formatted_setting_conf_file () {
    if [ ! -z ${MD_DEFAULT['conf-file']} ]; then
        SHORT=`shorten_file_path "${MD_DEFAULT['conf-file']}"`
    else
        SHORT=""
    fi
    echo "[ ${CYAN}Conf File${RESET}           ]: ${YELLOW}${SHORT:-${RED}Unspecified}${RESET}"
    return $?
}

function display_formatted_setting_log_file () {
    if [ ! -z ${MD_DEFAULT['log-file']} ]; then
        SHORT=`shorten_file_path "${MD_DEFAULT['log-file']}"`
    else
        SHORT=""
    fi
    echo "[ ${CYAN}Log File${RESET}            ]: ${YELLOW}${SHORT:-${RED}Unspecified}${RESET}"
    return $?
}

function display_formatted_setting_log_lines () {
    echo "[ ${CYAN}Log Lines${RESET}           ]: ${WHITE}${MD_DEFAULT['log-lines']:-${RED}Unspecified}${RESET} lines"
    return $?
}

# CODE DUMP

