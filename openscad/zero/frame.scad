$fn = 40;

frame_thickness = 4;
frame_size = 210.0;

arm_length = frame_size / 2.0;
arm_width = 15.0;

body_width = 60;
body_depth= 60;


module esc() {
  esc_w = 40.5;
  esc_d = 42.0;
  esc_h = 6.5;

  mount_holes_w = 30.5;
  mount_holes_d = 30.5;

  difference() {
    translate([0, 0, esc_h / 2.0])
    cube([esc_w, esc_d, esc_h], center=true);

    translate([mount_holes_w / 2.0, mount_holes_d / 2.0, -0.1])
      cylinder(h=esc_h + 0.2, r=1.5);

    translate([-mount_holes_w / 2.0, mount_holes_d / 2.0, -0.1])
      cylinder(h=esc_h + 0.2, r=1.5);

    translate([-mount_holes_w / 2.0, -mount_holes_d / 2.0, -0.1])
      cylinder(h=esc_h + 0.2, r=1.5);

    translate([mount_holes_w / 2.0, -mount_holes_d / 2.0, -0.1])
      cylinder(h=esc_h + 0.2, r=1.5);
  }
}

module motor_mount(mount_holes_w = 16.0,
                   mount_holes_d = 19.0) {
  difference() {
    // translate([0, 0, frame_thickness / 2.0])
    // cube([40.0, 40.0, frame_thickness], center=true);

    translate([0, 0, frame_thickness / 2.0])
    minkowski() {
      cube([32, 32, frame_thickness/ 2], center=true);
      cylinder(r=2.0, h=(frame_thickness / 2.0), center=true);
    }

    rotate([0.0, 0.0, -45.0]) {
      translate([mount_holes_d / 2.0, mount_holes_d / 2.0, -0.1])
        cylinder(h=frame_thickness + 0.2, r=1.5);

      translate([mount_holes_w / 2.0, -mount_holes_w / 2.0, -0.1])
        cylinder(h=frame_thickness + 0.2, r=1.5);

      translate([-mount_holes_w / 2.0, mount_holes_w / 2.0, -0.1])
        cylinder(h=frame_thickness + 0.2, r=1.5);

      translate([-mount_holes_d / 2.0, -mount_holes_d / 2.0, -0.1])
        cylinder(h=frame_thickness + 0.2, r=1.5);
    }
  }
}

module arm() {
  mount_holes_w = 16.0;
  mount_holes_d = 19.0;

  translate([0.0, -arm_width / 2.0, 0.0])
  cube([arm_length - mount_holes_w,
        arm_width,
        frame_thickness]);

  translate([arm_length, 0.0, 0.0])
    motor_mount(mount_holes_w, mount_holes_d);
}

module frame() {
  translate([0, 0, frame_thickness / 2.0])
  cube([body_width, body_depth, frame_thickness], center=true);

  rotate([0.0, 0.0, 45.0]) arm();
  rotate([0.0, 0.0, 135.0]) arm();
  rotate([0.0, 0.0, 225.0]) arm();
  rotate([0.0, 0.0, 315.0]) arm();
}



frame();

// color("red")
// translate([0, 0, frame_thickness])
// esc();
