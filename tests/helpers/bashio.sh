# shellcheck shell=bash
# Mock of /usr/lib/bashio/bashio.sh — defines only the functions our
# scripts use. Reads options from $HASSIO_OPTIONS_FILE (JSON).

bashio::config() {
    jq -r --arg k "$1" '.[$k] // empty' "$HASSIO_OPTIONS_FILE"
}

bashio::config.true() {
    [[ "$(jq -r --arg k "$1" '.[$k]' "$HASSIO_OPTIONS_FILE")" == "true" ]]
}

bashio::config.has_value() {
    local v
    v=$(jq -r --arg k "$1" '.[$k] // empty' "$HASSIO_OPTIONS_FILE")
    [[ -n "$v" && "$v" != "null" ]]
}

bashio::var.is_empty() {
    [[ -z "$1" ]]
}

bashio::log.info()    { echo "[INFO] $*"; }
bashio::log.warning() { echo "[WARN] $*"; }
bashio::log.error()   { echo "[ERROR] $*" >&2; }
bashio::log.fatal()   { echo "[FATAL] $*" >&2; }
