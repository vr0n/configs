#!/bin/bash

TARGET="/sys/class/backlight/intel_backlight"
MAX="$(cat ${TARGET}"/max_brightness")"
CURRENT="$(cat ${TARGET}"/brightness")"
BRIGHTNESS="${TARGET}""/brightness"
STEPS="10"

echo "${BRIGHTNESS}"
exit 1

if [ -w "${BRIGHTNESS}" ]; then
  if [[ "${1}" == "add" ]]; then
    (( CURRENT += "${STEPS}" ))
  fi

  if [[ "${1}" == "del" ]]; then
    (( CURRENT -= "${STEPS}" ))
  fi

  if [[ "${CURRENT}" -gt "${MAX}" ]];then
    exit;
  fi

  if [[ "${CURRENT}" -lt 1 ]]; then
    CURRENT = 0
  fi

  echo "${CURRENT}" > "${BRIGHTNESS}"
else
  sudo chmod 646 "${BRIGHTNESS}"
fi
