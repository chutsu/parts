module arm(width=8, height=8, length=200, thickness=1) {
  difference() {
    color("black")
    translate([0.0, 0.0, length / 2.0])
    cube([width, height, length],
         center=true);

    translate([0.0, 0.0, (length / 2.0) - 1.0])
    cube([width - thickness, height - thickness, length + 3.0],
         center=true);
  }
}

// arm(8, 8, 200, 1);
