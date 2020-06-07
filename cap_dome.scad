// Creates a dome cap.

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 2; //[2:0.5:5]

/* [Dome Cap Dimensions] */

// thickness of dome
cap_dome_thickness = 1; //[0.5:0.5:5]
// height of the dome cap
cap_dome_height = 10; //[10:1:100]
// width of the rest plate
cap_dome_rest_width = 20; //[10:1:80]
// height of the rest plate
cap_dome_rest_height = 2.5; //[1:0.5:10]

/* [Hidden] */

$fn = 128;
base_radius = base_diameter / 2;

use <common.scad>

module dome(base_radius, wall_thickness, cap_height, dome_thickness, rest_width, rest_height) {
	// outer shell
	shell(base_radius*2, cap_height, wall_thickness, false);

	// male connectors (to module below)
	connectors_male(90, base_radius, wall_thickness);
	connectors_male(270, base_radius, wall_thickness);

    // rest plate
    translate([-base_radius+wall_thickness,-rest_width/2,0])
        cube([2*(base_radius-wall_thickness),rest_width,rest_height]);

    // sphere
    translate([0,0,cap_height])
        difference() {
            difference() {
                sphere(base_radius);
                sphere(base_radius-dome_thickness);
            }
            translate([0,0,-base_radius])
                cylinder(h = base_radius, d = base_radius * 2, center = false);
        }
}

dome(base_radius, wall_thickness, cap_dome_height, cap_dome_thickness, cap_dome_rest_width, cap_dome_rest_height);
