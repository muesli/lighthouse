$fn=256;

base_radius = 31.4;
base_height = 28.6;
wall_thickness = 3;
width = base_radius * 2;

support_depth = 3;
usb_port_height = 3;
usb_port_width = 10;

// main housing
render() {
    difference() {
        union() {
            difference(){
                translate([0, 0, base_height/2])
                    difference() {
                        cylinder(h=base_height, d=width, center=true);
                        translate([0,0,wall_thickness]) cylinder(h=base_height, d=width-wall_thickness*2, center=true);
                    }
            }
            // overhang support
            intersection() {
                cylinder(base_height, base_radius-wall_thickness, base_radius-wall_thickness, center=false);
                translate([base_radius-wall_thickness-support_depth, -base_radius, 0])  cube([wall_thickness+support_depth, width, base_height-base_height/3]); 
            }
        }
        // USB port access
        translate([base_radius-wall_thickness-support_depth,-usb_port_width/2,wall_thickness]) cube([wall_thickness+support_depth, usb_port_width,usb_port_height]);
        //overhang
        difference() {
            oh_spacing = base_radius-wall_thickness-2;
            translate([oh_spacing, -base_radius, 0]) cube([wall_thickness+support_depth, width, base_height]);
            translate([oh_spacing, -base_radius, base_height/2]) rotate([0, -60, 0]) cube([oh_spacing, width,(wall_thickness+support_depth)+10]);
        }
    }
}
