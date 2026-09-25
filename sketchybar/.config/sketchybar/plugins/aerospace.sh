#!/bin/bash
# Focused workspace: surface0 pill, sky label, SemiBold. Others: Regular
# overlay text on the shared base rail.

SKY=0xff8BD3FF
OVERLAY2=0xffAAACB7

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on label.color=$SKY \
                           label.font="Maple Mono NF:SemiBold:13.0"
else
  sketchybar --set "$NAME" background.drawing=off label.color=$OVERLAY2 \
                           label.font="Maple Mono NF:Regular:13.0"
fi
