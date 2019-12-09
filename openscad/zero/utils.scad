module standoff(screw_size = 2.0,
                standoff_height = 5.0,
                tolerance = 1.2) {
  screw_safe_size = screw_size * tolerance;
  standoff_size = screw_safe_size * 1.9;

  difference() {
    cylinder(r = standoff_size / 2, h = standoff_height);
    cylinder(r = screw_safe_size / 2, h = standoff_height);
  }
}

module hexagon(size, height) {
  width = size / 1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([width, size, height], true);
}
