use<../rpi4_model/more/davex/raspberry-pi-4-model-b-openscad-model-w-io/90c673e1-6bf9-4234-935d-6cf6b8fdb27a.scad>
use<connectors.scad>
use<switches.scad>
use<power.scad>
use<passives.scad>
use<../shapes/compound.scad>
use<../shapes/extrusions.scad>
use<../fastening/spacers.scad>
use<../fastening/inserts.scad>

module drokUsbBuck(w=35,d=17,t=1.5,cut=false,pad=false){
  if(!cut && !pad){
    difference(){
      union(){
          color("MidnightBlue",0.8) cube([w,d,t]);
          translate([w-1.5,1.5,.75])
          color("Silver",0.9) cube([2.5,2.5,1.6],center=true);
          translate([w-1.5,d-1.5,.75])
          color("Silver",0.9) cube([2.5,2.5,1.6],center=true);
      }
      translate([w-1.5,1.5,-0.1])
      cylinder(2,r=0.45);
      translate([w-1.5,d-1.5,-0.1])
      cylinder(2,r=0.45);
    }
    translate([18,13,1.5])
    rotate([0,0,90])
    SmdElectCap(d=6.1,h=8);
    translate([18+8,13,1.5])
    rotate([0,0,90])
    SmdElectCap(d=6.1,h=8);
    translate([18,5,1.5])
    smdInductor(s=8, h=5);
    translate([23.5,4,1.5])
    smdSop(p=8);
    translate([9,17/2,1.5])
    UsbAFemalePcb();
}else if(cut){
  color("Pink",0.6) union(){
    //difference(){
      cube([w-.5,d,t+10]);
      translate([36,6,-5])
      cylinder(7,r=1.5);
      translate([w-1,2,1.5])
      cube([6,7,4]);
   //}
    translate([.1,d/2,3.1+2.25])
    rotate([0,-90,0])
    union(){
      linear_extrude(height=2.1)
      roundedRect(w=6.5,h=13.5);
      hull(){
        translate([0,0,2])
        linear_extrude(height=.1)
        roundedRect(w=6.5,h=13.5);
        translate([0,0,8])
        linear_extrude(height=.1)
        roundedRect(w=9.5,h=16.5);
      }
    }
    translate([1,1,-3])
    cube([33,15,3]);
  }
}else if(pad){
  color("Khaki",0.8) union(){
    translate([-2,3,-5])
    cube([41,5,10]);
    translate([-2,-1.5,-5])
    cube([5,20,10]);
    translate([25,-1.5,-5])
    cube([5,20,6]);
  }
}
}

module lm2596_adjV(cut=false,pad=false){
  if(!cut && !pad){
    difference() {
      union(){
        color("Blue",0.8) cube([44,22,1.5]);
        translate([44-1.5,1.5,.75])
        color("Silver",0.9) cube([2.5,2.5,1.6],center=true);
        translate([44-1.5,22-1.5,.75])
        color("Silver",0.9) cube([2.5,2.5,1.6],center=true);
        translate([1.5,22-1.5,.75])
        color("Silver",0.9) cube([2.5,2.5,1.6],center=true);
        translate([1.5,1.5,.75])
        color("Silver",0.9) cube([2.5,2.5,1.6],center=true);
      }
      translate([37,3,-0.1])
      cylinder(2,r=1.65);
      translate([7,19,-0.1])
      cylinder(2,r=1.65);
      translate([1.5,1.5,-0.1])
      cylinder(2,r=0.5);
      translate([44-1.5,22-1.5,-0.1])
      cylinder(2,r=0.5);
      translate([1.5,22-1.5,-0.1])
      cylinder(2,r=0.5);
      translate([44-1.5,1.5,-0.1])
      cylinder(2,r=0.5);
    }
    translate([4.5,10.5,1.5])
    SmdElectCap();
    translate([39.5,10.5,1.5])
    SmdElectCap();
    translate([28,8,1.5])
    smdInductor(s=11.5, h=7);
    translate([29,18,1.5])
    potentiometer();
    translate([15,15,1.5])
    lm2596smd();
}else if(cut){
  
    color("Pink",.6)
    union(){
        translate([-1,-1,-5])
        cube([46,23,20]);
        translate([37,3,-5])
        rotate([180,0,0])
        threadInsert(3);
        translate([7,19,-5])
        rotate([180,0,0])
        threadInsert(3);
    }
}else if(pad){
    color("DarkKhaki",0.8) union(){
      translate([37,3,-4.99-50])
      cylinder(50,20,4);
      translate([7,19,-4.99-50])
      cylinder(50,20,4);
    }
    }
}

