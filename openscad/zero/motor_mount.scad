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
