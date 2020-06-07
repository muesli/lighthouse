// Creates a module with a sensor enclosure

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 2; //[2:0.5:5]
// height of the module
module_height = 18; //[18:1:100]

/* [Enclosure Dimensions] */

// thickness of outer wall
enclosure_wall_thickness = 2; //[2:1:5]
// height of the enclosure
enclosure_height = 15; //[12:1:100]
// length of the enclosure
enclosure_length = 40; //[10:1:100]
// width of the enclosure
enclosure_width = 25; //[10:1:100]
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

$fn = 128;
base_radius = base_diameter / 2;

use <common.scad>
use <module_empty.scad>

// adds a sensor enclosure to the module
// parameters are length/width of enclosure
module enclosure(angle, length, width, base_radius, base_height, wall_thickness, port_radius) {
	difference() {
		difference() {
			translate([base_radius-length-wall_thickness*1.5,-width/2,0])
				difference() {
					cube([length, width, base_height], false);
					translate([wall_thickness,wall_thickness,wall_thickness])
						cube([length, width-wall_thickness*2, base_height-wall_thickness+1], false);
				}

			// wiring hole
			translate([base_radius-length-wall_thickness-1.1, 0, base_height/2+wall_thickness/2])
				rotate([0,90,0])
					cylinder(wall_thickness+2, r = port_radius);
		}

		// make sure we don't exceed the outer shell
		difference() {
			cylinder(h = base_height, d = base_radius * 2.5, center = false);
			cylinder(h = base_height, d = base_radius * 2, center = false);
		}
	}
}

module sensor_enclosure(enclosure_length, enclosure_width, base_radius, module_height, enclosure_height, enclosure_wall_thickness, enclosure_port_radius) {
	union() {
		difference() {
			empty(base_radius, module_height, wall_thickness);
			venting_holes(90, base_radius, module_height, enclosure_vents_x, enclosure_vents_y, enclosure_vents_twosided);
		}

		enclosure(90, enclosure_length, enclosure_width, base_radius, enclosure_height, enclosure_wall_thickness, enclosure_port_radius);
	}
}

sensor_enclosure(enclosure_length, enclosure_width, base_radius, module_height, enclosure_height, enclosure_wall_thickness, enclosure_port_radius);
