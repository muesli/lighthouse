// Creates a dome cap.

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 3; //[2:1:5]

/* [Dome Cap Dimensions] */

// thickness of dome
cap_dome_thickness = 1.5; //[2:0.5:5]
// height of the dome cap
cap_dome_height = 15; //[10:3:100]

/* [Hidden] */

$fn = 256;
base_radius = base_diameter / 2;

use <common.scad>

module dome(base_radius, cap_height, wall_thickness, dome_thickness) {
	// outer shell
	shell(base_radius*2, cap_height, wall_thickness, false);

	// male connectors (to module below)
	connectors_male(90, base_radius, wall_thickness);
	connectors_male(270, base_radius, wall_thickness);

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

dome(base_radius, cap_dome_height, wall_thickness, cap_dome_thickness);
