$fn = 30;

/* PCB Parameters */
pcb_width = 95.0 + 6.6;
pcb_depth = 90.4 + 10.4;
pcb_padding = 15.0;

/* Panel Parameters */
panel_thickness = 2.5;
panel_indent = 3;

/* Case Parameters */
case_thickness = 3;
case_width = pcb_width + pcb_padding;
case_depth = pcb_depth + pcb_padding + panel_indent + panel_thickness;
case_height = 30;

module front_panel(thickness = 2.5,
                   indent = 7) {
  x = case_depth - panel_indent - panel_thickness;
  y = case_thickness / 2.0;
  z = case_thickness / 2.0;

  difference() {
    // Plate
    translate([x, y, z])
    cube([thickness,
          case_width - case_thickness,
          case_height]);

    // Ports
    // -- Power switch
    // translate([x - 0.5, 80.5, 6.0])
    translate([x - 0.5, 82, 6.0])
    cube([thickness + 1.0, 8, 8]);

    // -- USB ports
    translate([x - 0.5, 35.5, 6.0]) cube([thickness + 1.0, 15, 8]);
    translate([x - 0.5, 52.5, 6.0]) cube([thickness + 1.0, 15, 8]);
  }
}

module back_panel(thickness = 2.5,
                  indent = 7) {
  x = panel_indent;
  y = case_thickness / 2.0;
  z = case_thickness / 2.0;

  difference() {
    // Plate
    translate([x, y, z])
    cube([thickness,
          case_width - case_thickness,
          case_height]);

    // IO Ports
    // -- Power port
    translate([x - 0.5, 91.5, 4.0])
    cube([thickness + 1.0, 11, 10]);

    // -- USB ports
    translate([x - 0.5, 35.5, 4.0])
    cube([thickness + 1.0, 17, 16]);

    // -- HDMI ports
    translate([x - 0.5, 72.0, 6.0]) cube([thickness + 1.0, 17.0, 8.0]);
    translate([x - 0.5, 14.5, 6.0]) cube([thickness + 1.0, 17.0, 8.0]);

    // -- Ethernet port
    translate([x - 0.5, 53.5, 6.0]) cube([thickness + 1.0, 17.0, 14.0]);

    // -- Heat sink vent
    translate([x - 0.5, 29.0, 21.0]) cube([thickness + 1.0, 56.0, 6.0]);
  }
}

module fixtures() {
  y = case_thickness / 2.0 + case_thickness;
  z = case_height / 2.0 + case_thickness / 2;
  difference() {
    translate([case_depth * 0.25, y, z])
      translate([0, 0, 2])
      cube([20, case_thickness, 20],
            center=true);

    translate([case_depth * 0.25, y, z + 6])
      rotate([0.0, 90.0, 90.0])
      cylinder(h=case_thickness * 1.01, r=0.7, center=true);
  }

  difference() {
    translate([case_depth * 0.75, y, z])
      translate([0, 0, 2])
      cube([20, case_thickness, 20],
            center=true);

    translate([case_depth * 0.75, y, z + 6])
      rotate([0.0, 90.0, 90.0])
      cylinder(h=case_thickness * 1.01, r=0.7, center=true);
  }
}

module mount_holes() {
  y = case_width - case_thickness / 2;
  z = case_height / 2.0 + case_thickness / 2;
  translate([case_depth * 0.25, y, z - 6])
    rotate([0.0, 90.0, 90.0])
    cylinder(h=case_thickness * 1.01, r=1.0, center=true);

  translate([case_depth * 0.75, y, z - 6])
    rotate([0.0, 90.0, 90.0])
    cylinder(h=case_thickness * 1.01, r=1.0, center=true);
}

module case() {
  difference() {
    color([0.2, 0.2, 0.2]) {
      // Base
      translate([0.0, case_thickness / 2, 0.0])
      cube([case_depth, case_width - case_thickness, case_thickness]);

      // Right wall
      translate([0.0, 0.0, case_thickness / 2])
      cube([case_depth, case_thickness, case_height / 2]);
      // -- Fillet
      translate([case_depth/ 2.0, case_thickness / 2.0, case_thickness / 2.0])
      rotate([0.0, 90.0, 0.0])
      cylinder(h=case_depth, r=case_thickness / 2, center=true);

      // Left wall
      translate([0.0, case_width - case_thickness, case_thickness / 2])
      cube([case_depth, case_thickness, case_height / 2]);
      // -- Fillet
      x = case_depth / 2.0;
      y = case_thickness / 2.0 + case_width - case_thickness;
      z = case_thickness / 2.0;
      translate([x, y, z])
      rotate([0.0, 90.0, 0.0])
      cylinder(h=case_depth, r=case_thickness / 2, center=true);
    }

    // Front panel groove
    front_panel(panel_thickness + 0.3, panel_indent);
    back_panel(panel_thickness + 0.3, panel_indent);

    // Mount holes
    mount_holes();
  }

  fixtures();
}

module base_shell() {
  translate([-case_depth / 2.0, -case_width / 2.0, 0.0])
  case();
}

module top_shell() {
  difference() {
    // Case
    translate([-case_depth / 2.0, -case_width / 2.0, 0.0])
    translate([0.0, case_width, case_height + case_thickness])
      rotate([180.0, 0.0, 0.0])
        case();

    // Vent hole
    translate([-case_depth / 2.0, -case_width / 2.0, 0.0])
    translate([0.0, case_width, case_height + case_thickness])
    translate([case_depth / 2.0 + 24, -case_width / 2 - 4.5, -case_thickness - 1])
      cylinder(r=18, h=10);
  }
}

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

module standoffs() {
  standoff_r = 2.5;
  standoff_w = 95.0;
  standoff_d = 90.4;
  standoff_h = 11;

  x = 0.0;
  y = 0.0;
  z = standoff_h / 2 + case_thickness;

  translate([x, y, z]) {
    translate([-standoff_d / 2.0, -standoff_w / 2.0, 0.0])
      standoff(standoff_h, standoff_r);

    translate([standoff_d / 2.0, -standoff_w / 2.0, 0.0])
      standoff(standoff_h, standoff_r);

    translate([standoff_d / 2.0, standoff_w / 2.0, 0.0])
      standoff(standoff_h, standoff_r);

    translate([-standoff_d / 2.0, standoff_w / 2.0, 0.0])
      standoff(standoff_h, standoff_r);
  };
}

// // Main
// // -- NUC case
// translate([0, 0, -16.5 + case_thickness])
//   rotate([90.0, 0.0, 90.0])
//   import("/home/chutsu/FreeCAD/components/intel_nuc_7i5dn.stl");
//
// // -- Bottom shell
// color("blue") base_shell(); standoffs();
//
// // -- Top shell
// translate([0, 0, 0.1]) color("red") top_shell();

// // -- Front panel
// translate([-case_depth / 2.0, -case_width / 2.0, 0.0])
// front_panel();

// -- Back panel
translate([-case_depth / 2.0, -case_width / 2.0, 0.0])
back_panel();
