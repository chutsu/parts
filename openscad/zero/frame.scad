$fn = 40;
include <arm.scad>;

frame_thickness = 4;
frame_size = 210.0;

arm_length = frame_size / 2.0;
arm_width = 15.0;

off_center = 5.0;
translate([0.0, 0.0, -1.5])
for ( i = [-45.0:90.0:225.0] ){
  rotate([0.0, 90.0, i]) translate([0.0, 0.0, off_center]) arm();
}

module plate() {
  body_width = 100;
  body_length = 100;
  body_height = 4;
  difference() {
    cube([body_width, body_length, body_height], center=true);

    for (i = [45.0:90.0:315]) {
      rotate([0.0, 0.0, i])
      translate([body_width / 2.0 + 22.5, 0.0, 0.0])
        cube([20.0, 40.0, body_height + 1.0], center=true);
    }
  }

  for (i = [0.0:90.0:360]) {
    rotate([0.0, 0.0, i])
    translate([body_width / 2.0 - 40.0 / 2.0, 0.0, -body_height + 0.5])
      #cube([40.0, 3.0, 3.0], center=true);
  }
}

translate([0.0, 0.0, 4.0 + 2.5])
  plate();

for (i = [45.0:90.0:315]){
  difference() {
  rotate([90.0, 0.0, i])
    translate([0.0, -1.5, 40.0])
    cube([12.0, 12.0, 45.0], center=true);

  rotate([90.0, 0.0, i])
    translate([0.0, -1.5, 40.0])
      cube([8.5, 8.5, 45.0], center=true);
  }
}
