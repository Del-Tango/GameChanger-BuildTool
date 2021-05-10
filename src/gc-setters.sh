#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# SETTERS

function set_hardened_build_flag () {
    local FLAG="$1"
    MD_DEFAULT['hardened']="$FLAG"
    return 0
}

function set_expiration_message () {
    local XMSG="$1"
    MD_DEFAULT['exp-msg']="$XMSG"
    return 0
}

function set_expiration_date () {
    local XDATE="$1"
    MD_DEFAULT['exp-date']="$XDATE"
    return 0
}

function set_compose_directory_paths () {
    local CSV_DIRS="$1"
    MD_DEFAULT['compose-dirs']="$CSV_DIRS"
    return 0
}

function set_compose_file_paths () {
    local CSV_FILES="$1"
    MD_DEFAULT['compose-fls']="$CSV_FILES"
    return 0
}

function set_output_file () {
    local OFILE="$1"
    MD_DEFAULT['output-file']="$OFILE"
    return 0
}

function set_target_file () {
    local TFILE="$1"
    MD_DEFAULT['target-file']="$TFILE"
    return 0
}

function set_verbose_flag () {
    local FLAG="$1"
    MD_DEFAULT['verbose']="$FLAG"
    return 0
}

function set_compose_mode () {
    local FLAG="$1"
    MD_DEFAULT['compose']="$FLAG"
    return 0
}

function set_setuid_flag () {
    local FLAG="$1"
    MD_DEFAULT['setuid']="$FLAG"
    return 0
}

function set_keep_c_code () {
    local FLAG="$1"
    MD_DEFAULT['keep-c-code']="$FLAG"
    return 0
}

function set_debug_exec () {
    local FLAG="$1"
    MD_DEFAULT['debug-exec']="$FLAG"
    return 0
}

function set_relax_security () {
    local FLAG="$1"
    MD_DEFAULT['relax-sec']="$FLAG"
    return 0
}

function set_untraceable () {
    local FLAG="$1"
    MD_DEFAULT['untraceable']="$FLAG"
    return 0
}

function set_build_for_busybox () {
    local FLAG="$1"
    MD_DEFAULT['busybox']="$FLAG"
    return 0
}


