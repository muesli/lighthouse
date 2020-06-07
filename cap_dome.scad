// Creates a dome cap.

/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 2; //[2:0.5:5]

/* [Dome Cap Dimensions] */

// thickness of dome
cap_dome_thickness = 1.0; //[0.5:0.5:5]
// height of the dome cap
cap_dome_height = 10; //[9:1:100]

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

module dome(base_radius, wall_thickness, cap_height, dome_thickness, rest_width, rest_height) {
    difference() {
        union() {
            // outer shell
            shell(base_radius*2, cap_height, wall_thickness, false);

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
        }
}

dome(base_radius, wall_thickness, cap_dome_height, cap_dome_thickness, led_plate_width, led_plate_height);
