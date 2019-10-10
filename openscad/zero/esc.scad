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
