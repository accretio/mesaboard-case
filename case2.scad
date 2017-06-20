include <cyl_head_bolt.scad>

BOARD_LENGTH=165.1;
BOARD_WIDTH=101.6;
BOARD_TOLERANCE=2;
BOARD_HEIGHT=35;
CASE_THICKNESS=5;
SUPPORT_RADIUS=4;
BOARD_RECESS=2;
SUPPORT_X=78.74;
SUPPORT_Y=46.99;
HOLE_RADIUS=10;
SOCKET_WIDTH=56;
SOCKET_HEIGHT=19;
PADDING=5;
FAN_RADIUS=16;
DEPTH_OF_FAN_BOLTS=7;


module position_in_front_of_the_board_holes(){
     for(x = [-1:2:1]){
	  for(y = [-1:2:1]){
	       translate([x *SUPPORT_X,SUPPORT_Y*y,0]){
		    children();
		    
	       }
	  }
     }
}

module position_in_front_of_the_fan_holes(){
     for(x = [-1:2:1]){
	  for(y = [-1:2:1]){
	       translate([x *FAN_RADIUS,FAN_RADIUS*y,0]){
		    children();
		    
	       }
	  }
     }
}

module board(padding = 0){
     translate([0,0,BOARD_HEIGHT/2]){
	  cube([BOARD_LENGTH+BOARD_TOLERANCE*2+padding*2, BOARD_WIDTH+BOARD_TOLERANCE*2+padding*2,BOARD_HEIGHT], center=true);
     }

}

module case(){
     difference(){
	  board(CASE_THICKNESS);
	  
	  translate([0,0,CASE_THICKNESS]){
	       board();
	  }
	  socket();
	  wire_hole();
	  fan_hole();
	  position_in_front_of_the_fan_holes(){
	       fan_screw_hole ();
	  }
     }
     position_in_front_of_the_board_holes(){
	  support();
     }
    

}
module support(){
cylinder(BOARD_HEIGHT-BOARD_RECESS, SUPPORT_RADIUS,SUPPORT_RADIUS, $fn=50);
}

module screw(){
     translate([0, 0, -2]){
	  rotate([180, 0, 0]){
	       hole_through(name="M3", l=50+5, cl=0.1, h=10, hcl=0.4);
	  }
     }
}
module case_with_screws(){
     difference(){
	  case();
	  position_in_front_of_the_board_holes(){
	       screw();
	  }
     }
}
module socket(){
     translate([BOARD_LENGTH/2,0,SOCKET_HEIGHT/2+BOARD_HEIGHT-SOCKET_HEIGHT]){
	  cube([15, SOCKET_WIDTH, SOCKET_HEIGHT], center=true);	  
     } 
}

module wire_hole(){
     
    translate([-BOARD_LENGTH/3, 0, 0])
	  rotate([0,0,0]){
	       cylinder(15, HOLE_RADIUS, HOLE_RADIUS, $fn=50, center=true);
	  }
     
}

module fan_hole(){
      cylinder(15, FAN_RADIUS, FAN_RADIUS, $fn=200, center=true);
}

module fan_screw_hole(){
     translate([0, 0, CASE_THICKNESS+1]){
	  nutcatch_parallel("M3", l=3);
     }
     translate([0,0,-30]){
     	  rotate([180,0,0]){
	       
	       hole_through(name="M3", l=50+5, cl=0.1, h=10, hcl=0.4);
	  }
     }
}

case_with_screws();

