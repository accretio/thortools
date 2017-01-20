BaseRadius=50;
BaseHeight=8;
HoleRadius=1.5;

use <nema17.scad>
include <nutsnbolts/cyl_head_bolt.scad>;
include <polyScrewThread_r1.scad>

use <parametric_involute_gear_v5.0.scad>
use <spur_generator.scad>

use <../../Thingiverse-Projects/Threaded Library/Thread_Library.scad>
use <MCAD/involute_gears.scad>


/// new version of the gripper


GripperRadius=38;
NemaHeight=34;
NemaCoverHeight=4;
NemaHoleRadius=13;
NemaCableHoleWidth=15;

module nema() {
     translate([0, 0, NemaHeight]) {
          nema17();
     }
}

module gripper() {
     module m3_hole(x, y) {
          color("red") {
               translate([x*31/2, y*31/2, NemaHeight + NemaCoverHeight]) hole_through(name="M3", l=10, cl=0.1, h=2, hcl=0.4);
          }
     }
     difference() {
          cylinder(NemaHeight + NemaCoverHeight, GripperRadius, GripperRadius);
          // the hole for the axe
          cylinder(NemaHeight + NemaCoverHeight + 1, NemaHoleRadius, NemaHoleRadius);
          // the m3 holes
          m3_hole(-1, -1);
          m3_hole(-1, 1);
          m3_hole(1, -1);
          m3_hole(1, 1);
          // the space for the nema
          nema();
          // the space for the cable
          rotate([0, 0, 180]) {
               translate([0, -NemaCableHoleWidth/2, 0]) {
                    cube([50, NemaCableHoleWidth, 10]);
               }
          }
          // the holes for the attachment
          attachment_hole(0);
          attachment_hole(1);
          attachment_hole(3);

          // the holes for the arm
          translate([0, 0, -AttachmentHeight]) {
               arm_hole(0);
               arm_hole(1);
          }
        
     }

     translate([0, 0, NemaHeight + 10]) {
          arm_regular(0, true);
          arm_regular(1, true);
     } 
     
}


AttachmentHeight=20;
Arm6Radius=15.1;
Arm6EndHeight=10;
ArmTolerance=0.4; 
ArmLength2=40;
// screws to the ase
module attachment_hole(pos) {
     rotate([0, 0, pos]) {
          translate([0.8 * GripperRadius , 0, 0]) {
               color("blue") {
                    rotate([180, 0, 0]) {
                         hole_through(name="M3", l=50, cl=0.1, h=5, hcl=0.4);
                    }
                    
                    translate([0, 0, 30]) {
                         nutcatch_sidecut("M3", l=100, clk=0.1, clh=0.1, clsl=0.1);
                    }
               }
          }
     }
}

module attachment() {

     
     module locking_hole(pos) {
          rotate([0, 0, 30 + pos * 120]) {
               translate([0, 0, 5]) {
                    translate([0, -GripperRadius, 0]) {
                         rotate([90, 0, 0]) {
                              hole_through(name="M3", l=30, cl=0.1, h=4, hcl=0.4);
                         }
                    }
               }
          }
     }
     
     difference() {
          cylinder(AttachmentHeight, GripperRadius, GripperRadius);
          cylinder(Arm6EndHeight, Arm6Radius, Arm6Radius);

          //  some locking stuff 
          attachment_hole(30);
          attachment_hole(-30);


          attachment_hole(150);
          attachment_hole(-150);

          
        
          locking_hole(0);
          locking_hole(1);
          locking_hole(2);


          // the holes for the bearings (3x10x4) 

          arm_hole(0);
          arm_hole(1);

               
     }

     
     arm_regular(0);
     arm_regular(1);

    

   
}

module arm_regular(pos, hasTeeths = false) {
     rotate([0, 0, 90 + pos * 180]) {
          translate([ GripperRadius - 7, 0, 10 ]) {
               rotate([0, 0, 0]) {
                    arm(0.0, hasTeeths) ;
               }
          }
     }
}

