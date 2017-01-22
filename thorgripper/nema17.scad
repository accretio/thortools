
// this is the stepper motor (https://github.com/jcrocholl/kossel)

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Placement for the NEMA17 stepper motors.
motor_offset = 44;
motor_length = 34.1;

nema_tolerance = 0.2;

module nema17() {
  // NEMA 17 stepper motor.
      translate([0, 0, -motor_length/2]) 
        cube([42.3, 42.3, motor_length], center=true);
      
}


 
