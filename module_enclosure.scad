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
enclosure_wall_thickness = 2; //[2:1:5]
// height of the enclosure
enclosure_height = 15; //[10:3:100]
// length of the enclosure
enclosure_length = 40; //[10:5:100]
// width of the enclosure
enclosure_width = 25; //[10:5:100]
// radius of port access
enclosure_port_radius = 4; //[2:1:20]

/* [Venting Holes] */

// amount on x-axis
enclosure_vents_x = 6; //[3:1:10]
// amount on y-axis
enclosure_vents_y = 5; //[3:1:10]
// two-sided vents
enclosure_vents_twosided = false;
/* [Hidden] */

$fn = 256;
base_radius = base_diameter / 2;

use <common.scad>
use <module_empty.scad>

union() {
    difference() {
        empty(base_radius, module_height, wall_thickness);
        venting_holes(90, base_radius, module_height, enclosure_vents_x, enclosure_vents_y, enclosure_vents_twosided);
    }

    enclosure(90, enclosure_length, enclosure_width, base_radius, enclosure_height, enclosure_wall_thickness, enclosure_port_radius);
}
