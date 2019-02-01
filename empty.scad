
use <common.scad>

module empty(base_radius, empty_height, wall_thickness){

	shell(base_radius*2, empty_height, wall_thickness, false);

	// male cnnectors (to below)
	connectors_male(90, base_radius, wall_thickness);
	connectors_male(270, base_radius, wall_thickness);

	// female connectors (to above)
	connectors_female(90, base_radius, empty_height, wall_thickness);
	connectors_female(270, base_radius, empty_height, wall_thickness);
		
}