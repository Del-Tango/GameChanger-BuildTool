#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# SETUP

# LOADERS

function load_config () {
    load_project_label
    load_project_prompt
    load_project_safety
    load_settings_default
    load_project_logging_levels
    load_project_cargo
    load_dependencies
}

function load_dependencies () {
    load_apt_dependencies ${GC_APT_DEPENDENCIES[@]}
    return $?
}

function load_project_prompt () {
    load_prompt_string "$GC_PS3"
    return $?
}

function load_project_safety () {
    load_safety "$GC_SAFETY"
    return $?
}

function load_project_logging_levels () {
    load_logging_levels ${GC_LOGGING_LEVELS[@]}
    return $?
}

function load_safety () {
    load_safety "$GC_SAFETY"
    return $?
}

function load_project_cargo () {
    if [ ${#GC_CARGO[@]} -eq 0 ]; then
        warning_msg "No cargo scripts found docked to $GC_SCRIPT_NAME."
        return 1
    fi
    for cargo in ${!GC_CARGO[@]}; do
        load_cargo "$cargo" ${GC_CARGO[$cargo]}
    done
    return $?
}

function load_settings_default () {
    for setting in ${!GC_DEFAULT[@]}; do
        load_default_setting "$setting" ${GC_DEFAULT[$setting]}
    done
    return $?
}

function load_project_label () {
    load_script_name "$GC_SCRIPT_NAME"
    return $?
}

# PROJECT SETUP

function project_setup () {
    lock_and_load
    load_config
    create_menu_controllers
    setup_menu_controllers
}

function setup_menu_controllers () {
    setup_dependencies
    setup_main_menu_controller
    setup_log_viewer_menu_controller
    setup_game_changer_menu_controller
    setup_settings_menu_controller
    done_msg "${BLUE}$SCRIPT_NAME${RESET} controller setup complete."
    return 0
}

# SETUP DEPENDENCIES

function setup_dependencies () {
    apt_install_dependencies
    pip3_install_dependencies
    return $?
}

# LOG VIEWER SETUP

function setup_log_viewer_menu_controller () {
    setup_log_viewer_menu_option_display_tail
    setup_log_viewer_menu_option_display_head
    setup_log_viewer_menu_option_display_more
    setup_log_viewer_menu_option_clear_log
    setup_log_viewer_menu_option_back
    done_msg "(${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_log_viewer_menu_option_clear_log () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Clear-Log' 'action_clear_log_file'
    return $?
}

function setup_log_viewer_menu_option_display_tail () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Display-Tail' 'action_log_view_tail'
    return $?
}

function setup_log_viewer_menu_option_display_head () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Display-Head' 'action_log_view_head'
    return $?
}

function setup_log_viewer_menu_option_display_more () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Display-More' 'action_log_view_more'
    return $?
}

function setup_log_viewer_menu_option_back () {
    setup_menu_controller_action_option \
        "$LOGVIEWER_CONTROLLER_LABEL"  'Back' 'action_back'
    return $?
}

# GAME CHANGER SETUP

function setup_game_changer_menu_controller () {
    setup_game_changer_menu_option_change_the_game
    setup_game_changer_menu_option_help
    setup_game_changer_menu_option_back
    done_msg "(${CYAN}$GAME_CHANGER_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_game_changer_menu_option_change_the_game () {
    setup_menu_controller_action_option \
        "$GAME_CHANGER_CONTROLLER_LABEL"  "Change-The-Game" \
        "action_change_the_game"
    return $?
}

function setup_game_changer_menu_option_help () {
    setup_menu_controller_action_option \
        "$GAME_CHANGER_CONTROLLER_LABEL"  "Help" \
        "action_help"
    return $?
}

function setup_game_changer_menu_option_back () {
    setup_menu_controller_action_option \
        "$GAME_CHANGER_CONTROLLER_LABEL"  "Back" \
        "action_back"
    return $?
}

# SETTINGS SETUP

function setup_settings_menu_controller () {
    setup_settings_menu_option_set_safety_on
    setup_settings_menu_option_set_safety_off
    setup_settings_menu_option_set_log_file
    setup_settings_menu_option_set_log_lines
    setup_settings_menu_option_set_temporary_file
    setup_settings_menu_option_install_dependencies
    setup_settings_menu_option_back
    setup_settings_menu_option_set_target_script
    setup_settings_menu_option_set_output_file
    setup_settings_menu_option_set_expiration_date
    setup_settings_menu_option_set_expiration_message
    setup_settings_menu_option_set_compose_files
    setup_settings_menu_option_set_compose_directories
    setup_settings_menu_option_set_verbose_flag
    setup_settings_menu_option_set_compose_flag
    setup_settings_menu_option_set_setuid_flag
    setup_settings_menu_option_set_keep_c_code_flag
    setup_settings_menu_option_set_debug_exec_flag
    setup_settings_menu_option_set_relax_security_flag
    setup_settings_menu_option_set_untraceable_flag
    setup_settings_menu_option_set_build_for_busybox_flag
    setup_settings_menu_option_set_hardened_build_flag
    done_msg "(${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_settings_menu_option_set_hardened_build_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Hardened-Build' \
        'action_set_hardened_build'
    return $?
}

