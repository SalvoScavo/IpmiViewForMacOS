#!/bin/bash
set -e

Xvfb :1 -screen 0 "${RESOLUTION:-1600x900x24}" &
sleep 1
fluxbox >/dev/null 2>&1 &
x11vnc -display :1 -forever -shared -nopw -rfbport 5900 -quiet &
websockify --web /usr/share/novnc 6080 localhost:5900 >/dev/null 2>&1 &

echo "noVNC pronto su http://localhost:6080"

cd /opt/ipmiview
if [ -f IPMIView20.jar ]; then
  java -jar IPMIView20.jar &
elif [ -x ./IPMIView20 ]; then
  ./IPMIView20 &
else
  echo "IPMIView non trovato in /opt/ipmiview: monta la cartella estratta con -v"
fi

wait