# Modular Case

The plan is to design a fully modular case for home-made ESP8266/Arduino devices, like temperature or motion sensors, information monitors etc.

This is a work in progress: https://github.com/muesli/modular-case

## Word of Advice
The latest official OpenSCAD release is 2015.03-3 (from almost four years ago). This release renders the design incorrectly. Please use a newer OpenSCAD version from git: https://github.com/openscad/openscad

## Supported bases
- NodeMCU Amica v2, e.g. https://www.amazon.de/dp/B06Y1LZLLY
- NodeMCU Lolin v3, e.g. https://www.amazon.de/dp/B06Y1ZPNMS
- Wemos D1 Mini
- ...

## Supported modules
- Displays
    - OLED 0.96", e.g. https://www.amazon.de/dp/B01L9GC470
    - OLED 1.3", e.g. https://www.amazon.de/dp/B078J78R45
    - TFT
- Temperature sensors
    - DHT11/22
- Motion sensors
    - HC-SR501, e.g. https://www.amazon.de/dp/B07CNBYRQ7
- Switch
- LED
- Battery
    - 9V block
- Spacer
- ...

## Supported caps
- LED dome
- ...

## Further ideas
- Translate the fusion360 model to english language description
- Add cable ducts to modules
- The node MCU and other boards as well have mounting holes, use them for better support in the base
- The PCB modules could be fit a little bit tighter into their respective casing making it easier e.g. to push a button from the outside
- How to handle larger modules than radius of base?
    - <fribbledom> i see two options here:
        1. offer larger base sizes, that shrink in diameter towards the top, so we end up with the same module connectors
         2. if there's also a need for larger modules, we could offer a large  & small version of each module fairly easily (hooray parameterized  design)

## Hardware specs
- NodeMCU v2 (from original): 48mm (L) x 26mm (W) x 13mm (H)
  - position of mounting holes? ground and height clearance needed?

## Next steps

1. Create OpenSCAD parts of the model, roughly based on the existing design (see below)
2. Create modules from parts
3. Profit!

## Existing design

Current issues with this design: https://www.thingiverse.com/thing:2627220

- Only one basis, for the NodeMCU v2
- PIR Motion sensor module has broken hinges (too deep, compare with other modules)
- OLED 0.96" is a tiny bit too small for the revision 2 displays
- Temperature sensor module is a bit small for DHT11 and way too small for DHT22
- A bunch of other modules are still missing
- Designed in Fusion360, OpenSCAD (open source/FOSS) would be preferred
