// Creates a module with a oled display
/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]
// thickness of outer wall
wall_thickness = 3; //[2:1:5]
// height of the module
module_height = 20; //[10:5:100]

/* [OLED Dimensions] */

// width of the display
oled_height = 13; //[10:1:100]
// height of the display
oled_width = 26; //[10:1:100]
// width of the pcb
oled_pcb_width = 27; //[10:1:100]
// height of the pcb
oled_pcb_height = 27; //[10:1:100]
//position of the display (lower edge)
oled_y_position = 6.5;



/* [Hidden] */
$fn = 256;
base_radius = base_diameter / 2;

frame = 1; // plastic frame around pcb

// lock minimum module height
_module_height = (module_height <= oled_pcb_height + 2*wall_thickness + 2*frame)?oled_pcb_height + 2*wall_thickness+2*frame: module_height;

use <common.scad>
use <module_empty.scad>

module cutOuter(radius)
{
	intersection(){
		children();
		cylinder(r=radius, h=_module_height);
	}
}

module cutInner(radius)
{
	difference(){
		children();
		cylinder(r=radius, h=_module_height);
	}
}

module oled(base_radius, module_height, wall_thickness) {
	union() {
		difference(){
			union(){
				//base
	    		empty(base_radius, _module_height, wall_thickness);
	    		//frame
	    		cutInner(base_radius - 2.5*wall_thickness){
		    		cutOuter(base_radius - wall_thickness){
			    		translate([5, -(oled_pcb_width/2 + wall_thickness/2),  frame])
			    			cube([base_radius, oled_pcb_width + wall_thickness, oled_pcb_height + 2*wall_thickness]);
			    	};
		    	};
	    	}
	    	// display cutout
	    	translate([5, -oled_width/2, oled_y_position + wall_thickness +frame])
		    	cube([base_radius, oled_width, oled_height]);
		    // pcb cutout
			translate([0, -oled_pcb_width/2, wall_thickness +frame])
		    	cube([base_radius- 1.5*wall_thickness, oled_pcb_width, oled_pcb_height]);
		    // outer recess
		    translate([base_radius- 1*wall_thickness,-oled_width/2 - 2, oled_y_position + wall_thickness +frame -2])
		    	cube([base_radius- 2*wall_thickness, oled_width+4, oled_height+4]);
		    //chamfer bottom
		    translate([base_radius- 1*wall_thickness,-oled_width/2 - 2, oled_y_position + oled_height + 4+ wall_thickness +frame -2])
		    	rotate([0,30,0])
		    		cube([base_radius- 2*wall_thickness, oled_width+4, oled_height+4]);
		    //chamfer top
		    translate([base_radius- 1*wall_thickness,-oled_width/2 - 2, oled_y_position + wall_thickness +frame -2])
		    	rotate([0,60,0])
		    		cube([base_radius- 2*wall_thickness, oled_width+4, oled_height+4]);
		    //chamfer left
		    translate([base_radius- 1*wall_thickness,-oled_width/2 - 2, oled_y_position + wall_thickness +frame -2])
		    	rotate([0,0,-60])
		    		cube([base_radius- 2*wall_thickness, oled_width+4, oled_height+4]);
		    //chamfer right
		    translate([base_radius- 1*wall_thickness,+oled_width/2 + 2, oled_y_position + wall_thickness +frame -2])
		    	rotate([0,0,-30])
		    		cube([base_radius- 2*wall_thickness, oled_width+4, oled_height+4]);
		
		}
	}
}

oled(base_radius, _module_height, wall_thickness);
