#!/bin/bash

set -euxo pipefail

cp xmodmap ~/.xmodmap
cp xmodmap.desktop ~/.config/autostart/xmodmap.desktop

xmodmap ~/.xmodmap
