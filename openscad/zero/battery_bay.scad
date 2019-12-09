include <utils.scad>;
include <lipo.scad>;

module battery_bay() {
  bay_width = 140.0;
  bay_length = 50.0;
  bay_height = 20.0;
  bay_thickness  = 3.0;

  screw_size = 2.0;
  standoff_height = 5.0;
  tolerance = 1.3;
  screw_safe_size = screw_size * tolerance;
  standoff_size = screw_safe_size * 1.9;

  x = 40 / 2.0;
  y = 40 / 2.0;
  z = bay_height;
  standoff_coords = [[x, y, z], [-x, y, z], [x, -y, z], [-x, -y, z]];

  // Standoffs
  for (i = standoff_coords) {
    translate(i)
      standoff(screw_size, standoff_height, tolerance);
  }

  // Bay
  round_size = 2.5;
  difference() {
    // Bay body
    linear_extrude(bay_height)
      offset(r=round_size)
        square([bay_width, bay_length], center=true);

    // Bay hull
    translate([0.0, 0.0, -2.0])
      linear_extrude(bay_height)
        offset(r=round_size)
          square([bay_width - 4, bay_length - 4], center=true);

    // Bay cutouts on the side
    translate([0.0, 0.0, (bay_height * 0.4) / 2.0])
      cube([bay_width * 0.8,
            bay_length * 1.5,
            bay_height * 0.4],
            center=true);

    // Bay cutouts on the front and back
    translate([0.0, 0.0, (bay_height * 0.4) / 2.0])
      cube([bay_width * 1.5,
            bay_length * 0.8,
            bay_height * 0.4],
            center=true);

    // Mount holes through both standoffs and bay body
    for (i = standoff_coords) {
      translate(i)
        cylinder(r=screw_safe_size / 2, h=100, center=true);
    }
  }

  // Battery strap mounts
  strap_w = 23.0;
  strap_l = 7.0;
  strap_h = 5.0;
  strap_tx = (bay_width / 2) * 0.6;
  strap_ty = (bay_length / 2) - (strap_l / 2);
  strap_tz = bay_height + strap_h / 2;
  strap_coords = [
    [strap_tx, strap_ty, strap_tz],
    [-strap_tx, strap_ty, strap_tz],
    [strap_tx, -strap_ty, strap_tz],
    [-strap_tx, -strap_ty, strap_tz]
  ];

  for (strap_position = strap_coords) {
    difference() {
      translate(strap_position)
        cube([strap_w, strap_l, strap_h], center=true);

      translate(strap_position)
        translate([0.0, 0.0, -3.0 / 2])
          cube([strap_w - 4, strap_l, strap_h], center=true);
    }
  }

  // translate([-(bay_width / 2) * 0.6, 0.0, bay_height + strap_h / 2])
  //   #cube([strap_w, strap_l, strap_h], center=true);
}

$fn=30;
battery_bay();
// translate([0.0, 0.0, 0.0]) lipo();
