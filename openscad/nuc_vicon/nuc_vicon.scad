$fn = 30;
width = 10.0;
length = 70.0;
height = 5.0;
marker_size = 15;
marker_r = marker_size / 2;

module marker_stand() {
  // Forward arm
  difference(){
    translate([-width / 2, 0, 0])
      cube([width, length - 10, height]);

    // Marker mount
    translate([0, length - marker_r - 10, marker_size / 2 + height / 3])
      sphere(r = (marker_size / 2));

    // Screw hole
    translate([0, length - marker_r - 10, -1.0])
      cylinder(r = 2, h=height + 1.0);
  }

  // Left arm
  difference(){
    rotate([0, 0, 90])
      translate([-width / 2, 0, 0])
        cube([width, length - 20, height]);

    // Marker mount
    rotate([0, 0, 90])
      translate([0, length - marker_r - 20, marker_size / 2 + height / 3])
      sphere(r = (marker_size / 2));

    // Screw hole
    rotate([0, 0, 90])
      translate([0, length - marker_r - 20, -1.0])
      cylinder(r = 2, h=height + 1.0);
  }

  // Bottom Left arm
  difference(){
    rotate([0, 0, 135])
      translate([-width / 2, 0, 0])
        cube([width, length, height]);

    // Marker mount
    rotate([0, 0, 135])
      translate([0, length - marker_r, marker_size / 2 + height / 3])
      sphere(r = (marker_size / 2));

    // Screw hole
    rotate([0, 0, 135])
      translate([0, length - marker_r, -1.0])
      cylinder(r = 2, h=height + 1.0);
  }

  // Right arm
  difference(){
    rotate([0, 0, 270])
      translate([-width / 2, 0, 0])
        cube([width, length, height]);

    // Marker mount
    rotate([0, 0, 270])
      translate([0, length - marker_r, marker_size / 2 + height / 3])
      sphere(r = (marker_size / 2));

    // Screw hole
    rotate([0, 0, 270])
      translate([0, length - marker_r, -1.0])
      cylinder(r = 2, h=height + 1.0);
  }

  // Primary mount
  difference() {
    rotate([180.0, 0.0, 0.0])
      cylinder(r = 3, h=6);

    rotate([180.0, 0.0, 0.0])
    translate([0.0, 0.0, -10])
      cylinder(r = 1, h=30);
  }

  // Secondary mount
  difference() {
    rotate([180.0, 0.0, 0.0])
      translate([30.0, 0.0, 0.0])
      cylinder(r = 3, h=6);

    rotate([180.0, 0.0, 0.0])
      translate([30.0, 0.0, -10])
      cylinder(r = 1, h=30);
  }
}

marker_stand();
