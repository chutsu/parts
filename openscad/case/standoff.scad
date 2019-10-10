module standoff(h=11, r=2) {
  nipple_h = h * 0.8;

	// Standoff
  difference() {
    cylinder(h=h, r=r, center=true);

    translate([0.0, 0.0, h / 2.0 - nipple_h / 2.0])
      cylinder(h=nipple_h + 0.1, r=0.8, center=true);
  }

	// Fillet
	fillet_h_inc = 0.1;
	fillet_h = 2.0;
	for (fillet_height = [fillet_h_inc:fillet_h_inc:fillet_h]) {
		translate([0.0, 0.0, -h / 2.0 + fillet_height])
			cylinder(h=0.1, r=r * 1.5 - fillet_height);
	}
}
