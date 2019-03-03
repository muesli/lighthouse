// Creates the enclosure base with space for a PCB and access to its ports.

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 3; //[2:1:5]


/* [PCB Dimensions] */

//type of uC
board = 0; //[0: Custom, 1:Arduino_Nano, 2:Arduino_Mega, 3:Arduino_Uno, 4:Feather_HUZZAH, 5:NodeMCUv2, 6:NodeMCUv3, 7:Raspberry_Pi_ZeroW]

// width of a PCB (only for Custom)
board_width = 26; //[10:0.1:150]
// length of a PCB  (only for Custom)
board_length = 48; //[10:0.1:150]

/* [Access Port Dimensions (only for Custom)] */

// width of the port hole for e.g. USB access
port_width = 10; //[5:1:50]
// height of the port hole for e.g. USB access
port_height = 6; //[4:1:30]
// position from left edge of board to middle of port
port_ypos = 5; //[0:1:150]
// position from bottom of pcb (negative is below)
port_zpos = 0; //[-25:1:30]

/* [Hidden] */

$fn = 128;

base_radius = base_diameter / 2;

use <common.scad>

function base_height() = 30; //fixed, but needs to be fine-tuned to pcb+pins+connectors+bending radius of cables
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

// cut a recess with port access into base
// parameters are length/width of port access hole
module port_access(base_radius, length, height, port_ypos, port_zpos, board_length, board_width) {
	difference() {
		union() {
			children(); // <- the rest of the model
			// add new inner wall
			intersection() { // cut everything not inside the original enclosure shape
				// same as base
				translate([0, 0, base_height()/2])
					cylinder(h = base_height(), d = base_radius*2, center = true);
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
		translate([board_length/2 + wall_thickness, -(2*base_radius+5)/2, -1]) {
			cube([base_radius - board_length/2 + 5, 2*base_radius+5, ground_clearance + wall_thickness + 1 + height + 2]);
		}
		// cut slope
		translate([board_length/2 + wall_thickness, -(2*base_radius+5)/2, ground_clearance + wall_thickness + 1 + height + 1])
			rotate([0,60,0])
				cube([base_radius - board_length/2 + 5, 2*base_radius+5, base_radius]);
		// cut port hole
		translate([board_length/2 - 1, -board_width/2 - length/2 + port_ypos, wall_thickness + ground_clearance +port_zpos])
			cube([50, length, height]);
	}
}

// main housing of the uC
module _base(base_radius, wall_thickness, board_length, board_width, port_width, port_height, port_ypos, port_zpos) {
	port_access(base_radius, port_width, port_height, port_ypos, port_zpos, board_length, board_width) {
		union() {
			difference() {
				shell(base_radius*2, base_height(), wall_thickness, true);
				venting_holes(0, base_radius, base_height(), 10, 5, true);
			};

			// board dummy
			%translate([-board_length/2, -board_width/2, ground_clearance + wall_thickness])
				cube([board_length, board_width, 2]);

			standoffs(board_length, board_width, ground_clearance);
			connectors_female(90, base_radius, base_height(), wall_thickness);
			connectors_female(270, base_radius, base_height(), wall_thickness);
		}
	}
}

module base(base_radius, wall_thickness, board, port_width, port_height, port_ypos, port_zpos) {
	// board dimensions database (unique variables needed due to language restrictions)
	board_size1 = board==0?[board_width, board_length]:[1,1]; //custom
	board_size2 = board==1?[ 45   , 18   ]:board_size1; // Arduino_Nano
	board_size3 = board==2?[ 68.6 , 53.3 ]:board_size2; // Arduino_Uno
	board_size4 = board==3?[101.52, 53.4 ]:board_size3; // Arduino_Mega
	board_size5 = board==4?[ 51   , 23   ]:board_size4; // Feather_HUZZAH
	board_size6 = board==5?[ 48   , 26   ]:board_size5; // NodeMCUv2
	board_size7 = board==6?[ 51   , 31   ]:board_size6; // NodeMCUv3
	board_size8 = board==7?[ 65   , 30   ]:board_size7; // Raspberry_Pi_ZeroW

	board_size = board_size8; // use last variable from table above here

	//port dimensions [width, height, ypos, zpos]
	port1 = board==0?[port_width, port_height, port_ypos, port_zpos]:[10,16,5,0]; //custom
	port2 = board==1?[ 1,1,1,1 ]:port1; // Arduino_Nano
	port3 = board==2?[ 1,1,1,1 ]:port2; // Arduino_Uno
	port4 = board==3?[ 1,1,1,1 ]:port3; // Arduino_Mega
	port5 = board==4?[ 1,1,1,1 ]:port4; // Feather_HUZZAH
	port6 = board==5?[ 10, 7, 13  , -4.5 ]:port5; // NodeMCUv2
	port7 = board==6?[ 10, 7, 15.5, -4.5 ]:port6; // NodeMCUv3
	port8 = board==7?[ 1,1,1,1   ]:port7; // Raspberry_Pi_ZeroW

	port = port8; // use last variable from table above here

	_base(base_radius, wall_thickness, board_size[0], board_size[1], port[0], port[1], port[2], port[3]);
}

base(base_radius, wall_thickness, board, port_width, port_height, port_ypos, port_zpos);
