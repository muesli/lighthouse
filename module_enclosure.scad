// Creates a module with a sensor enclosure

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 3; //[2:1:5]
// height of the module
module_height = 20; //[10:5:100]

/* [Enclosure Dimensions] */

// thickness of outer wall
enclosure_wall_thickness = 3; //[2:1:5]
// height of the enclosure
enclosure_height = 15; //[10:3:100]
// length of the enclosure
enclosure_length = 30; //[10:5:100]
// width of the enclosure
enclosure_width = 20; //[10:5:100]
// radius of port access
enclosure_port_radius = 3; //[2:1:20]

/* [Hidden] */

$fn = 256;
base_radius = base_diameter / 2;

use <common.scad>
use <module_empty.scad>

union() {
    empty(base_radius, module_height, wall_thickness);
	enclosure(90, enclosure_length, enclosure_width, base_radius, enclosure_height, enclosure_wall_thickness, enclosure_port_radius);
}