function setup_settings_menu_option_set_target_script () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Target-Script' \
        'action_set_target_script'
    return $?
}

function setup_settings_menu_option_set_output_file () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Output-File' \
        'action_set_output_file'
    return $?
}

function setup_settings_menu_option_set_expiration_date () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Expiration-Date' \
        'action_set_expiration_date'
    return $?
}

function setup_settings_menu_option_set_expiration_message () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Expiration-Msg' \
        'action_set_expiration_message'
    return $?
}

function setup_settings_menu_option_set_compose_files () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Compose-Files' \
        'action_set_compose_files'
    return $?
}

function setup_settings_menu_option_set_compose_directories () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Compose-Dirs' \
        'action_set_compose_directories'
    return $?
}

function setup_settings_menu_option_set_verbose_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Verbose-Flag' \
        'action_set_verbose_flag'
    return $?
}

function setup_settings_menu_option_set_compose_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Compose-Mode' \
        'action_set_compose_mode'
    return $?
}

function setup_settings_menu_option_set_setuid_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-SETUID-Flag' \
        'action_set_setuid_flag'
    return $?
}

function setup_settings_menu_option_set_keep_c_code_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Keep-C-Code' \
        'action_set_keep_c_code'
    return $?
}

function setup_settings_menu_option_set_debug_exec_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Debug-Exec' \
        'action_set_debug_exec'
    return $?
}

function setup_settings_menu_option_set_relax_security_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Relax-Security' \
        'action_set_relax_security'
    return $?
}

function setup_settings_menu_option_set_untraceable_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Untraceable' \
        'action_set_untraceable'
    return $?
}

function setup_settings_menu_option_set_build_for_busybox_flag () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Build-For-Busybox' \
        'action_set_build_for_busybox'
    return $?
}

function setup_settings_menu_option_set_safety_on () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Safety-ON' \
        'action_set_safety_on'
    return $?
}

function setup_settings_menu_option_set_safety_off () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Safety-OFF' \
        'action_set_safety_off'
    return $?
}

function setup_settings_menu_option_set_temporary_file () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Temporary-File' \
        'action_set_temporary_file'
    return $?
}

function setup_settings_menu_option_set_log_file () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Log-File' \
        'action_set_log_file'
    return $?
}

function setup_settings_menu_option_set_log_lines () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Set-Log-Lines' \
        'action_set_log_lines'
    return $?
}

function setup_settings_menu_option_install_dependencies () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Install-Dependencies' \
        'action_install_dependencies'
    return $?
}

function setup_settings_menu_option_back () {
    setup_menu_controller_action_option \
        "$SETTINGS_CONTROLLER_LABEL" 'Back' 'action_back'
    return $?
}

# MAIN MENU SETUP

function setup_main_menu_controller() {
    setup_main_menu_option_game_changer
    setup_main_menu_option_self_destruct
    setup_main_menu_option_log_viewer
    setup_main_menu_option_control_panel
    setup_main_menu_option_back
    done_msg "(${CYAN}$MAIN_CONTROLLER_LABEL${RESET}) controller"\
        "option binding complete."
    return 0
}

function setup_main_menu_option_log_viewer () {
    setup_menu_controller_menu_option \
        "$MAIN_CONTROLLER_LABEL"  "Log-Viewer" \
        "$LOGVIEWER_CONTROLLER_LABEL"
    return $?
}

function setup_main_menu_option_control_panel () {
    setup_menu_controller_menu_option \
        "$MAIN_CONTROLLER_LABEL"  "Control-Panel" \
        "$SETTINGS_CONTROLLER_LABEL"
    return $?
}

function setup_main_menu_option_back () {
    setup_menu_controller_action_option \
        "$MAIN_CONTROLLER_LABEL"  "Back" \
        'action_back'
    return $?
}

function setup_main_menu_option_game_changer () {
    setup_menu_controller_menu_option \
        "$MAIN_CONTROLLER_LABEL"  "Game-Changer" \
        "$GAME_CHANGER_CONTROLLER_LABEL"
    return $?
}

function setup_main_menu_option_self_destruct () {
    setup_menu_controller_action_option \
        "$MAIN_CONTROLLER_LABEL"  "Self-Destruct" \
        'action_project_self_destruct'
    return $?
}




