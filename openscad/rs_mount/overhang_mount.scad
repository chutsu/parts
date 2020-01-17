module overhang_mount() {
  mount_w = 58.0;
  mount_l = 40.0;
  mount_h = 25.0;
  mount_thickness = 5.0;

  tolerance = 1.02;
  mount_screw_size = 3.0;
  mount_screw_safe_size = mount_screw_size * tolerance;
  btm_mount_screw_size = 2.0;
  btm_mount_screw_safe_size = mount_screw_size * tolerance;

  over_hang_holes_w = 34.0;
  bottom_hang_holes_w = 25.0;

  difference() {
    // Main body
    cube([mount_w + mount_thickness,
          mount_l,
          mount_h], center=true);

    // Overhang cutout
    cube([mount_w,
          mount_l + mount_thickness,
          mount_h - mount_thickness], center=true);

    // Reduce cutout
    translate([0.0, 14.0, mount_thickness / 2.0])
      cube([mount_w + mount_thickness,
            14,
            mount_h], center=true);

    translate([0.0, -14.0, mount_thickness / 2.0])
      cube([mount_w + mount_thickness,
            14,
            mount_h], center=true);

    // Overhang mount holes
    translate([over_hang_holes_w / 2.0, 0.0, 12.0])
      cylinder(r=mount_screw_safe_size/2, h=20, center=true);
    translate([-over_hang_holes_w / 2.0, 0.0, 12.0])
      cylinder(r=mount_screw_safe_size/2, h=20, center=true);

    // Bottom mount holes
    translate([0.0, bottom_hang_holes_w / 2.0, -10.0])
      cylinder(r=btm_mount_screw_safe_size/2, h=20, center=true);
    translate([0.0, -bottom_hang_holes_w / 2.0, -10.0])
      cylinder(r=btm_mount_screw_safe_size/2, h=20, center=true);
  }
}

include <camera_mount.scad>
$fn = 30;
overhang_mount();

// translate([0.0, -32.0, -14.0])
//   camera_mount();
