#!/bin/sh
set -e

mkdir -p build/animation

DISPLAY=:0 openscad --colorscheme=BeforeDawn --imgsize 640,480 --animate 256 -o build/animation/frame.png -Dpreview=true -Dboard=5 base.scad
convert build/animation/frame*.png -set delay 1x32 build/base.mp4
rm -Rf build/animation

#          xvfb-run --auto-servernum --server-args "-screen 0 1024x768x24" python -u ./scripts/generate_gif.py assembly.scad assembly.gif 400 75 55
#          mv build/animation/assembly.gif build/
#          xvfb-run --auto-servernum --server-args "-screen 0 1024x768x24" python -u ./scripts/generate_gif.py module_empty.scad module_empty.gif
#          mv build/animation/module_empty.gif build/
#          xvfb-run --auto-servernum --server-args "-screen 0 1024x768x24" python -u ./scripts/generate_gif.py module_enclosure.scad module_enclosure.gif
#          mv build/animation/module_enclosure.gif build/
#          xvfb-run --auto-servernum --server-args "-screen 0 1024x768x24" python -u ./scripts/generate_gif.py module_oled.scad module_oled.gif
#          mv build/animation/module_oled.gif build/
#          xvfb-run --auto-servernum --server-args "-screen 0 1024x768x24" python -u ./scripts/generate_gif.py module_pir.scad module_pir.gif
#          mv build/animation/module_pir.gif build/
#          xvfb-run --auto-servernum --server-args "-screen 0 1024x768x24" python -u ./scripts/generate_gif.py cap_dome.scad cap_dome.gif
#          mv build/animation/cap_dome.gif build/
#          xvfb-run --auto-servernum --server-args "-screen 0 1024x768x24" python -u ./scripts/generate_gif.py cap_flat.scad cap_flat.gif
#          mv build/animation/cap_flat.gif build/
#          rm -Rf build/animation
#          find build
