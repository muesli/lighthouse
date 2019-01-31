base_radius = 31.4;
base_height = 28.6;
wall_thickness = 3;
width = base_radius * 2;

color([0.8, 0.2, 0.1]) difference() {
    cylinder(h=base_height, d=width, center=true);
    translate([0,0,wall_thickness]) cylinder(h=base_height, d=width-wall_thickness*2, center=true);
}
