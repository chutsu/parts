module bottom_mount() {
  mount_w = 58.0;
  mount_l = 5.0;
  mount_h = 25.0;
  mount_thickness = 5.0;

  tolerance = 1.02;
  mount_screw_size = 3.0;
  mount_screw_safe_size = mount_screw_size * tolerance;

  over_hang_holes_w = 34.0;
  bottom_hang_holes_w = 25.0;
  camera_braket_mount_w = 15.0;

  difference() {
    // Top plate
    translate([0.0, 0.0, mount_h / 2 + mount_thickness / 2])
      cube([mount_w, 40, mount_thickness], center=true);

    // Bottom mount holes
    translate([0.0, bottom_hang_holes_w / 2.0, 15.0])
      cylinder(r=mount_screw_safe_size/2, h=20, center=true);

    translate([0.0, -bottom_hang_holes_w / 2.0, 15.0])
      cylinder(r=mount_screw_safe_size/2, h=20, center=true);
  }

  difference() {
    // Mount
    cube([mount_w, mount_l, mount_h], center=true);

    // Mount holes
    translate([camera_braket_mount_w / 2.0, 0.0, 0.0])
      rotate([90.0, 0.0, 0.0])
        cylinder(r=mount_screw_safe_size/2, h=20, center=true);

    translate([-camera_braket_mount_w / 2.0, 0.0, 0.0])
      rotate([90.0, 0.0, 0.0])
        cylinder(r=mount_screw_safe_size/2, h=20, center=true);
  }
}

$fn=30;
bottom_mount();
