// Creates a flat cap.

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; // [62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 2; // [2:0.5:5]
// enable rim
enable_rim = true;
// rim height
rim_height = 1.2; // [.5: .1: 2]

/* [Flat Cap Dimensions] */

// thickness of flat cap
cap_flat_thickness = 1.4; // [0.5:0.5:5]
// height of the flat cap
cap_flat_height = 9; // [9:1:100]

// create LED plate
create_led_plate = true;
// width of the rest plate
led_plate_width = 7; // [6:1:80]
// height of the rest plate
led_plate_height = 1.2; // [1:0.5:10]
// screw thread position from center in mm
led_plate_screw_position = 14.5;
// diameter of screw
led_plate_thread_diameter = 3;
// pitch of screw
led_plate_thread_pitch = 0.5;

/* [Hidden] */

$fn = 128;
base_radius = base_diameter / 2;

use <common.scad>
use <threads.scad>

module flatcap(base_radius, wall_thickness, cap_height, cap_thickness, rest_width, rest_height) {
/*    rotate([180,0,0])
    translate([0,0,-cap_height-wall_thickness])*/
    difference() {
        union() {
            shell_height = 9;

            // outer shell
            shell(base_radius*2, shell_height, wall_thickness, false);

            // male connectors (to module below)
            connectors_male(90, base_radius, wall_thickness);
            connectors_male(270, base_radius, wall_thickness);

            // rest plate
            if (create_led_plate) {
                difference() {
                    translate([-base_radius+wall_thickness, -rest_width/2, 0])
                        cube([2*(base_radius-wall_thickness), rest_width, rest_height]);

                    // screw threads
                    render() translate([-led_plate_screw_position, 0, -0.1])
                        metric_thread(diameter=led_plate_thread_diameter,
                                      pitch=led_plate_thread_pitch,
                                      length=rest_height+0.2,
                                      internal=true,
                                      test=true);

                    render() translate([led_plate_screw_position, 0, -0.1])
                        metric_thread(diameter=led_plate_thread_diameter,
                                      pitch=led_plate_thread_pitch,
                                      length=rest_height+0.2,
                                      internal=true,
                                      test=true);
                }

                // rest plate connection with frame
                translate([-base_radius+wall_thickness, -rest_width/2, rest_height])
                    cube([wall_thickness*1.5, rest_width, rest_height*1.2]);
                translate([+base_radius-wall_thickness*2.2, -rest_width/2, rest_height])
                    cube([wall_thickness*1.5, rest_width, rest_height*1.2]);
            }

            // cap
            translate([0,0,shell_height])
                shell(base_radius*2, cap_height, cap_thickness, false);

            translate([0,0,shell_height+cap_height])
                cylinder(h = cap_thickness, r = base_radius);

            /*
            translate([0,0,cap_height])
                difference() {
                    cylinder(h = cap_height, r1 = base_radius, r2 = base_radius/3);
                    translate([0,0,-cap_thickness])
                        cylinder(h = cap_height, r1 = base_radius-cap_thickness, r2 = base_radius/3-cap_thickness);
                }
            */
        }

        // spacer for rim of module below
        if (enable_rim) {
            // make spacer 25% taller and 20% wider than the rim itself
		    rim(base_radius, 0, wall_thickness - 0.2, rim_height * 1.25, 1.2);
        }
    }
}

flatcap(base_radius, wall_thickness, cap_flat_height, cap_flat_thickness, led_plate_width, led_plate_height);
