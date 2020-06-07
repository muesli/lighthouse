// Creates a module with an opening for a PIR motion sensor
/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 2; //[2:0.5:5]

/* [PIR Sensor Dimensions] */

// width of the PIR sensor
pir_sensor_width = 24.0; //[10:0.1:100]
// height of the PIR sensor
pir_sensor_height = 24.0; //[10:0.1:100]
// width of the pcb
pir_sensor_pcb_width = 26.0; //[10:0.1:100]
// height of the pcb
pir_sensor_pcb_height = 32.0; //[10:0.1:100]
// position of the sensor (lower edge)
pir_sensor_y_position = 4.0;

// diameter of pcb screw
pir_sensor_thread_diameter = 2.0;
// pitch of pcb screw
pir_sensor_thread_pitch = 0.4;

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

module pir_sensor(base_radius, wall_thickness, pir_sensor_width, pir_sensor_height, pir_sensor_pcb_width, pir_sensor_pcb_height, pir_sensor_y_position) {
	pir_sensor_module_height = pir_sensor_pcb_height + 2*wall_thickness;

	rotate([0,0,180])
	difference() {
		difference() {
			union() {
				// base
				empty(base_radius, pir_sensor_module_height, wall_thickness);

				// frame
				cutInner(base_radius - 2.5*wall_thickness, pir_sensor_module_height) {
					cutOuter(base_radius - wall_thickness+0.1, pir_sensor_module_height) {
						translate([base_radius-wall_thickness*2-1, -(pir_sensor_pcb_width/2 + wall_thickness/2), 0])
							cube([base_radius, pir_sensor_pcb_width + wall_thickness, pir_sensor_pcb_height + wall_thickness * 2 + 0.1]);
					};
				};
			}

			// sensor cutout
			translate([0, -pir_sensor_width/2, pir_sensor_y_position + wall_thickness])
				cube([base_radius, pir_sensor_width, pir_sensor_height]);

			// pcb cutout
			translate([-1, -pir_sensor_pcb_width/2, wall_thickness])
				cube([base_radius - 1.5*wall_thickness, pir_sensor_pcb_width, pir_sensor_pcb_height]);

			// outer recess
			translate([base_radius - wall_thickness, -pir_sensor_width/2 - 2, pir_sensor_y_position + wall_thickness])
				cube([base_radius - 2*wall_thickness, pir_sensor_width+4, pir_sensor_height]);

			// chamfer top
			translate([base_radius - wall_thickness, -pir_sensor_width/2 - 2, pir_sensor_y_position + pir_sensor_height + wall_thickness])
				rotate([0,30,0])
					cube([base_radius - 2*wall_thickness, pir_sensor_width+4, pir_sensor_height+4]);
			// chamfer bottom
			translate([base_radius - wall_thickness, -pir_sensor_width/2 - 2, pir_sensor_y_position + wall_thickness])
				rotate([0,60,0])
					cube([base_radius - 2*wall_thickness, pir_sensor_width+4, pir_sensor_height+4]);
			// chamfer horizontal
			/*
			translate([base_radius - wall_thickness-4.1, -pir_sensor_width/2 - 12, pir_sensor_y_position + wall_thickness])
				cube([base_radius - 2*wall_thickness, pir_sensor_width+24, pir_sensor_height]);
			*/
		}

		// screw threads
		render() translate([base_radius-2*wall_thickness-0.6, 0, pir_sensor_pcb_height-pir_sensor_thread_diameter/2])
			rotate([0,90,0])
				metric_thread(diameter=pir_sensor_thread_diameter, pitch=pir_sensor_thread_pitch, length=3, internal=true, test=preview);
		render() translate([base_radius-2*wall_thickness-0.6, 0, wall_thickness + pir_sensor_thread_diameter])
			rotate([0,90,0])
				metric_thread(diameter=pir_sensor_thread_diameter, pitch=pir_sensor_thread_pitch, length=3, internal=true, test=preview);
	}
}

pir_sensor(base_radius, wall_thickness, pir_sensor_width, pir_sensor_height, pir_sensor_pcb_width, pir_sensor_pcb_height, pir_sensor_y_position);
