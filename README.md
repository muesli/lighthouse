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
    - Raspberry Pi
    - ...

## Modules
- Work in progress:
    - Displays
        - OLED 0.96", e.g. https://www.amazon.de/dp/B01L9GC470
        - OLED 1.3", e.g. https://www.amazon.de/dp/B078J78R45
    - Motion sensors
        - HC-SR501, e.g. https://www.amazon.de/dp/B07CNBYRQ7
    - Temperature sensors
        - DHT11/22
        - BMP180, BMP280, BME280
    - Battery
        - 9V block
    - Spacer
- Planned:
    - Displays
        - TFT
    - Switch
    - LED
    - ...

## Caps
- Work in progress:
    - LED dome
- Planned:
    - Flat cap
    - ...

## STL Downloads

### Bases

![base animation](https://muesli.github.io/modular-case/base.gif)

Diameter 62.8mm:
- [NodeMCU v2 Base](https://muesli.github.io/modular-case/base_62.8mm_board5.stl)

Diameter 67mm:
- [NodeMCU v2 Base](https://muesli.github.io/modular-case/base_67mm_board5.stl)
- [NodeMCU v3 Base](https://muesli.github.io/modular-case/base_67mm_board6.stl)

Diameter 80mm:
- [NodeMCU v2 Base](https://muesli.github.io/modular-case/base_80mm_board5.stl)
- [NodeMCU v3 Base](https://muesli.github.io/modular-case/base_80mm_board6.stl)

### Caps

![dome cap animation](https://muesli.github.io/modular-case/cap_dome.gif)

Diameter 62.8mm:
- [Dome Cap](https://muesli.github.io/modular-case/cap_62.8mm_dome.stl)

Diameter 67mm:
- [Dome Cap](https://muesli.github.io/modular-case/cap_67mm_dome.stl)

Diameter 80mm:
- [Dome Cap](https://muesli.github.io/modular-case/cap_80mm_dome.stl)

### OLED Module

![OLED module animation](https://muesli.github.io/modular-case/module_oled.gif)

Diameter 62.8mm:
- [0.96" Display](https://muesli.github.io/modular-case/module_62.8mm_oled1.stl)
- [1.3" Display](https://muesli.github.io/modular-case/module_62.8mm_oled2.stl)

Diameter 67mm:
- [0.96" Display](https://muesli.github.io/modular-case/module_67mm_oled1.stl)
- [1.3" Display](https://muesli.github.io/modular-case/module_67mm_oled2.stl)

Diameter 80mm:
- [0.96" Display](https://muesli.github.io/modular-case/module_80mm_oled1.stl)
- [1.3" Display](https://muesli.github.io/modular-case/module_80mm_oled2.stl)

### PIR Motion Sensor Module

![PIR motion sensor module animation](https://muesli.github.io/modular-case/module_pir.gif)

Diameter 62.8mm:
- [PIR Module](https://muesli.github.io/modular-case/module_62.8mm_pir.stl)

Diameter 67mm:
- [PIR Module](https://muesli.github.io/modular-case/module_67mm_pir.stl)

Diameter 80mm:
- [PIR Module](https://muesli.github.io/modular-case/module_80mm_pir.stl)

### Sensor Enclosure Module

![enclosure module animation](https://muesli.github.io/modular-case/module_enclosure.gif)

Diameter 62.8mm:
- [Sensor enclosure](https://muesli.github.io/modular-case/module_62.8mm_enclosure.stl)

Diameter 67mm:
- [Sensor enclosure](https://muesli.github.io/modular-case/module_67mm_enclosure.stl)

Diameter 80mm:
- [Sensor enclosure](https://muesli.github.io/modular-case/module_80mm_enclosure.stl)

### Empty Spacer Module

![empty module animation](https://muesli.github.io/modular-case/module_empty.gif)

Diameter 62.8mm:
- [Empty Spacer](https://muesli.github.io/modular-case/module_62.8mm_empty.stl)

Diameter 67mm:
- [Empty Spacer](https://muesli.github.io/modular-case/module_67mm_empty.stl)

Diameter 80mm:
- [Empty Spacer](https://muesli.github.io/modular-case/module_80mm_empty.stl)

## Further ideas
- The node MCU and other boards as well have mounting holes, use them for better support in the base
- Add cable ducts to modules
- The PCB modules could be fit a little bit tighter into their respective casing making it easier e.g. to push a button from the outside
- Conversion modules between the large and small diameters

## Precursor of this design

This design is inspired by https://www.thingiverse.com/thing:2627220 and strives to remain compatible with it.