module rpi4b(cut=false){
  if(!cut){
    board_raspberrypi_4_model_b();
  }else{
    //Rp4ShapedHole();
    color("Pink",0.5)
    union(){
      translate([-.4,-.4,-0.15])
      cube([56.8,85.8,1.8]);
      difference(){
        union(){
          translate([0,0,1.5])
          cube([56,85,20]);
          translate([0,0,-5])
          cube([56,85,5]);
        }
        translate([19,83.1,-6])
        cube([2,2,10]);
        translate([37,83.1,-6])
        cube([2,2,10]);
        translate([7,7,-6])
        rotate([0,0,180])
        roundedCorner(r=.625,s=10,h=6);
        translate([49,7,-6])
        mirror([0,1,0])
        roundedCorner(r=.625,s=10,h=6);
      }
      translate([3.5,3.5,0])
        rotate([180,0,0])
        threadInsert(height=6);
      translate([56-3.5,3.5,0])
        rotate([180,0,0])
        threadInsert(height=6);
      translate([47,88,9])
      rotate([-90,0,0])
      union(){
        taperedBox(w1=16,h1=17,w2=19,h2=24,z=6);
        translate([0,0,-1.5])
        cube([16,17,3],center=true);
      }
      translate([29,88,9])
      rotate([-90,0,0])
      union(){
        taperedBox(w1=16,h1=17,w2=19,h2=24,z=6);
        translate([0,0,-1.5])
        cube([16,17,3],center=true);
      }
      translate([10.25,88,8])
      rotate([-90,0,0])
      union(){
        taperedBox(w1=17,h1=14,w2=20,h2=24,z=6);
        translate([0,0,-1.5])
        cube([17,14,3],center=true);
      }
      translate([28,-1.5,-0.75])
      rotate([90,0,0])
      union(){
        taperedCapsule(r1=1.5,d1=12,r2=4,d2=18,z=6);
        translate([0,0,-1.5])
        capsule(r=1.5,d=12,z=1.6);
      }
      translate([56,53.5,4])
      rotate([0,90,0])
      cylinder(3,r=3.5,$fn=16);

      translate([56,11,3])
      rotate([90,0,90])
      hull(){
          translate([5.95/2,0,0])
          cylinder(3,r=3.75/2,$fn=10);
          translate([-5.95/2,0,0])
          cylinder(3,r=3.75/2,$fn=10);
      }
      translate([56,26,3])
      rotate([90,0,90])
      linear_extrude(height=3)
      offset(r=0.25)
      hdmiProfile("Micro");
      translate([56,39.5,3])
      rotate([90,0,90])
      linear_extrude(height=3)
      offset(r=0.25)
      hdmiProfile("Micro");
      translate([59,11,3])
      rotate([90,0,90])
      rpi4hdmiSideOutRelief();
  }
  }
  }

  module RpiX703ups(w=88,h=87,rd=3.5,cut=false,pad=false){

    if(!cut && !pad){
        color("Green",0.9)
        difference(){
            translate([rd-w/2,rd-h/2,0])
            minkowski(){
                cube([w-rd*2,h-rd*2,.75]);
                cylinder(.75,r=rd);
            }
            translate([w/2-3.5,h/2-3.5,-0.1])
            cylinder(3,r=1.6);
            translate([w/2-3.5-58,h/2-3.5,-0.1])
            cylinder(3,r=1.6);
            translate([w/2-3.5,h/2-3.5-49,-0.1])
            cylinder(3,r=1.6);
            translate([w/2-3.5-58,h/2-3.5-49,-0.1])
            cylinder(3,r=1.6);
            translate([w/2-3.5,-h/2+3.5,-0.1])
            cylinder(3,r=1.6);
            translate([w/2-3.5-58,-h/2+3.5,-0.1])
            cylinder(3,r=1.6);
            translate([-w/2,-h/2+55.3,-0.01])
            cube([6.0,9.34,2]);
        }
        color("Silver",0.9){
        translate([w/2-3.5,h/2-3.5,4])
        ring(3,1.5,5);
        translate([w/2-3.5-58,h/2-3.5,4])
        ring(3,1.5,5);
        translate([w/2-3.5,h/2-3.5-49,4])
        ring(3,1.5,5);
        translate([w/2-3.5-58,h/2-3.5-49,4])
        ring(3,1.5,5);
        }
        translate([w/2-11.5,-h/2+4,1.5])
        smallMomentarySwitch();
        translate([w/2-22,-h/2+5,1.5])
        rotate([0,0,-90])
        JST2mm2pin();
        translate([-w/2+6.5,-h/2+4,1.5])
        JST2_5mm2pin();
        translate([-w/2+17.5,-h/2+4,1.5])
        JST2_5mm2pin();
        translate([-w/2+32,-h/2+3.5,1.5])
        rotate([0,0,90])
        hPinRow(2,"Black");
        translate([-w/2+32+2.5,-h/2+3.5,1.5])
        rotate([0,0,90])
        hPinRow(2,"Black");
        translate([w/2-5,-h/2+9.5,1.5])
        18640batHolder();
        translate([-w/2-1,-h/2+60,1.8])
        rotate([-90,0,90])
        usbCfemaleSocket();
        // translate([w/2,h/2-3.5*2-49,6.5])
        // rotate([0,0,90])
        // rpi4b();
    }else if(pad){
      translate([w/2-3.5,h/2-3.5,-4.9-100])
      cylinder(100,20,4);
      translate([-w/2+3.5,h/2-3.5,-4.9-100])
      cylinder(100,20,4);
      translate([w/2-3.5,h/2-3.5-58,-4.9-100])
      cylinder(100,20,4);
      translate([-w/2+3.5,h/2-3.5-58,-4.9-100])
      cylinder(100,20,4);
    }else{
      union(){
        translate([0.25,0,10])
        color("Pink",0.4) cube([h+1,w+1,30],center=true);
        translate([-h/2-1,-w/2+60,1.8])
        rotate([-90,0,90])
        usbCfemaleSocket(true);
      }
        translate([h/2-3.5,w/2-3.5,-8.5])
        color("Pink",0.4) union(){cylinder(4,r=1.5);translate([0,0,-3.5]) cylinder(4,r=3.5);}
        translate([h/2-3.5,-w/2+3.5,-8.5])
        color("Pink",0.4) cylinder(4,r=1.5);
        translate([h/2-3.5-58,w/2-3.5,-8.5])
        color("Pink",0.4) cylinder(4,r=1.5);
        translate([h/2-3.5-58,-w/2+3.5,-8.5])
        color("Pink",0.4) cylinder(4,r=1.5);

        translate([h/2-3.5,w/2-3.5,-12])
        color("Pink",0.4) cylinder(4,r=3.5);
        translate([h/2-3.5,-w/2+3.5,-12])
        color("Pink",0.4) cylinder(4,r=3.5);
        translate([h/2-3.5-58,w/2-3.5,-12])
        color("Pink",0.4) cylinder(4,r=3.5);
        translate([h/2-3.5-58,-w/2+3.5,-12])
        color("Pink",0.4) cylinder(4,r=3.5);
    }  
     
}

