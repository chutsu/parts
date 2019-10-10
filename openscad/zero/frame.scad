$fn = 40;
include <arm.scad>;

frame_thickness = 4;
frame_size = 210.0;

arm_length = frame_size / 2.0;
arm_width = 15.0;

body_width = 60;
body_depth= 60;

off_center = 20.0;
rotate([0.0, 90.0, -45.0]) translate([0.0, 0.0, off_center]) arm();
rotate([0.0, 90.0, 45.0]) translate([0.0, 0.0, off_center]) arm();
rotate([0.0, 90.0, 135.0]) translate([0.0, 0.0, off_center]) arm();
rotate([0.0, 90.0, 225.0]) translate([0.0, 0.0, off_center]) arm();
