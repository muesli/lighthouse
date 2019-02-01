// Creates the enclosure base with space for a PCB and access to its ports.

/* [PCB Dimensions] */

// width of a PCB
board_width = 26; //[18:Arduino_Nano, 23:Feather_HUZZAH, 26:NodeMCUv2, 30:Raspberry_Pi_ZeroW, 31:NodeMCUv3, 53.3:Arduino_Mega, 53.4:Arduino_Uno]
// length of a PCB
board_length = 48; //[45:Arduino_Nano, 48:NodeMCUv2, 51:NodeMCUv3, 51:Feather_HUZZAH, 65:Raspberry_Pi_ZeroW, 68.6:Arduino_Uno, 101.52:Arduino_Mega]

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 3; //[2:1:5]
// height of the base
base_height = 30; //[20:5:100]

/* [Access Port Dimensions] */

// width of the port hole for e.g. USB access
port_width = 10; //[5:1:50]
// height of the port hole for e.g. USB access
port_height = 6; //[4:1:30]

/* [Hidden] */

$fn = 256;
base_radius = base_diameter / 2;

use <common.scad>

standoff_height = 12;
standoff_width = wall_thickness;
ground_clearance = 5;

// a single standoff with a small rest to keep a board from the ground
// height: overall height; width: wall-thickness and nook,
// clearance: height from ground
module single_standoff(height, width, clearance) {
	render() { // to get rid off the interference
		translate([0,0,wall_thickness]) {
			union() {
				// outer pillars
				difference() {
					cube([width+wall_thickness, width+wall_thickness, height]);
					cube([width, standoff_width, height]);
				}
				// inner board rest
				translate([width, width, 0])
					rotate([0,0,180])
						intersection() {
							cylinder(h = clearance, r = width, center = false);
							cube([width, width, height]);
				}
			}
		}
	}
}

// place 4 standoffs around a rectangular board space
module standoffs(length, width, clearance) {
	translate([(length/2) - standoff_width, (width/2) - standoff_width])
		rotate([0,0,0])
			single_standoff(standoff_height, standoff_width, clearance);

	translate([(length/2) - standoff_width, -(width/2) + standoff_width])
		rotate([0,0,270])
			single_standoff(standoff_height, standoff_width, clearance);

	translate([-(length/2) + standoff_width, -(width/2) + standoff_width])
		rotate([0,0,180])
			single_standoff(standoff_height, standoff_width, clearance);

	translate([-(length/2) + standoff_width, (width/2) - standoff_width])
		rotate([0,0,90])
			single_standoff(standoff_height, standoff_width, clearance);
}

// cut array of venting holes
module venting_holes(xnum, ynum) {
	width = 1;
	spacing = 1.5;

	for(y = [0 : width+spacing : (width+spacing)*ynum])
	{
		for(x = [0 : width+spacing : (width+spacing)*xnum])
		{
			translate([x - ((width+spacing)*xnum/2),-base_radius*1.25, y - ((width+spacing)*ynum/2) + base_height/2])
				cube([width,2.5*base_radius,width]);
		}
	}
}

// cut a recess with port access into base
// parameters are length/width of port access hole and
module port_access(length, height) {
	difference() {
		union() {
			children(); // <- the rest of the model
			// add new inner wall
			intersection() { // cut everything not inside the original enclosure shape
				// same as base
				translate([0, 0, base_height/2])
					cylinder(h = base_height, d = base_diameter, center = true);
				// recess
				translate([board_length/2, -(2*base_radius+5)/2, 0]) {
					cube([base_radius+5, 2*base_radius+5, ground_clearance + wall_thickness + 1 + height + 1]);
				// slope
				translate([0, 0, ground_clearance + wall_thickness + 1 + height + 1])
					rotate([0,60,0])
						cube([base_radius, 2*base_radius+5, base_radius]);
				}
			}
		}
		// cut outer overhang
		translate([board_length/2 + wall_thickness, -(2*base_radius+5)/2, 0]) {
			cube([base_radius - board_length/2 + 5, 2*base_radius+5, ground_clearance + wall_thickness + 1 + height + 1]);
		}
		// cut slope
		translate([board_length/2 + wall_thickness, -(2*base_radius+5)/2, ground_clearance + wall_thickness + 1 + height + 1])
			rotate([0,60,0])
				cube([base_radius - board_length/2 + 5, 2*base_radius+5, base_radius]);
		// cut port hole
		translate([board_length/2 - 1, - length/2, -height/2 + wall_thickness + ground_clearance - 1])
			cube([50, length, height]);
	}
};

// main housing of the uC
module base(base_radius, base_height, wall_thickness, board_length, board_width, port_width, port_height) {
	port_access(port_width, port_height) {
		union() {
			difference() {
				shell(base_radius*2, base_height, wall_thickness, true);
				venting_holes(10, 5);
			};

			// board dummy
			%translate([-board_length/2, -board_width/2, ground_clearance + wall_thickness])
				cube([board_length, board_width, 2]);

			standoffs(board_length, board_width, ground_clearance);
			connectors_female(90, base_radius, base_height, wall_thickness);
			connectors_female(270, base_radius, base_height, wall_thickness);
		}
	}
}

base(base_radius, base_height, wall_thickness, board_length, board_width, port_width, port_height);
