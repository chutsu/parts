$fn = 40;
include <arm.scad>;
include <lipo.scad>;
include <battery_bay.scad>;

off_center = 20.0;

frame_thickness = 4;
frame_size = 210.0;

plate_width = 100;
plate_thickness = 4;

slot_width = 12.0;
slot_inner_width = 8.5;
slot_length = sqrt(pow(plate_width / 2, 2) + pow(plate_width / 2, 2)) * 0.6;

lipo_width = 138;
lipo_height = 45;
lipo_length = 30;

module plate() {
  // Main plate
  difference() {
    // Plate
    cube([plate_width, plate_width, plate_thickness], center=true);

    // Corner cuts
    for (i = [45.0:90.0:315]) {
      rotate([0.0, 0.0, i])
      translate([plate_width / 2.0 + 22.5, 0.0, 0.0])
        cube([20.0, 40.0, plate_thickness + 1.0], center=true);
    }

    // Center hole
    translate([0.0, 0.0, -(plate_thickness / 2.0) - 1.0])
      cylinder(r=10, h=plate_thickness + 2.0);
  }

  // // Plate reinforcements
  // for (i = [0.0:90.0:360]) {
  //   rotate([0.0, 0.0, i])
  //   translate([plate_width / 2.0 - 40.0 / 2.0, 0.0, -plate_thickness + 0.5])
  //     cube([40.0, 3.0, 3.0], center=true);
  // }

  // Arm slots
  for (i = [45.0:90.0:315]){
    difference() {
      dy = -(slot_width / 2.0) - (plate_thickness / 2.0);
      dz = (slot_length / 2) + off_center;

      // Slot body
      rotate([90.0, 0.0, i])
        translate([0.0, dy, dz])
        cube([slot_width, slot_width, slot_length], center=true);

      // Slot Hole
      rotate([90.0, 0.0, i])
        translate([0.0, dy, dz])
        cube([slot_inner_width, slot_inner_width, slot_length + 1], center=true);
    }
  }
}

module plate_with_holes() {
  tolerance = 1.2;   // Ratio
  screw_size = 2.0;  // Diameter
  screw_safe_size = screw_size * tolerance;

  difference() {
    plate();

    // Arm fixtures
    slot_length = sqrt(pow(plate_width / 2, 2) + pow(plate_width / 2, 2));
    primary_offset = round(slot_length * 0.75);
    secondary_offset = round(slot_length * 0.4);
    echo("primary_offset: ", primary_offset);
    echo("secondary_offset: ", secondary_offset);
    for (i = [45.0:90.0:315]){
      rotate([0.0, 0.0, i])
        translate([primary_offset, 0.0, 0.0])
        cylinder(r=screw_safe_size / 2, h=40, center=true);

      rotate([0.0, 0.0, i])
        translate([secondary_offset, 0.0, 0.0])
        cylinder(r=screw_safe_size / 2, h=40, center=true);
    }
  }
}

// Add plate
plate_with_holes();

// Add arms
dy = -(slot_width / 2.0) - (plate_thickness / 2.0);
translate([0.0, 0.0, dy])
for ( i = [-45.0:90.0:225.0] ){
  rotate([0.0, 90.0, i])
  translate([0.0, 0.0, off_center])
    arm();
}

// translate([0.0, 0.0, -18])
//   battery_bay();

translate([0.0, 0.0, 27])
  rotate([180.0, 0.0, 0.0])
    battery_bay();

// Lipo
// translate([0, 0, -37]) lipo(lipo_width, lipo_height, lipo_length);
