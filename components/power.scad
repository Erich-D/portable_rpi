use<../shapes/compound.scad>
use<../shapes/extrusions.scad>

module 18640batHolder(){
    difference(){
        translate([0,0,15])
        rotate([0,180,0])
        color("Black",0.9)
        intersection(){
            cube([76,21,15]);
            translate([0,10.5,0])
            hull(){
                taperedCylinder(h1=6,h2=9,r1=7.5,r2=10.5);
                translate([76,0,0])
                taperedCylinder(h1=6,h2=9,r1=7.5,r2=10.5);
            }
        }
        translate([-3.5,10.5,9.25])
        rotate([0,-90,0])
        color("Black",0.8) cylinder(r=9.75, h=69);
        translate([-12.5,-1,7.5])
        color("Black",0.8) cube([9,25,10]);
        translate([-38-13.5,-1,7.5])
        color("Black",0.8) cube([27,25,10]);
        translate([-76+3.5,-1,7.5])
        color("Black",0.8) cube([9,25,10]);
        translate([-4.05,10.5-3.5,.5])
        color("Black",0.8)cube([1.5,7,19]);
        translate([-2.99,10.5-2,-.5])
        color("Black",0.8)cube([3,4,19]);
        translate([-73.05,10.5-3.5,.5])
        color("Black",0.8)cube([1.5,7,19]);
        translate([-76.01,10.5-2,-.5])
        color("Black",0.8)cube([3,4,19]);
        
    }
    translate([-2.5,10.5,0])
    batteryClip();
    translate([-73.5,10.5,0])
    rotate([0,0,180])
    batteryClip();
}

module SmdElectCap(d=7.8,h=11.5){
    ri = (d+.2)/2;
    c = ri*(2*tan(180/8));
    rc = c/(2*sin(180/8));
    difference(){
        union(){
            color("Black",0.8) rotate([0,0,360/8/2]) cylinder(2,r=rc,$fn=8);
            translate([-ri,-ri,0]) color("Black",0.8) cube([ri*2,ri,2]);
        }
        translate([-ri-1,-c/2,1])
        color("Black",0.8) cube([ri*2+2,ri+2,2]);
        translate([-1.75,-c-ri/2-1,1])
        color("Black",0.8) cube([3.5,ri+2,2]);
    }
    translate([0,ri-1.2,0])
    rotate([90,0,90])
    color("Silver",0.8) elbow(t=0.2,h=3,f=1.65,w=0.53);
    translate([0,-ri+1.2,0])
    rotate([90,0,-90])
    color("Silver",0.8) elbow(t=0.2,h=3,f=1.65,w=0.53);
    color("Silver",0.8) hull(){
        rotate_extrude()
        translate([d/2-0.5,1.5,0])
        circle(0.5);
        translate([0,0,3])
        cylinder(0.1,r=d/2-0.75);
    }
    color("Silver",0.8) hull(){
        rotate_extrude()
        translate([d/2-0.5,3.5,0])
        circle(0.5);
        rotate_extrude()
        translate([d/2-0.5,h-0.5,0])
        circle(0.5);
    }
}

module smdInductor(s=11.5, h=7){
    difference(){
        color("Black",0.8) linear_extrude(height=h)
        roundedRect(r=1.2,w=s,h=s);
        color("DarkSlateGray",0.8) rotate_extrude()
        translate([s/2-0.75,h,0])
        circle(0.5);
        color("DarkSlateGray",0.8) cube([5,s+2,1.8],center=true);
    }
    translate([0,s/2-.5,0])
    rotate([90,0,90])
    color("Silver",0.8) elbow(t=0.2,h=3,f=.65,w=4);
    translate([0,-s/2+.5,0])
    rotate([90,0,-90])
    color("Silver",0.8) elbow(t=0.2,h=3,f=.65,w=4);
}

module lm2596smd(){

    translate([0,0,4.5/2])
    color("Black",0.7) cube([10,8,4.5],center=true);
    translate([-9/2,8/2-.5,0])
    color("Silver",0.7) cube([9,2,0.5]);
    for(i=[0:1:4]){
        translate([-2.0*2+i*2.0,-8,0])
        color("Silver",0.7) step();
    }

}


module smdSop(p=8){
    l = p/2*1.27 - 0.18;
    w = 3.9;
    r = 0.2;
    union(){
        color("Black",0.9) hull(){
            translate([r,r,r+.175])
            sphere(r);
            translate([l-r,r,r+.175])
            sphere(r);
            translate([r,w-r,r+.175])
            sphere(r);
            translate([l-r,w-r,r+.175])
            sphere(r);
            translate([r,r,r+.175+1.375-r])
            sphere(r);
            translate([l-r,r,r+.175+1.375-r])
            sphere(r);
            translate([r,w-r,r+.175+1.375-r])
            sphere(r);
            translate([l-r,w-r,r+.175+1.375-r])
            sphere(r);
        }
        translate([1,1,.175+1.48])
        color("Ivory") cylinder(.1,r=.3);
        for(i=[0:1:p/2-1]){
            translate([.545+i*1.27,w/2,.275+1.375/2])
            twoRowSmdPin();
        }
    }
}

module momentarySwitch(){

    cylinder(11,13.5/2);

}

module fan(s=40,d=10){
    cube([s,s,d]);
}