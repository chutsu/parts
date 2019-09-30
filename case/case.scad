$fn = 20;

/* Parameters */
case_width = 200;
case_depth = 120;
case_height = 30;
case_thickness = 3;
panel_thickness = 2.5;
panel_indent = 3;

module front_panel(thickness = 2.5,
                   indent = 7) {
  x = case_depth - indent - thickness;
  y = case_thickness / 2;
  z = case_thickness / 2;
  translate([x, y, z])
  cube([thickness,
        case_width - case_thickness,
        case_height]);
}

module back_panel(thickness = 2.5,
                  indent = 7) {
  x = indent;
  y = case_thickness / 2;
  z = case_thickness / 2;
  translate([x, y, z])
  cube([thickness,
        case_width - case_thickness,
        case_height]);
}

module fixtures() {
  y = case_thickness + case_thickness / 4;
  z = case_height / 2.0 + case_thickness / 2;
  difference() {
    translate([case_depth * 0.25, y, z])
      translate([0, 0, 2])
      cube([20, case_thickness / 2, 20],
            center=true);

    translate([case_depth * 0.25, y, z + 6])
      rotate([0.0, 90.0, 90.0])
      cylinder(h=case_thickness * 1.01, r=1.5, center=true);
  }

  difference() {
    translate([case_depth * 0.75, y, z])
      translate([0, 0, 2])
      cube([20, case_thickness / 2, 20],
            center=true);

    translate([case_depth * 0.75, y, z + 6])
      rotate([0.0, 90.0, 90.0])
      cylinder(h=case_thickness * 1.01, r=1.5, center=true);
  }
}

module mount_holes() {
  y = case_width - case_thickness / 2;
  z = case_height / 2.0 + case_thickness / 2;
  translate([case_depth * 0.25, y, z - 6])
    rotate([0.0, 90.0, 90.0])
    cylinder(h=case_thickness * 1.01, r=2.0, center=true);

  translate([case_depth * 0.75, y, z - 6])
    rotate([0.0, 90.0, 90.0])
    cylinder(h=case_thickness * 1.01, r=2.0, center=true);
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

    // Front and back panel grooves
    front_panel(panel_thickness + 0.3, panel_indent);
    back_panel(panel_thickness + 0.3, panel_indent);
    mount_holes();
  }

  fixtures();
}

module base_shell() {
  case();
}

module top_shell() {
  translate([0.0, case_width, case_height + case_thickness])
    rotate([180.0, 0.0, 0.0])
      case();
}

// Main
color("blue") base_shell();
translate([0, 0, 0.1]) color("blue") top_shell();

color("grey") front_panel(panel_thickness, panel_indent);
color("grey") back_panel(panel_thickness, panel_indent);
