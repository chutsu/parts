$fn = 40;

module frame_top() {
  width = 40.0;
  thickness = 3.0;

  tolerance = 1.2;
  screw_size = 2.0;
  screw_safe_size = screw_size * tolerance;

  standoff_size = screw_safe_size * 1.9;
  standoff_height = 5.0;

  cube([width, width, thickness], center=true);

  tx = (width / 2) - standoff_size / 2;
  ty = (width / 2) - standoff_size / 2;
  tz = thickness / 2;
  for (i = [0.0:90.0:360.0]){
    rotate([0.0, 180.0, i])
      difference() {
        translate([tx, ty, tz])
          cylinder(r = standoff_size / 2, h = standoff_height);

        translate([tx, ty, tz + 1])
          cylinder(r = screw_safe_size / 2, h = standoff_height);
      }
  }
}

frame_top();
