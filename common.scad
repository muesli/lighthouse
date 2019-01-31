// create main enclosure
module base(diameter, height, wall_thickness, base){
	translate([0, 0, height/2])
		difference() {
		    cylinder(h=height, d=diameter, center=true);
		        if(base) // remove core, keep bottom
			    	translate([0,0,wall_thickness]) cylinder(h=height, d=diameter-wall_thickness*2, center=true);
			    else // remove core, no bottom
			        cylinder(h=height+1, d=diameter-wall_thickness*2, center=true);
		}
}

// connectors to receive another module on top
// these are placed 10deg off-center -> counterparts should be placed -10deg off center
module connectors_female(angle, base_radius, base_height, wall_thickness) {
	width = 10; // in degrees
	rotate([0,0,angle-width]) 
		rotate_extrude(angle=width, $fn=200) 
			translate([-base_radius+wall_thickness ,base_height-2]) 
				polygon( points=[[0,0],[0,5],[4,5],[4,2], [1,2],[1,3],[2,4],[3,4],[3,2]], paths=[[0,1,2,3], [4,5,6,7,8]] );
}


// todo: check this code, it's untested
// todo: scale this so it has some play after printing
// connectors to connect to another module below
// these are placed -10deg off-center -> counterparts should be placed 10deg off center
module connectors_male(angle, base_radius, base_height, wall_thickness) {
	width = 10; // in degrees
	rotate([0,0,angle+width]) 
		rotate_extrude(angle=width, $fn=200) 
			translate([-base_radius+wall_thickness ,base_height-2]) 
				polygon( points=[[0,0],[0,5],[4,5],[4,2], [1,2],[1,3],[2,4],[3,4],[3,2]], paths=[[4,5,6,7,8]] );
}


/* I happened to be working on the same connectors yesterday night.
Alternative method to design the female connector using a chamfer instead of the polygon function.
Just some dummy values were used for the female connector since I didn't know the correct values.
Also a simple method to create a fillet possibly needed later on. 
*/

/*library for basic operations for the NodeMCU
*/


//triangle needed for a chamfer.
//d is the length of two sides of the triangle
module triangle(d) {
    r=d/2;
    translate([d/2,d/2])
    rotate([0,0,180])
    difference() {
        square(d, center=true);
        translate([-r,-r]) rotate([0,0,45]) square(d*sqrt(2), center=true);
    }
}

//fillet module the fillet is added! to the square
//increasing the size of the square
module fillet(l,w,f) {
    minkowski() {
        square([l,w],$fn=30);
        circle(r=f,$fn=30);
    }
}

//chamfer of a cube where l, w and th define the cube
//d specifies the two sides of the chamfer 
module chamfer(l,w,th,d) {
    difference() {
        cube([l,w,th]);
        linear_extrude(th) triangle(d);
    }
}

//female connector module where three chamfers are neccesary
//this thing needs a lot of arguments
module connectors_female(l1,w1,th1,d1,d2,l2,w2,t1,t2) {
    difference() {
        difference() {
            cube([l1,w1,th1]);
            linear_extrude(th1) triangle(d1);
            linear_extrude(th1) translate([l1,w1,0]) rotate([0,0,180]) triangle(d2);
        }

        translate([t1,t2,0])
        difference() {
            cube([l2,w2,th1]);
            linear_extrude(th1) translate([l2,w2,0]) rotate([0,0,180]) triangle(d2);
        }   
    }
}


//MAIN

/* Demonstration of chamfer, press F6 to see the resulting chamfer
*/
//chamfer(100,100,15,30);


/* demonstration of the fillet (only with square) 
remove double slash below for demonstration
*/
//linear_extrude(15) fillet(20,20,1);

/* lock female
demonstration of a double the chamfer in a cube with another
chamfered cube substracted */

connectors_female(100,150,20,40,30,40,50,30,70);
