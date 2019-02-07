// Unfortunately, customizable parameters have to be in the main file,
// although they are used in the libraries

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 3; //[2:1:5]

/* [Base Module] */

// width of a PCB
board_width = 26; //[18:Arduino_Nano, 23:Feather_HUZZAH, 26:NodeMCUv2, 30:Raspberry_Pi_ZeroW, 31:NodeMCUv3, 53.3:Arduino_Mega, 53.4:Arduino_Uno]
// length of a PCB
board_length = 48; //[45:Arduino_Nano, 48:NodeMCUv2, 51:NodeMCUv3, 51:Feather_HUZZAH, 65:Raspberry_Pi_ZeroW, 68.6:Arduino_Uno, 101.52:Arduino_Mega]

// width of the port hole for e.g. USB access
port_width = 10; //[5:1:50]
// height of the port hole for e.g. USB access
port_height = 6; //[4:1:30]

/* [Empty Module] */

// create an empty module
create_empty = true;

// height of the empty module
empty_height = 30; // [10:1:60]

/* [OLED Module] */
create_oled = true;

// width of the display
oled_width = 26; //[10:1:100]
// height of the display
oled_height = 13; //[10:1:100]
// width of the pcb
oled_pcb_width = 27; //[10:1:100]
// height of the pcb
oled_pcb_height = 27; //[10:1:100]
//position of the display (lower edge)
oled_y_position = 6.5;

/* [Sensor enclosure] */ 
create_enclosure = true;

// thickness of outer wall
enclosure_wall_thickness = 2; //[2:1:5]
// height of the enclosure
enclosure_height = 15; //[10:3:100]
// length of the enclosure
enclosure_length = 40; //[10:5:100]
// width of the enclosure
enclosure_width = 25; //[10:5:100]
// radius of port access
enclosure_port_radius = 4; //[2:1:20]

/* [Hidden] */

$fn = 256;
base_radius = base_diameter / 2;

use <base.scad>
use <module_empty.scad>
use <module_oled.scad>
use <module_enclosure.scad>

oled_module_start = create_empty?base_height()+empty_height:base_height();
enclosure_module_start = create_oled?oled_module_start+oled_module_height():oled_module_start;

union() {
	base(base_radius, wall_thickness, board_length, board_width, port_width, port_height);
	if (create_empty)
		translate([0,0,empty_height])
			empty(base_radius, empty_height, wall_thickness);
	if (create_oled)
		translate([0,0,oled_module_start])
			oled(base_radius, wall_thickness, oled_width, oled_height, oled_pcb_width, oled_pcb_height, oled_y_position);
    if (create_enclosure)
		translate([0,0,enclosure_module_start])
    		sensor_enclosure(enclosure_length, enclosure_width, base_radius, enclosure_height, enclosure_wall_thickness, enclosure_port_radius);

}
