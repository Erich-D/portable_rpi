use<../fastening/inserts.scad>
use<../fastening/spacers.scad>
use<../shapes/extrusions.scad>
use<../components/connectors.scad>
use<../components/switches.scad>

module 7DP_CAPLCD(cut=false,mountPlate=false){
  rotate([0,0,180])
  if(!cut){
    translate([0,0,-.75-2-3-1])
    union(){
      difference(){
        color("SteelBlue") cube([171,100,1.5],center=true);
        color("SteelBlue") translate([60.6,0,0]) cube([50,43,2],center=true);
      }
      translate([0,0,1.76])
      difference(){
        color("Black") cube([171,100,2],center=true);
        translate([-8,0,0])
        color("Black") cube([87,101,3],center=true);
        translate([59.6,0,0])
        color("Black") cube([52,43,3],center=true);
      }
      translate([0,0,1.5+.75+2])
      color("Silver") cube([171,100,3],center=true);
      translate([0,0,.5+.75+2+3])
      color("Black") cube([171,100,1],center=true);
      translate([3,-4,.5+.75+2+3])
      color("DarkSlateGray") cube([155,86,1],center=true);
      translate([-156/2,89/2,-2.75]) color("Silver") ring(6,3,4);
      translate([-156/2,-89/2,-2.75]) color("Silver") ring(6,3,4);
      translate([156/2,89/2,-2.75]) color("Silver") ring(6,3,4);
      translate([+156/2,-89/2,-2.75]) color("Silver") ring(6,3,4);
      translate([36,-6,-.7])
      rotate([0,180,90])
      hdmiPcbFemaleSocket();
      translate([36,12,-.7])
      rotate([0,180,90])
      microUSBpcbFemaleSocket();
      translate([-171/2+11.5,9.5,-2.5])
      rotate([0,180,90])
      smallSTDPswitch();
      if(mountPlate){translate([0,0,-5.5]) screenMount();}
    }
  }else{
    union(){
      color("Pink",0.7) translate([0,0,-6]) cube([180,110,12],center=true);
      color("Pink",0.7) translate([0,0,-15.99]) cube([182,125,8],center=true);
      color("Pink",0.7) translate([-70,59,-12]) threadInsert();
      color("Pink",0.7) translate([-70,-59,-12]) threadInsert();
      color("Pink",0.7) translate([70,-59,-12]) threadInsert();
      color("Pink",0.7) translate([70,59,-12]) threadInsert();
      translate([-156/2+3,87/2-4,3])
      color("SaddleBrown",0.7) screenCut(156,87);
    }
  }
}

module screenCut(sw=155,sh=86,tbs=2.5){
    rotate([0,0,90])
    insideThumb();
    translate([sw,0,0])
    insideThumb();
    translate([0,-sh,0])
    rotate([0,0,180])
    insideThumb();
    translate([sw,-sh,0])
    rotate([0,0,-90])
    insideThumb();

    ins = 10-tbs*2.5;
    sl = sh-ins*2;
    translate([0,-ins,0])
    sideThumb(sl);
    translate([sw,-sl-ins,0])
    rotate([0,0,180])
    sideThumb(sl);
    translate([ins,-sh,0])
    rotate([0,0,90])
    sideThumb(sw-ins*2);
    translate([sw-ins,0,0])
    rotate([0,0,-90])
    sideThumb(sw-ins*2);

    translate([ins,-sh+ins,-8+tbs])
    cube([sw-ins*2,sh-ins*2,8]);
}

module screenMount(){
    translate([0,0,-1.5])
    difference(){
        cube([181,124,3],center=true);
        cube([146,79,4],center=true);
        translate([-156/2,89/2,0]) cylinder(4,r=1.65,$fn=15,center=true);
        translate([-156/2,-89/2,0]) cylinder(4,r=1.65,$fn=15,center=true);
        translate([156/2,89/2,0]) cylinder(4,r=1.65,$fn=15,center=true);
        translate([+156/2,-89/2,0]) cylinder(4,r=1.65,$fn=15,center=true);
        translate([-70,59,0]) cylinder(4,r=1.65,$fn=15,center=true);
        translate([-70,-59,0]) cylinder(4,r=1.65,$fn=15,center=true);
        translate([70,-59,0]) cylinder(4,r=1.65,$fn=15,center=true);
        translate([70,59,0]) cylinder(4,r=1.65,$fn=15,center=true);
    }
}