module RPiRJ45BreakoutBoard(cut=false){
    
    if(!cut){
      board(mid=true);
      translate([3.5,2.5,0])
      rotate([180,0,0])
      header();
      translate([8.5,48,2])
      hPinRow(16,"Black");
      translate([8.5,48-2.5,2])
      hPinRow(16,"Yellow");
      translate([8.5,48-5,2])
      hPinRow(16,"Red");
      translate([66-8.5,54-5,2])
      rotate([0,0,180])
      screwBlockLine();
      translate([1.5,26,2])
      etherline();
      translate([1.5,20,2])
      mirror([0,1,0])
      etherline();
    }else{
      rd = 3.5;
      w = 66;
      color("Pink",0.5){
        translate([0,0,0])
        union(){
          translate([66/2-3.5,56/2-3.5,0])
          linear_extrude(height=1.5)
          offset(r=0.5)
          roundedRect(3.5,66,56);
          difference(){
            translate([-2.5,-2.5,1.5])
            cube([64,54,5]); //main cube
            translate([64/2-2.5,54/2-2.5,3.6])
            ring(50,39,6);
          }
          translate([1.5,-10,0])
          cube([56,14.5,13.5]); //gpio pin block
        }
        // translate([0,0,0])
        // cylinder(30,r=1.25,$fn=10,center=true);
        // translate([0,49,0])
        // cylinder(30,r=1.25,$fn=10,center=true);
        // translate([59,49,0])
        // cylinder(30,r=1.25,$fn=10,center=true);
        // translate([w-rd*2,0,0])
        // cylinder(30,r=1.25,$fn=10,center=true);
        // middle holes
        translate([0.5,23,0])
        cylinder(30,r=1.35,$fn=10,center=true);
        translate([w-rd*2,23,0])
        cylinder(30,r=1.35,$fn=10,center=true);
        translate([57/2+1.15,23,5.6+4.9+1.75]) // ethernet blocks
        difference(){
          cube([57,37,11.7],center=true); 
          cube([59,4,12],center=true); 
        }
        translate([1.2,4.5,5.6+4.9+2+5.5])
        hull(){
          cube([57,16.5,0.1]);
          translate([-3,-3,6])
          cube([63,22.5,0.1]);
        }
        translate([1.2,25,5.6+4.9+2+5.5])
        hull(){
          cube([57,16.5,0.1]);
          translate([-3,-3,6])
          cube([63,22.5,0.1]);
        }
        translate([47,40,2])
        cube([11,15,11]); //aux power block
        translate([5,40,2])
        cube([42.5,11.5,13]); //power selection block
        translate([-2.5,-2.5,-5])
        cube([64,54,5]);
        translate([2.5,-8,-20])
        cube([54,12,20]); //bottom header
      }
    }
}