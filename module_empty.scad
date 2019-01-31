// An empty spacer module

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]

// thickness of outer wall
wall_thickness = 3; //[2:1:5]

// height of the base
base_height = 28.6; //[20:5:100]

/* [Access Port Dimensions] */

// width of the port hole for e.g. USB access
port_width = 15; //[5:1:50]

// height of the port hole for e.g. USB access
port_height = 5; //[4:1:30]

$fn=256;

base_radius = base_diameter / 2;

use <common.scad>;

// main housing
union(){
	base(base_diameter, base_height, wall_thickness, false);

	connectors_female(90, base_radius, base_height, wall_thickness);
	connectors_female(270, base_radius, base_height, wall_thickness);

	connectors_male(90, base_radius, 0, wall_thickness);
	connectors_male(270, base_radius, 0, wall_thickness);
}
