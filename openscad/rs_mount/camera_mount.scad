module camera_mount() {
  cam_angle = 60.0;
  over_hang_holes_w = 34.0;
  bottom_hang_holes_w = 25.0;
  rs_mount_holes_w = 45.0;

  mount_w = 30.0;
  mount_l = 53.0;
  mount_thickness = 3.0;

  tolerance = 1.02;
  mount_screw_size = 3.0;
  mount_screw_safe_size = mount_screw_size * tolerance;
  cam_mount_buffer_size = mount_screw_safe_size * 1.6;

  union() {
    // Mount body
    translate([0.0, 26.1, 0.0])
    difference() {
      cube([mount_w, mount_l, mount_thickness], center=true);

      // Mount holes
      translate([0.0, 6.0, 0.0])
        translate([0.0, bottom_hang_holes_w / 2.0, 0.0])
          cylinder(r=mount_screw_safe_size/2, h=20, center=true);

      translate([0.0, 6.0, 0.0])
        translate([0.0, -bottom_hang_holes_w / 2.0, 0.0])
          cylinder(r=mount_screw_safe_size/2, h=20, center=true);
    }

    // Camera bracket body
    difference() {
      rotate([-90.0 + cam_angle, 0.0, 0.0])
        cube([60, 20, mount_thickness], center=true);

      // Mount holes
      rotate([-90.0 + cam_angle, 0.0, 0.0])
        translate([rs_mount_holes_w / 2.0, 0.0, 0.0])
          cylinder(r=mount_screw_safe_size/2, h=20, center=true);

      rotate([-90.0 + cam_angle, 0.0, 0.0])
        translate([-rs_mount_holes_w / 2.0, 0.0, 0.0])
          cylinder(r=mount_screw_safe_size/2, h=20, center=true);
    }

    // // Mount hole buffer
    // difference() {
    //   rotate([-90.0 + cam_angle, 0.0, 0.0])
    //     translate([-rs_mount_holes_w / 2.0, 0.0, mount_thickness / 2 + 1])
    //       cylinder(r=cam_mount_buffer_size / 2, h=2, center=true);
    //
    //   rotate([-90.0 + cam_angle, 0.0, 0.0])
    //     translate([-rs_mount_holes_w / 2.0, 0.0, mount_thickness / 2 + 1])
    //       cylinder(r=mount_screw_safe_size / 2, h=2, center=true);
    // }
    // difference() {
    //   rotate([-90.0 + cam_angle, 0.0, 0.0])
    //     translate([rs_mount_holes_w / 2.0, 0.0, mount_thickness / 2 + 1])
    //       cylinder(r=cam_mount_buffer_size / 2, h=2, center=true);
    //
    //   rotate([-90.0 + cam_angle, 0.0, 0.0])
    //     translate([rs_mount_holes_w / 2.0, 0.0, mount_thickness / 2 + 1])
    //       cylinder(r=mount_screw_safe_size / 2, h=2, center=true);
    // }
  }
}

$fn = 30;
camera_mount();