module arm_hole(pos) {
     rotate([0, 0, 90 + pos * 180]) {
          translate([ GripperRadius - 7, 0, 10 ]) {
               rotate([0, -90, 0]) {
                    // arm(ArmTolerance) ;
                    color("pink") {
                         arm_shape(ArmTolerance) ;
                    }
               }
               translate([0, 30 - pos * 60, 0]) {
                    rotate([90, 0, 180 + pos * 180]) {
                         hole_through(name="M3", l=38, cl=0.1, h=10, hcl=0.4);
                    }
               }
          }
     }
}

ArmDepth=4; 
ArmWidth=10;
ArmLength=50;
BearingDiameter=10; // 623ZZ bearings

module arm(tolerance, hasTeeths = false) {

     module simpleJoint() {
          rotate([90, 0, 0]) {
               difference() {
                    cylinder(ArmDepth + tolerance, 3/4 * ArmWidth + tolerance, 3/4 * ArmWidth + tolerance, center=true);
                    cylinder(ArmDepth + tolerance, BearingDiameter/2 + tolerance, BearingDiameter/2 + tolerance, center=true);
               }
          }
     }
    

     

     
     translate([ArmLength/2 + ArmWidth/2, 0, 0]) {
          cube([ArmLength, ArmDepth + tolerance , ArmWidth + tolerance], center=true);
     }
     if (hasTeeths) {
         
     } else {
          simpleJoint();
     }
     translate([ArmLength + ArmWidth, 0, 0]) {
          simpleJoint();
     }
     
}

module arm_shape(tolerance) {
     translate([ArmLength/2 + 3/4*ArmWidth - 2*tolerance , 0, 0]) {
          cube([ArmLength + 4*( 3/4 * ArmWidth + tolerance), ArmDepth + tolerance, 2* (3/4 * ArmWidth + tolerance)], center=true);
     } 
}

//arm();

nema();


translate([0, 0, -AttachmentHeight]) {
     attachment();
  }


nema();


//gripper();



///

numberTeeth=25;
pitchRadius=20;
thickness=4;


length=40;
radius=10;
pitch=2*3.1415*pitchRadius/numberTeeth;

angle=-360*$t;
offset=4;


distance=radius+pitchRadius+0.0*pitch;

module arm_gear(rotation) {
     translate([-thickness/2,-distance,0])
          rotate([0,90,0])
          rotate([0,0,offset-(angle + rotation)/numberTeeth ])
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

tol = 0.2;

module driver() {
     translate([3 - tol, 0, length/2]) {
          cube([2, 5, length], center=true);
     };
     
     difference() {
          rotate([0,0,180+angle])
               trapezoidThread( 
                    length=length, 			// axial length of the threaded rod
                    pitch=pitch,				 // axial distance from crest to crest
                    pitchRadius=radius, 		// radial distance from center to mid-profile
                    threadHeightToPitch=0.5, 	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
                    profileRatio=0.5,			 // ratio between the lengths of the raised part of the profile and the pitch
                    // std value for Acme or metric lead screw is 0.5
                    threadAngle=20, 			// angle between the two faces of the thread
                    // std value for Acme is 29 or for metric lead screw is 30
                    RH=true, 				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
                    clearance=0.2, 			// radial clearance, normalized to thread height
                    backlash=0.06, 			// axial clearance, normalized to pitch
                    stepsPerTurn=24 			// number of slices to create per turn
                    );
          
          cylinder(length, 5/2 + tol , 5/2 + tol, $fn=10);
          
     }
     

}



// this are the gears 
translate([0, 0, NemaHeight + DriverPadding ]) {
     driver();    
}



module arm_with_driver(rotation) {

rotate([0, 0, rotation]) {
     difference() {
          arm_gear(rotation);
          translate([0, -distance, 0]) {
               rotate([0, 90, 0]) {
                    cylinder(ArmDepth, BearingDiameter/2 , BearingDiameter/2, center=true);
               }
          }
     }
     translate([0, -distance, 0]) {
          rotate([0, 0, -90]) {
               arm(0.0, true);
          }
     }
     }
}

DriverPadding = 4;
translate([0, 0, length/2 + NemaHeight + DriverPadding]) {
     arm_with_driver(0);
}

     translate([0, 0, length/2 + NemaHeight + DriverPadding]) {
          arm_with_driver(180);
     }



