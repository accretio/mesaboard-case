include  <case2_7176.scad>
use  <PCB_din_clip.scad>

case_with_screws();
translate([BOARD_LENGTH/2-3.8,0, BOARD_HEIGHT+10]){
     rotate([0,270,0]){
	  
	  allClips();
     }
}

translate([-BOARD_LENGTH/2+3.8,0, BOARD_HEIGHT+10]){
     rotate([0,270,0]){
	  
	  allClips();
     }
}
