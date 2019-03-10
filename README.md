# Modular Case

The plan is to design a fully modular case for home-made ESP8266/Arduino/Raspberry Pi devices, like temperature or motion sensors, information monitors etc.

![assembly animation](https://muesli.github.io/modular-case/assembly.gif)

## Call for help
This is still a work in progress! Know OpenSCAD and want to contribute? Check out the issue tracker, pick a ticket and let everyone know you started working on it!

- IRC: irc://irc.freenode.net/#modular-case
- Thingiverse: https://www.thingiverse.com/thing:3391397

## Bases
- Work in progress:
    - NodeMCU Amica v2, e.g. https://www.amazon.de/dp/B06Y1LZLLY
    - NodeMCU Lolin v3, e.g. https://www.amazon.de/dp/B06Y1ZPNMS
    - Wemos D1 Mini
    - Various Arduino boards
- Planned:
    - (with optional large base): Raspberry Pi
    - ...

## Modules
- Work in progress:
    - Displays
        - OLED 0.96", e.g. https://www.amazon.de/dp/B01L9GC470
        - OLED 1.3", e.g. https://www.amazon.de/dp/B078J78R45
    - Temperature sensors
        - DHT11/22
        - BMP180, BMP280, BME280
    - Battery
        - 9V block
    - Spacer
- Planned:
    - Displays
        - TFT
    - Motion sensors
        - HC-SR501, e.g. https://www.amazon.de/dp/B07CNBYRQ7
    - Switch
    - LED
    - ...

## Caps
- Work in progress:
    - LED dome
- Planned:
    - Flat cap
    - ...

## Rendered animations

#### Small Base for NodeMCU v2
![base animation](https://muesli.github.io/modular-case/base.gif)

#### Dome Cap
![dome cap animation](https://muesli.github.io/modular-case/cap_dome.gif)

#### Sensor Enclosure Module
![enclosure module animation](https://muesli.github.io/modular-case/module_enclosure.gif)

#### OLED Module
![OLED module animation](https://muesli.github.io/modular-case/module_oled.gif)

#### Empty Spacer Module
![empty module animation](https://muesli.github.io/modular-case/module_empty.gif)

## Further ideas
- Add cable ducts to modules
- The node MCU and other boards as well have mounting holes, use them for better support in the base
- The PCB modules could be fit a little bit tighter into their respective casing making it easier e.g. to push a button from the outside
- How to handle larger modules than radius of base?
- Conversion modules between the large and small diameters

## Precursor of this design

This design is inspired by https://www.thingiverse.com/thing:2627220 and strives to remain compatible with it.
