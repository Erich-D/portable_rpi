use<../shapes/extrusions.scad>
use<connectors.scad>
use<../shapes/compound.scad>

module hdmiToMicroAdapter(cut=false){
if(!cut){
  color("Silver"){
    difference(){
      linear_extrude(height=7)
      microUsbProfile(6,2.5);
      translate([0,0,-.1])
      linear_extrude(height=6)
      offset(r=-.2)
      microUsbProfile(6,2.5);
    }
  }
  color("Black",.8)
  difference(){
    translate([0,0,0])
    linear_extrude(height=6)
    offset(r=-.2)
    microUsbProfile(6,2.5);
    translate([0,.25,3])
    cube([4,.5,10],center=true);
  }
  for(i=[0:1:18]){
    translate([-1.9+.05+i*.2,-.19,0])
    color("Gold") cube([.1,.2,5]);
  }
  difference(){
    hdmiBody();
    translate([0,0,27])
    color("Black")
    linear_extrude(height=12)
    hdmiProfile();
  }
  translate([0,0,24.5])
  hdmiFemaleEnd();
}else{
  color("Pink",0.4){
    translate([0,0,0])
    scale([1.01,1.01,1.02])
    hdmiBody();
    hull(){
        translate([0,0,35.6])
        linear_extrude(height=0.1)
        roundedRect();
        translate([0,0,35.7+8])
        linear_extrude(height=0.1)
        roundedRect(1,20+8,11+4);
    }
  }
}
}


module rpiAudioExt(cut=false){
    if(!cut){
        difference(){
            union(){
                color("DarkSlateGray",0.9) cylinder(8,r=4.9/2,$fn=30);
                translate([0,0,8])
                color("DarkSlateGray",0.9) cylinder(1.5,4.9/2,7/2,$fn=30);
                translate([0,0,8+1.5])
                color("DarkSlateGray",0.9) cylinder(20,r=7/2,$fn=30);
                translate([0,0,8+1.5+20])
                color("Gold",0.9) cylinder(2,r=6/2,$fn=30);

                translate([0,0,-0.25])
                color("Gold",0.9) cylinder(0.5,r=4.2/2,$fn=30);
                translate([0,0,-3])
                color("Gold",0.9) cylinder(3,r=3.4/2,$fn=30);
                translate([0,0,-3-0.5])
                color("Black",0.9) cylinder(0.5,r=3.3/2,$fn=30);
                translate([0,0,-3-0.5-3])
                color("Gold",0.9) cylinder(3,r=3.4/2,$fn=30);
                translate([0,0,-3-0.5-3-0.5])
                color("Black",0.9) cylinder(0.5,r=3.3/2,$fn=30);
                translate([0,0,-3-0.5-3-0.5-3])
                color("Gold",0.9) cylinder(3,r=3.4/2,$fn=30);
                translate([0,0,-3-0.5-3-0.5-3-0.5])
                color("Black",0.9) cylinder(0.5,r=3.3/2,$fn=30);
                translate([0,0,-3-0.5-3-0.5-3-0.5-0.3])
                color("Gold",0.9) cylinder(0.3,r=3.4/2,$fn=30);
                translate([0,0,-3-0.5-3-0.5-3-0.5-0.3-3])
                color("Gold",0.9) cylinder(3,3.4/2,2.5/2,$fn=30);
                translate([0,0,-3-0.5-3-0.5-3-0.5-0.3-3-2])
                color("Gold",0.9) cylinder(2,0.65,3.4/2,$fn=30);
            }
            translate([0,0,8+1.5+1])
            color("Black",0.6) cylinder(23,r=3.4/2,$fn=30);
        }
    }else{
        color("Pink",0.6)
        union(){
            cylinder(29.5,r=7.5/2);
            translate([0,0,29.4])
            cylinder(2.1,r=6.5/2);
            translate([0,0,29.5+1.99])
            cylinder(6,6.5/2,8);
        }
    }
}