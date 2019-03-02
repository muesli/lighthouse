// Creates an empty module

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 3; //[2:1:5]
// height of the module
module_height = 10; //[10:5:100]

/* [Hidden] */

$fn = 256;
base_radius = base_diameter / 2;

use <common.scad>

module dome(base_radius, empty_height, wall_thickness) {
	// outer shell
	shell(base_radius*2, empty_height, wall_thickness, false);

	// male connectors (to module below)
	connectors_male(90, base_radius, wall_thickness);
	connectors_male(270, base_radius, wall_thickness);

    // sphere
    translate([0,0,empty_height])
        difference() {
            difference() {
                sphere(base_radius);
                sphere(base_radius-2);
            }
            translate([0,0,-base_radius])
                cylinder(h = base_radius, d = base_radius * 2, center = false);
        }
}

dome(base_radius, module_height, wall_thickness);
