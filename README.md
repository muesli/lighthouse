# Modular Case

The plan is to design a fully modular case for home-made ESP8266 devices, like temperature or motion sensors, information monitors etc.

Supported bases:
- NodeMCU
- Wemos D1 Mini

Supported modules:
- OLED
    - 0.96"
    - 1.3"
- TFT
- Temperature sensors
    - DHT11/22
- Motion sensors
    - HC-SR501
- Switch
- LED
- Battery
    - 9V block
- Spacer

Supported caps:
- LED Dome

================

Existing case: https://www.thingiverse.com/thing:2627220

Current issues with this design:

- Only one basis, for the NodeMCU v2
- PIR Motion sensor module has broken hinges (too deep, compare with other modules)
- OLED 0.96" is a tiny bit too small for the revision 2 displays
- Temperature sensor module is a bit small for DHT11 and way too small for DHT22
- A bunch of other modules are still missing
- Designed in Fusion360, but OpenSCAD would be preferred
