#!/command/with-contenv bashio
set -euo pipefail

MIC_COMMAND="$(bashio::config 'mic_command')"
SND_COMMAND="$(bashio::config 'snd_command')"
URI="$(bashio::config 'uri')"
WAKE_URI="$(bashio::config 'wake_uri')"
WAKE_WORD_NAME="$(bashio::config 'wake_word_name')"
DEBUG="$(bashio::config 'debug')"

ARGS=( --uri "$URI"
       --mic-command "$MIC_COMMAND"
       --snd-command "$SND_COMMAND"
       --wake-uri "$WAKE_URI"
       --wake-word-name "$WAKE_WORD_NAME" )

if [ "$DEBUG" = "true" ]; then
  ARGS+=( --debug )
fi

exec python3 -m wyoming_satellite "${ARGS[@]}"
