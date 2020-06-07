// create main enclosure
module shell(diameter, height, wall_thickness, base) {
	translate([0, 0, height/2])
		difference() {
			cylinder(h = height, d = diameter, center = true);
				if (base) // remove core, keep bottom
					translate([0,0,wall_thickness])
						cylinder(h = height, d = diameter-wall_thickness*2, center = true);
				else // remove core, no bottom
					cylinder(h = height+1, d = diameter-wall_thickness*2, center = true);
		}
}

// connectors to receive another module on top
// these are placed 10deg off-center -> counterparts should be placed -10deg off center
module connectors_female(angle, base_radius, height, wall_thickness) {
	width = 7; // in degrees
	rotate([0,0,angle])
		intersection(){ // only needed for openscad <2018
			//rotate_extrude(angle = width, $fn = 200) // works in openscad >2018
			rotate_extrude($fn = 200) // works in openscad <2018 incl. thingiverse
				translate([-base_radius + wall_thickness, height-5.7]) //0.3 to center scaled male pin
					polygon(
						points = [[0,0],[0,12],[1,15],[7.8,15],[7.8,5],[1.8,0], [1.5,5.7],[1.5,5.7+3.8],[1.5+2.5,5.7+6.3],[1.5+4.5,5.7+6.3],[1.5+4.5,5.7]],
						paths = [[0,1,2,3,4,5], [6,7,8,9,10,11]]
					);
			// only needed for openscad <2018
			translate([-3*base_radius,0,height-5.7])
				cube([3*base_radius,width,13]);
		}
}

// connectors to connect to another module below
module connectors_male(angle, base_radius, wall_thickness) {
	width = 8; // in degrees for openscad >2018 / in mm for openscad <2018
	//pin
	rotate([0,0,angle]) {
		intersection() { // only needed for openscad <2018
			//rotate_extrude(angle = width, $fn = 200)  // works in openscad >2018
			rotate_extrude($fn = 200) // works in openscad <2018 incl. thingiverse
				translate([-base_radius + wall_thickness, -5.7 ])
					translate([0.45,0]) // counteract the non-centered scale (but leave flat on build plate)
						scale([0.82,0.92]) // scale to leave room for easier connection (=-[0.9,0.9]mm)
							polygon(
								points = [[1.5,5.7],[1.5,9.5],[4,12],[6,12],[6,5.7]],
								paths = [[0,1,2,3,4,5]]
							);
			// only needed for openscad <2018
			translate([-3*base_radius,0,0])
				cube([3*base_radius,width,13]);
		}
	}

	// pin-base
	rotate([0,0,angle])
		intersection() { // only needed for openscad <2018
			//rotate_extrude(angle = width, $fn = 200) // works in openscad >2018
			rotate_extrude($fn = 200) // works in openscad <2018 incl. thingieverse
				translate([-base_radius + wall_thickness, -5.7])
					polygon(
						points = [[0,5.7],[0,12],[1,15],[6,15],[6,5.7],[1.8,5.7]],
						paths = [[0,1,2,3,4,5]]
					);
			// only needed for openscad <2018
			translate([-3*base_radius, -width*0.8, 0]) // arbitrarily scaled to 80% width
				cube([3*base_radius, width*0.8, 13]);
		}
}

// cut array of venting holes
module venting_holes(angle, base_radius, base_height, xnum, ynum, twosided) {
	width = 1;
	spacing = 1.5;

	rotate([0,0,angle])
		for(y = [0 : width+spacing : (width+spacing)*ynum])
		{
			for(x = [0 : width+spacing : (width+spacing)*xnum])
			{
				translate([x - ((width+spacing)*xnum/2), -base_radius*1.25, y - ((width+spacing)*ynum/2) + base_height/2]) {
					if (twosided) {
						cube([width,2.5*base_radius,width]);
					} else {
						cube([width,1.5*base_radius,width]);
					}
				}
			}
		}
}

// Add rim to top of module. The connector_cutouts should be an array of the angles
// for each connector (what was passed in to connectors_male)
module rim(base_radius, height, wall_thickness, rim_height = 1.2, rim_width = 1)
{
    translate([0,0,height - rim_height])
        difference()
        {
            cylinder(r = base_radius - wall_thickness + 0.01,
                     h = rim_height * 2);

            translate([0, 0, -0.01])
                cylinder(r = base_radius - wall_thickness - rim_width,
                         h = rim_height * 2+0.02);

            translate([0, 0, -0.01])
                cylinder(r2 = base_radius - wall_thickness - rim_width,
                         r1 = base_radius - wall_thickness + 0.01,
                         h = rim_height + 0.01);
        }
}
