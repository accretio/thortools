use <../utils/nema17.scad>
use <triangles.scad>
include <../thorgripper/nutsnbolts/cyl_head_bolt.scad>;
use <../../Thingiverse-Projects/Threaded Library/Thread_Library.scad>
use <MCAD/involute_gears.scad>


numberTeeth=25;
pitchRadius=20;

length=200;
radius=10;
pitch=2*3.1415*pitchRadius/numberTeeth;
distance=radius+pitchRadius+0.0*pitch;

angle=-360*$t;
offset=4;
module rod(clearance, l) {

     trapezoidThread( 
          length=l, 			// axial length of the threaded rod
          pitch=pitch,				 // axial distance from crest to crest
          pitchRadius=radius - clearance, 		// radial distance from center to mid-profile
          threadHeightToPitch=0.5, 	// ratio between the height of the profile and the pitch
          // std value for Acme or metric lead screw is 0.5
          profileRatio=0.5,			 // ratio between the lengths of the raised part of the profile and the pitch
          // std value for Acme or metric lead screw is 0.5
          threadAngle=20, 			// angle between the two faces of the thread
          // std value for Acme is 29 or for metric lead screw is 30
          RH=true, 				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
          clearance=clearance, 			// radial clearance, normalized to thread height
          backlash=clearance/5, 			// axial clearance, normalized to pitch
          stepsPerTurn=24 			// number of slices to create per turn
          );
     
}

thickness=10;

module wheel() {
     gear ( 
          number_of_teeth=numberTeeth,
          circular_pitch=360*pitchRadius/numberTeeth,
          pressure_angle=20,
          clearance = 0,
          gear_thickness=thickness,
          rim_thickness=thickness,
          rim_width=5,
          hub_thickness=thickness,
          hub_diameter=10,
          bore_diameter=5,
          circles=0,
          backlash=0.1,
          twist=-pitchRadius/radius,
          involute_facets=0,
          flat=false);
     
}

module positionned_rod(clearance=0.0, l=length) {
     tol = 0.4;
     difference() {
          union() {
               rod(clearance, l);
               cylinder(10, 10, 10);
          }
    
          color("blue") 
               cylinder(10, 5/2 + tol , 5/2 + tol, $fn=10);
          
     
     translate([7, 0, 5]) {
          rotate([0, 90, 0])
               nutcatch_sidecut("M3", l=100, clk=0.4, clh=0.4, clsl=0.4);
          translate([4, 0, 0])
               rotate([0, 90, 0])
               hole_through(name="M3", l=15, cl=0.1, h=5, hcl=0.4);
          
     }
     }
     }


module wheel_positionned(){
translate([-thickness/2,-distance,0])    
rotate([0, 90, 0])
wheel();
}


module nema17_shape() {
     module m3_hole(x, y) {
          color("red") {
               translate([x*31/2, y*31/2, 15])
                    hole_through(name="M3", l=10, cl=0.1, h=10, hcl=0.4);
          }
     }
     rotate([180, 90, 0]) {
          //nema17();
          translate([0, 0, -20])
               cylinder(40, 12, 12);
          m3_hole(1, 1);
          m3_hole(1, -1);
          m3_hole(-1, 1);
          m3_hole(-1, -1);
          
     }
     

}

module clamp_moving() {
     cube([100, 100, 10], center=true);
}

module clamp_fixed() {
     cube([100, 100, 10], center=true);
}

/*
translate([30, 0, length/2])
clamp_moving();
*/

/*
difference() {
translate([-42.2/2 - 5, 0, 42.2/2 + 5])
clamp_fixed();
 positionned_rod();
nema17_shape();

}*/

/*
translate([0, 0, -5])
rotate([0, 90, 0])
nema17_shape();
*/

module fixed() {

difference() {
translate([20, 0, 00]) {
     clamp_fixed();
     translate([40, 0, 10])
          cube([20, 100, 10], center=true);
     translate([-55, 0, 15])
     cube([10, 100, 40], center=true);
}
 translate([0, 0, -5])
          rotate([0, 90, 0]) 
          nema17_shape();
 }


rail(tolerance=0.0, length=140);

}


module moving() {

difference() {
     translate([20, 0, 100]) {
          clamp_moving();
          translate([40, 0, -10])
          cube([20, 100, 10], center=true);
     }
    // rail(tolerance=1.0, length=140);
     positionned_rod(clearance=0.0);
    

}

}

//moving();
//fixed();
//positionned_rod(clerance=0.0);

//nema17_shape(); 


module rail(tolerance=0.0, length) {
     triangle_points =[[-tolerance,-tolerance],[20+tolerance,-tolerance],[-tolerance,20+tolerance]];
     triangle_paths =[[0,1,2]];
 
     translate([-35 + tolerance/2, 0, 0])
          rotate([0, 0, 135 + 180])
          linear_extrude(height=length)
          polygon(triangle_points,triangle_paths,1);


      translate([-35, 0, length/2])
           cube([10, 20, length], center=true);

}


//rail();


positionned_rod(clearance=0.6, l=120);
