// Creates a module with an opening and mounts for a display
/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 2; //[2:0.5:5]

/* [OLED Dimensions] */

// type of display
display = 0; //[0: Custom, 1:OLED 0.96, 2:OLED 1.3]

// width of the display
oled_width = 35; //[10:1:100]
// height of the display
oled_height = 18; //[10:1:100]
// width of the pcb
oled_pcb_width = 36; //[10:1:100]
// height of the pcb
oled_pcb_height = 34; //[10:1:100]
// position of the display (lower edge)
oled_y_position = 9.0;

// diameter of display screw
oled_thread_diameter = 3;
// pitch of display screw
oled_thread_pitch = 0.5;

/* [Hidden] */
$fn = 128;
preview = false;
base_radius = base_diameter / 2;

use <common.scad>
use <module_empty.scad>
use <threads.scad>

module cutOuter(radius, module_height)
{
	intersection() {
		children();
		cylinder(r=radius, h=module_height);
	}
}

module cutInner(radius, module_height)
{
	difference() {
		children();
		cylinder(r=radius, h=module_height);
	}
}

module _oled(base_radius, wall_thickness, oled_width, oled_height, oled_pcb_width, oled_pcb_height, oled_y_position) {
	oled_module_height = oled_pcb_height + 2*wall_thickness + 1;

	rotate([0,0,180])
	union() {
		difference() {
			union() {
				// base
				empty(base_radius, oled_module_height, wall_thickness);

				// frame
				cutInner(base_radius - 2.5*wall_thickness, oled_module_height) {
					cutOuter(base_radius - wall_thickness+0.1, oled_module_height) {
						translate([base_radius-wall_thickness*2-1, -(oled_pcb_width/2 + wall_thickness/2), 0])
							cube([base_radius, oled_pcb_width + wall_thickness, oled_pcb_height + wall_thickness + 0.1]);
					};
				};
			}

			// display cutout
			translate([0, -oled_width/2, oled_y_position + wall_thickness])
				cube([base_radius, oled_width, oled_height]);

			// pcb cutout
			translate([-2, -oled_pcb_width/2, wall_thickness])
				cube([base_radius - 1.5*wall_thickness, oled_pcb_width, oled_pcb_height]);

			// outer recess
			translate([base_radius - wall_thickness, -oled_width/2 - 2, oled_y_position + wall_thickness])
				cube([base_radius - 2*wall_thickness, oled_width+4, oled_height]);

			// chamfer top
			translate([base_radius - wall_thickness-2.3, -oled_width/2 - 2, oled_y_position + oled_height + wall_thickness])
				rotate([0,30,0])
					cube([base_radius - 2*wall_thickness, oled_width+4, oled_height+4]);
			// chamfer bottom
			translate([base_radius - wall_thickness-2.3, -oled_width/2 - 2, oled_y_position + wall_thickness])
				rotate([0,60,0])
					cube([base_radius - 2*wall_thickness, oled_width+4, oled_height+4]);
			// chamfer horizontal
			/*
			translate([base_radius - wall_thickness-4.1, -oled_width/2 - 12, oled_y_position + wall_thickness])
				cube([base_radius - 2*wall_thickness, oled_width+24, oled_height]);
			*/
		}

		// screw threads
		difference() {
			translate([base_radius-2*wall_thickness-2.5, -oled_width/2, oled_y_position + wall_thickness + oled_height+2])
				cube([2,4,4]);
			render() translate([base_radius-2*wall_thickness-2.6, -oled_width/2+2, oled_y_position + wall_thickness + oled_height+4])
				rotate([0,90,0])
					metric_thread(diameter=oled_thread_diameter, pitch=oled_thread_pitch, length=3, internal=true, test=preview);
		}

		difference() {
			translate([base_radius-2*wall_thickness-2.5, oled_width/2-4, oled_y_position + wall_thickness + oled_height+2])
				cube([2,4,4]);
			render() translate([base_radius-2*wall_thickness-2.6, oled_width/2-2, oled_y_position + wall_thickness + oled_height+4])
				rotate([0,90,0])
					metric_thread(diameter=oled_thread_diameter, pitch=oled_thread_pitch, length=3, internal=true, test=preview);
		}

		difference() {
			translate([base_radius-2*wall_thickness-2.5, -oled_width/2, wall_thickness])
				cube([2,4,4]);
			render() translate([base_radius-2*wall_thickness-2.6, -oled_width/2+2, wall_thickness+2])
				rotate([0,90,0])
					metric_thread(diameter=oled_thread_diameter, pitch=oled_thread_pitch, length=3, internal=true, test=preview);
		}

		difference() {
			translate([base_radius-2*wall_thickness-2.5, oled_width/2-4, wall_thickness])
				cube([2,4,4]);
			render() translate([base_radius-2*wall_thickness-2.6, oled_width/2-2, wall_thickness+2])
				rotate([0,90,0])
					metric_thread(diameter=oled_thread_diameter, pitch=oled_thread_pitch, length=3, internal=true, test=preview);
		}
	}
}

module oled(base_radius, wall_thickness, oled_width, oled_height, oled_pcb_width, oled_pcb_height, oled_y_position) {
	// display dimensions database (unique variables needed due to language restrictions)
	display_size1 = display==0?[oled_width, oled_height]:[1,1]; // custom
	display_size2 = display==1?[28, 15]:display_size1; // OLED 0.96"
	display_size3 = display==2?[35, 18]:display_size2; // OLED 1.3"

	display_size = display_size3; // use last variable from table above here

	// pcb dimensions [width, height]
	pcb_size1 = display==0?[oled_pcb_width, oled_pcb_height]:[1,1]; // custom
	pcb_size2 = display==1?[29, 28]:pcb_size1; // OLED 0.96"
	pcb_size3 = display==2?[36, 34]:pcb_size2; // OLED 1.3"

	pcb_size = pcb_size3; // use last variable from table above here

	// y offset of display
	y_offset1 = display==0?oled_y_position:0; // custom
	y_offset2 = display==1?7:y_offset1; // OLED 0.96"
	y_offset3 = display==2?9:y_offset2; // OLED 1.3"

	y_offset = y_offset3; // use last variable from table above here

	_oled(base_radius, wall_thickness, display_size[0], display_size[1], pcb_size[0], pcb_size[1], y_offset);
}

oled(base_radius, wall_thickness, oled_width, oled_height, oled_pcb_width, oled_pcb_height, oled_y_position);
