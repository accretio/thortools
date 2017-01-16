BaseRadius=33;
BaseHeight=8;
HoleRadius=1.5;

use <nema17.scad>

module base() {
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

base();

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



translate([0, 0, BaseHeight]) {
     // this is the wheel
     
     
     rotate([0, 0, 0]) holder();
     rotate([0, 0, 180]) holder();
     // this is the main screw

     // this is the nema 17
     translate([0, 0, 42.2/2 + 35]) {
          rotate([90, 0, 00]) {
              // nema17();
             /*  translate([20, 10, 0]) {
                    rotate([0, 0, 90]) {
                         color("blue") {
                              prism(10, 15, 15);
                         }
                    }
               }
               
               translate([20, -20, 0]) {
                    rotate([0, 0, 90]) {
                         color("blue") {
                              prism(10, 15, 15);
                         }
                    }
               }
               
               translate([-20, -10, 0]) {
                    rotate([0, 0, -90]) {
                         color("blue") {
                              prism(10, 15, 15);
                         }
                    }
               }
               
               translate([-20, 20, 0]) {
                    rotate([0, 0, -90]) {
                         color("blue") {
                              prism(10, 15, 15);
                         }
                    }
               }
               */
               
          }
     }

} 

