use<../shapes/extrusions.scad>
use<../fastening/spacers.scad>

module sshd(cut=false,pad=false){
x = 68;
y = 100;    
if(!cut && !pad){
    difference(){
        color("Black",0.9) linear_extrude(height=7)
        roundedRect(r=2.5,w=x,h=y);
        translate([-x/2+3,y/2-13.5,-0.01])
        cylinder(5,r=4.5/2);
        translate([x/2-3,y/2-13.5,-0.01])
        cylinder(5,r=4.5/2);

        translate([-x/2+3,-y/2+9.5,-0.01])
        cylinder(5,r=4.5/2);
        translate([x/2-3,-y/2+9.5,-0.01])
        cylinder(5,r=4.5/2);

        translate([-x/2+4.99,y/2-13.5,3.5])
        rotate([0,-90,0])
        cylinder(5,r=4.5/2);
        translate([x/2-4.99,y/2-13.5,3.5])
        rotate([0,90,0])
        cylinder(5,r=4.5/2);

        translate([-x/2+4.99,-y/2+9.5,3.5])
        rotate([0,-90,0])
        cylinder(5,r=4.5/2);
        translate([x/2-4.99,-y/2+9.5,3.5])
        rotate([0,90,0])
        cylinder(5,r=4.5/2);

        translate([-x/2+16,y/2-6.99,-0.01])
        union(){
            cube([47,7,3]);
            translate([2,0,2.99])
            cube([43,7,3]);
        }
    }

    translate([-x/2+3,y/2-13.5,1])
    color("Gold") ring(4.5/2,1.5,2);
    translate([x/2-3,y/2-13.5,1])
    color("Gold") ring(4.5/2,1.5,2);
    translate([-x/2+3,-y/2+9.5,1])
    color("Gold") ring(4.5/2,1.5,2);
    translate([x/2-3,-y/2+9.5,1])
    color("Gold") ring(4.5/2,1.5,2);
    translate([-x/2+1,y/2-13.5,3.5])
    rotate([0,-90,0])
    color("Gold") ring(4.5/2,1.5,2);
    translate([x/2-1,y/2-13.5,3.5])
    rotate([0,90,0])
    color("Gold") ring(4.5/2,1.5,2);
    translate([-x/2+1,-y/2+9.5,3.5])
    rotate([0,-90,0])
    color("Gold") ring(4.5/2,1.5,2);
    translate([x/2-1,-y/2+9.5,3.5])
    rotate([0,90,0])
    color("Gold") ring(4.5/2,1.5,2);

    translate([0,0,0])
    color("DarkCyan",0.8) linear_extrude(height=7)
    roundedRect(r=2.5,w=48,h=80);

    translate([-x/2+16,y/2-6.99,-0.01])
    union(){
        difference(){
            color("DimGray",0.9) union(){
                    cube([47,7,3]);
                    translate([2,0,2.99])
                    cube([43,7,3]);
                }
            translate([5,1.01,3])
            color("Gray") cube([37,6,1.5]);
            translate([2.5,1.01,.5])
            difference(){
                translate([0,0,0])
                color("Gray") cube([42,6,2.5]);
                translate([4.5,-0.5,-0.25])
                color("Gray") cube([33,7,3]);
            }
            translate([21,1.01,-0.5])
            color("Gray") cube([22,6,2.5]);
            translate([5,1.01,-0.5])
            color("Gray") cube([11,6,2.5]);
            translate([17,1.01,-0.5])
            color("Gray") cube([3,6,4]);
            translate([15.5,1.01,-0.5])
            color("Gray") cube([6,6,1]);
            }
        for(i=[0:1:6]){
            l = i%3 == 0 ? 6:5.5;
            translate([7.25+i*1.25,0.5,1.9])
            color("Gold") cube([1,l,.5]);
        }
        for(i=[0:1:14]){
            l = i<2 ? 5.5:i<7 ? 6:i<9 ? 5.5:i<10 ? 6:i<11 ? 5.5:i<13 ? 6:5.5;
            translate([21.25+i*1.25,0.5,1.9])
            color("Gold") cube([1,l,.5]);
        }
    }
}else if(pad){
    union(){
        translate([-x/2+3,y/2-13.5,-6-y])
        cylinder(y,20,4);
        translate([x/2-3,y/2-13.5,-6-y])
        cylinder(y,20,4);
        translate([-x/2+3,-y/2+9.5,-6-y])
        cylinder(y,20,4);
        translate([x/2-3,-y/2+9.5,-6-y])
        cylinder(y,20,4);
    }
}else{
    color("Pink",0.6){
        translate([0,1,-6])
        linear_extrude(height=15)
        roundedRect(r=2.5,w=x+.8,h=y+2);
        translate([-x/2+3,y/2-13.5,-16])
        union(){
            cylinder(10,r=1.5);
            cylinder(5,r=3.5);
        }
        translate([x/2-3,y/2-13.5,-16])
        union(){
            cylinder(10,r=1.5);
            cylinder(5,r=3.5);
        }
        translate([-x/2+3,-y/2+9.5,-16])
        union(){
            cylinder(10,r=1.5);
            cylinder(5,r=3.5);
        }
        translate([x/2-3,-y/2+9.5,-16])
        union(){
            cylinder(10,r=1.5);
            cylinder(5,r=3.5);
        }
        translate([0,y/2+(17+6)/2,-0.5])
        hull(){
            linear_extrude(height=8)
            roundedRect(r=2.5,w=x+.8,h=17+6);
            translate([0,(17+6)/2+13,4])
            rotate([90,0,0])
            scale([1,1,1])
            cylinder(1,r=5.5);
        }
    }
    }
}