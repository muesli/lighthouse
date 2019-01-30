
// width of a PCB
board_width = 25; //[20:S, 26:NodeMCUv2, 30:L, 31:NodeMCUv3]

// length of a PCB
board_lenght = 45; //[30:S, 48:NodeMCUv2, 50:L, 51:NodeMCUv3]


module dummy_private(){} // to hide parameters from gui, place below this line

$fn=256;
base_radius = 31.4;
base_height = 28.6;
wall_thickness = 3;
width = base_radius * 2;

standoff_height = 12;
standoff_width = 5;
ground_clearance = 4;


// a single standoff with a small rest to keep a board from the ground
// height: overall height; width: wall-thickness and nook, clearance: height from ground
module single_standoff(height, width, clearance){
	render(){ // to get rid off the interference
		translate([0,0,wall_thickness]) {
			union() {
				difference() {
					cube([width+wall_thickness, width+wall_thickness, height]);
					cube([width, standoff_width, height]);				
				}
				translate([width, width,0])
					rotate([0,0,180])
						intersection(){
							cylinder(h = clearance, r = width,  center=false);
							cube([width, width, height]);
				}
			}
		}
	}
}

// place 4 standoffs around a rectangular board space
module standoffs(length, width, clearance) {
	translate([(length/2) - standoff_width , (width/2) - standoff_width]) rotate([0,0,0])   single_standoff(standoff_height, standoff_width, clearance);
	translate([(length/2) - standoff_width , -(width/2) + standoff_width]) rotate([0,0,270]) single_standoff(standoff_height, standoff_width, clearance);
	translate([-(length/2) + standoff_width , -(width/2) + standoff_width]) rotate([0,0,180]) single_standoff(standoff_height, standoff_width, clearance);
	translate([-(length/2) + standoff_width , (width/2) - standoff_width]) rotate([0,0,90])   single_standoff(standoff_height, standoff_width, clearance);
}

module connectors_female(angle) {
	width = 10; // in degrees
	rotate([0,0,angle-width]) 
		rotate_extrude(angle=width, $fn=200) 
			translate([-base_radius+wall_thickness ,base_height-2]) 
				polygon( points=[[0,0],[0,5],[4,5],[4,2], [1,2],[1,3],[2,4],[3,4],[3,2]], paths=[[0,1,2,3], [4,5,6,7,8]] );
}

// cut 
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
// zPos is height of port center over underside of PCB
module port_access(length, height, zPos) {
	difference(){
		union(){	
			children();	
			// add new inner wall		
			intersection(){
				translate([0, 0, base_height/2])
					    cylinder(h=base_height, d=width, center=true);		
				translate([board_lenght/2, -(2*base_radius+5)/2 , 0]){ 
					cube([base_radius - board_lenght/2 + 5, 2*base_radius+5, standoff_height + wall_thickness]);
				}
			}		
		}		
		// cut outer overhang
		translate([board_lenght/2 + wall_thickness, -(2*base_radius+5)/2, -wall_thickness]){ 
			cube([base_radius - board_lenght/2 + 5, 2*base_radius+5 , standoff_height + wall_thickness]);
		}
		// cut slope
		translate([board_lenght/2 + wall_thickness, -(2*base_radius+5)/2, standoff_height])
			rotate([0,60,0])
				cube([base_radius - board_lenght/2 + 5, 2*base_radius+5 , standoff_height + wall_thickness]);
		// cut port hole
		translate([board_lenght/2 - 1, -height/2, -height/2 + wall_thickness + ground_clearance + zPos])
			cube([50, length, height]);
	}
};


// main housing
port_access(12, 6, 1){
	union(){
		difference(){
			translate([0, 0, base_height/2])
				difference() {
				    cylinder(h=base_height, d=width, center=true);
				    translate([0,0,wall_thickness]) cylinder(h=base_height, d=width-wall_thickness*2, center=true);
				}
			venting_holes(10, 5);
		};

		// board dummy
		%translate([-board_lenght/2, -board_width/2, ground_clearance+wall_thickness]) cube([board_lenght, board_width, 2]);

		standoffs(board_lenght, board_width, ground_clearance);
		connectors_female(90);
		connectors_female(270);

	}
}