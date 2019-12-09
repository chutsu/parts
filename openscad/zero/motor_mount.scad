include <utils.scad>;

module motor_mount(mount_holes_w = 16.0,
                   mount_holes_d = 19.0) {
  tolerance = 1.05;

  mount_thickness = 5;
  mount_size = 32;
  mount_screw_size = 3.0;
  mount_screw_safe_size = mount_screw_size * tolerance;

  arm_tolerance = 1.05;
  arm_size = 8.0;
  arm_safe_size = arm_size * arm_tolerance;
  arm_slot_thickness = 7.0;

  arm_screw_size = 2.0;  // Diameter
  arm_safe_screw_size = arm_screw_size * tolerance;
  hex_max_w = 4.0;

  // Motor mount
  difference() {
    // Motor plate
    minkowski() {
      cube([mount_size, mount_size, mount_thickness/ 2], center=true);
      cylinder(r=2.0, h=(mount_thickness / 2.0), center=true);
    }

    // Motor mount holes
    rotate([0.0, 0.0, -45.0]) {
      // // Top
      // translate([mount_holes_d / 2.0, mount_holes_d / 2.0, -0.1])
      //   cylinder(h=20, r=mount_screw_safe_size / 2, center=true);

      // Left
      translate([mount_holes_w / 2.0, -mount_holes_w / 2.0, -0.1])
        cylinder(h=20, r=mount_screw_safe_size / 2, center=true);

      // Right
      translate([-mount_holes_w / 2.0, mount_holes_w / 2.0, -0.1])
        cylinder(h=20, r=mount_screw_safe_size / 2, center=true);

      // // Bottom
      // translate([-mount_holes_d / 2.0, -mount_holes_d / 2.0, -0.1])
      //   cylinder(h=20, r=mount_screw_safe_size / 2, center=true);
    }

    // Arm mount recess
    translate([0.0, 0.0, 0.0])
      cylinder(h=20, r=4.0, center=true);
  }

  // Arm slot
  arm_slot_w = mount_size;
  arm_slot_l = arm_safe_size + arm_slot_thickness;
  arm_slot_h = arm_safe_size + arm_slot_thickness;

  arm_slot_hole_w = arm_slot_w;
  arm_slot_hole_l = arm_slot_l - arm_slot_thickness;
  arm_slot_hole_h = arm_slot_h - arm_slot_thickness;

  difference() {
    // Slot main body
    translate([0.0, 0.0, -(mount_thickness / 2) - (arm_slot_h / 2)])
      cube([arm_slot_w,
            arm_slot_l,
            arm_slot_h],
            center=true);

    // Slot hole
    translate([0.0, 0.0, -(mount_thickness / 2) - (arm_slot_h / 2)])
      cube([arm_slot_hole_w,
            arm_slot_hole_l,
            arm_slot_hole_h],
            center=true);

    // Access recess to motor screws
    rotate([0.0, 0.0, -45.0]) {
      translate([mount_holes_w / 2.0, -mount_holes_w / 2.0, 0.0])
        cylinder(r=4.5, h=100, center=true);
      translate([-mount_holes_w / 2.0, mount_holes_w / 2.0, 0.0])
        cylinder(r=4.5, h=100, center=true);
    }

    // Arm mount holes
    translate([0.0, 0.0, 0.0])
      cylinder(h=100, r=arm_safe_screw_size/2, center=true);
  }

  // Hex holder
  hex_holder_w = hex_max_w * 1.5;
  hex_holder_h = 2.0;
  hex_holder_z = -mount_thickness / 2 - arm_slot_thickness - arm_safe_size - hex_holder_h / 2;
  difference() {
    translate([0.0, 0.0, hex_holder_z])
      cylinder(h=hex_holder_h, r=hex_holder_w/2, center=true);

    translate([0.0, 0.0, hex_holder_z])
      hexagon(hex_max_w, hex_holder_h);
  }
}

$fn = 30;
motor_mount();
