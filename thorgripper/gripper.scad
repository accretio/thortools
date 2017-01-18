BaseRadius=33;
BaseHeight=8;
HoleRadius=1.5;

use <nema17.scad>
include <nutsnbolts/cyl_head_bolt.scad>;

module base2() {
     module hole() {
          translate([18.5, 0, 0]) 
               cylinder(BaseHeight, HoleRadius, HoleRadius);
          
     }
     difference() {
          cylinder(BaseHeight, BaseRadius, BaseRadius);
          hole();
          rotate([0, 0, 120]) hole();
          rotate([0, 0, 240]) hole();
     }
   /*  translate([-35, 0, BaseHeight/2]) {
          cube([50, 50, BaseHeight], center=true);
     } */
}

module case() {
     translate([-15, 10, 0]) {
          cube([20, 10, 10]) ;
          cube([10, 10, 42.2]) ;
     }
     translate([-15, -20, 0]) {
          cube([20, 10, 10]) ;
          cube([10, 10, 42.2]) ;
     }
     
}

module gears() {
     translate([0, -20, 40]) {
          rotate([0, 90, 0]) {
               cylinder(4, 20, 20);
          }
     }
     translate([4, -20, 40]) {
          color("green") {
               rotate([0, 90, 0]) {
                    cylinder(4, 15, 15);
               }
          }
     }
     translate([0, 20, 40]) {
          rotate([0, 90, 0]) {
               cylinder(4, 20, 20);
          }
     }
      translate([4, 20, 40]) {
          color("green") {
               rotate([0, 90, 0]) {
                    cylinder(4, 5, 5);
               }
          }
     }
     translate([4, 0, 42.2/2]) {
          color("red") {
               rotate([0, 90, 0]) {
                    cylinder(4, 10, 10);
               }
          }
     }
     
}

module prism(l, w, h){
     polyhedron(
          points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
          faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
          );
}
 module holder() {
               translate([2.5+2, 20, 50]) {
                    cube([5, 20, 100], center=true) ;
               }
               translate([-2.5-2, 20, 50]) {
                    cube([5, 20, 100], center=true) ;
               }
               translate([-2, 20, 20]) {
                    rotate([0, 90, 0]) {
                         cylinder(4, 15, 15);
                         rotate([0, 0, 90]) {
                              translate([30, 0, 2]) {
                                   cube([60, 10, 4], center=true);
                              }
                         }
                    }
               }
               translate([-2, 20, 90]) {
                    rotate([0, 90, 0]) {
                         cylinder(4, 15, 15);
                          rotate([0, 0, 90]) {
                              translate([30, 0, 2]) {
                                   cube([60, 10, 4], center=true);
                              }
                         }
                    }
               }

               translate([4, 70, 60]) {
                    cube([4, 10, 100], center=true);
                    translate([0, 0, 47]) {
                         rotate([30, 0, 0 ]) {
                              translate([0, 0, 15]) {
                                   cube([4, 10, 30], center=true);
                              }
                         }
                    }
                    translate([-1, -15, 85]) {
                         cube([6, 10, 30], center=true);
                    }
               }

               
               translate([-4, 70, 60]) {
                    cube([4, 10, 100], center=true);
                    translate([0, 0, 47]) {
                         rotate([30, 0, 0 ]) {
                              translate([0, 0, 15]) {
                                   cube([4, 10, 30], center=true);
                              }
                         }
                    }
                    translate([1, -15, 85]) {
                         cube([6, 10, 30], center=true);
                    }
               }
          
     }


module cover() {
     difference() {
          color("pink") {
               cylinder(34+4, BaseRadius, BaseRadius);
          }          
          cylinder(34 + 5, 13, 13);
          // holes for the nema 17 cables
          translate([0, -5, 0]) cube([50, 10, 10]);
     } 
}



module stage1() { 
base();
translate([0, 0, BaseHeight]) {
     
     translate([0, 0, 34]) {
          rotate([0, 0, 00]) {
               nema17();
          }
     }
     
     cover();
     
}
 

}

module coverNut(pos) {
rotate([0, 0, 60 + 120* pos]) {
translate([28, 0, 62]) hole_through(name="M3", l=50, cl=0.1, h=10, hcl=0.4);
translate([28, 0, 5]) nutcatch_sidecut("M3", l=100, clk=0.1, clh=0.1, clsl=0.1);
}
}

/*

coverNut(0);
coverNut(1);
coverNut(2);

module holeMainNut(pos) {
     rotate([0, 0, 120* pos]) {
          translate([18.5, 0, 5]) nutcatch_sidecut("M3", l=100, clk=0.1, clh=0.1, clsl=0.1);
     }
}

holeMainNut(0);
holeMainNut(1);
holeMainNut(2);

difference() {
     stage1();
     
}
*/



/// new version of the gripper


GripperRadius=30;
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

     }
         
}


AttachmentHeight=10;
Arm6Radius=15;
Arm6EndHeight=10;

// screws to the ase
module attachment_hole(pos) {
     rotate([0, 0, 90 * pos]) {
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
          
          attachment_hole(0);
          attachment_hole(1);
          attachment_hole(3);

          locking_hole(0);
          locking_hole(1);
          locking_hole(2);
          
        
          
     }

     
}

//gripper();
//nema();


translate([0, 0, -AttachmentHeight]) {
attachment();
}
nema();
gripper();
