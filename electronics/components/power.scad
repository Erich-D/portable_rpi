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

module momentarySwitch(cut=false){
    if(!cut){
        color("Black",0.9) intersection(){
            sphere(r=17.3/2);
            translate([-9,-9,0])
            cube([18,18,5.6]);
        }
        color("Black",1) intersection(){
            cylinder(7.7,r=12.1/2);
            translate([0,0,.5])
            sphere(17.3/2-.9);
        }
        translate([0,0,-1])
        color("Black",1) difference(){
            cylinder(1,r=13.2/2);
            translate([6,-5,-.25])
            cube([5,10,2]);
        }
        intersection(){
            color( c = [0, .03, .05, .9] ) union(){
                for(i=[0:1:11]){
                    translate([0,0,-i*.5])
                    rotate([0,-1,0])
                    scale([1,1,.1])
                    sphere(r=11.7/2);
                }
                translate([0,0,-9])
                cylinder(9,r=10.7/2);
            }
            translate([-10.5/2,-8,-10.5])
            color("Black",1) cube([10.5,16,10]);
        }
        translate([0,0,-10])
        color("Black",1) cylinder(10,r=9.1/2);
        translate([3,-2,-13])
        color("Gold") cube([.5,4,3]);
        translate([-3,-2,-13])
        color("Gold") cube([.5,4,3]);
    }else if(cut){
        color("Pink",.8) union(){
            cylinder(8,r=17.5/2);
            translate([0,0,-1.2])
            difference(){
                cylinder(1.2,r=13.5/2);
                translate([6,-5,-.25])
                cube([5,10,2]);
            }
            translate([0,0,-21])
            intersection(){
                cylinder(20,r=12.1/2);
                translate([-10.5/2,-7,.5])
                cube([10.5,14,20]);
            }
        }
    }
}

module fan(s=40,d=10,r=4,cut=false,mount=false,md=10){
    if(!cut && !mount){
        color("Black",0.9) difference(){
            translate([-(s-r*2)/2,-(s-r*2)/2,0])
            minkowski(){
                cube([s-r*2,s-r*2,d/2]);
                cylinder(d/2,r=r);
            }
            translate([0,0,2])
            cylinder(11,r=19);
            union(){
                rotate_extrude(angle=80,convexity=10)
                translate([11.5,-.1])
                square([7.5,7]);
                translate([11.5+7.5/2,0,1.4])
                cylinder(3,r=7.5/2,center=true);
                rotate([0,0,80])
                translate([11.5+7.5/2,0,1.4])
                cylinder(3,r=7.5/2,center=true);
            }
            rotate([0,0,120])
            union(){
                rotate_extrude(angle=80,convexity=10)
                translate([11.5,-.1])
                square([7.5,7]);
                translate([11.5+7.5/2,0,1.4])
                cylinder(3,r=7.5/2,center=true);
                rotate([0,0,80])
                translate([11.5+7.5/2,0,1.4])
                cylinder(3,r=7.5/2,center=true);
            }
            rotate([0,0,240])
            union(){
                rotate_extrude(angle=80,convexity=10)
                translate([11.5,-.1])
                square([7.5,7]);
                translate([11.5+7.5/2,0,1.4])
                cylinder(3,r=7.5/2,center=true);
                rotate([0,0,80])
                translate([11.5+7.5/2,0,1.4])
                cylinder(3,r=7.5/2,center=true);
            }
            translate([16,16,-1])
            union(){
                cylinder(12,r=1.6);
                translate([0,0,12-4.1])
                cylinder(4.1,r=3);
            }
            translate([-16,16,-1])
            union(){
                cylinder(12,r=1.6);
                translate([0,0,12-4.1])
                cylinder(4.1,r=3);
            }
            translate([16,-16,-1])
            union(){
                cylinder(12,r=1.6);
                translate([0,0,12-4.1])
                cylinder(4.1,r=3);
            }
            translate([-16,-16,-1])
            union(){
                cylinder(12,r=1.6);
                translate([0,0,12-4.1])
                cylinder(4.1,r=3);
            }
            // translate([15,-21,0])
            // cube([15,42,12]);
        }
        for(i=[0:360/9:360]){
            rotate([0,0,i])
            color("Ivory",0.8) intersection(){
                difference(){
                    translate([7.5+13,7.5,-2.5])
                    rotate([45,0,0])
                    rotate([0,-90,0])
                    union(){
                        rotate_extrude(angle=45,convexity=10)
                        translate([12,0])
                        square([1,15]);
                        translate([12,-10,0])
                        cube([1,10,15]);
                    }
                    translate([0,0,-2.5])
                    cube([45,45,10],center = true);
                    translate([0,0,5+9.5])
                    cube([45,45,10],center = true);
                    cylinder(10,r=11);
                }
                cylinder(10,r=18.5);
            }
        }
        translate([0,0,2.5])
        color("DimGray",0.8) cylinder(7,r=11.5);
    }else if(cut){
        color("Pink",0.6) union(){
            translate([-(s+1-(r+.5)*2)/2,-(s+1-(r+.5)*2)/2,-.25])
            minkowski(){
                cube([s+1-(r+.5)*2,s+1-(r+.5)*2,d/2+.25]);
                cylinder(d/2+.25,r=(r+.5));
            }
            translate([16,16,0])
            union(){
                cylinder(12,r=1.6);
                translate([0,0,12-4.1])
                cylinder(7.1,r=3);
                translate([0,0,0])//set minus to cut hole for screw mount
                cylinder(7.1,r=1.45);
            }
            translate([-16,16,0])
            union(){
                cylinder(12,r=1.6);
                translate([0,0,12-4.1])
                cylinder(7.1,r=3);
                translate([0,0,0])
                cylinder(7.1,r=1.45);
            }
            translate([16,-16,0])
            union(){
                cylinder(12,r=1.6);
                translate([0,0,12-4.1])
                cylinder(7.1,r=3);
                translate([0,0,0])
                cylinder(7.1,r=1.45);
            }
            translate([-16,-16,0])
            union(){
                cylinder(12,r=1.6);
                translate([0,0,12-4.1])
                cylinder(7.1,r=3);
                translate([0,0,0])
                cylinder(7.1,r=1.45);
            }
            translate([0,0,-4])
            cylinder(4,44/2,39/2);
            rotate([0,0,45])
            intersection(){
                union(){
                    for(i=[0:1:11]){
                        translate([0,-25+((2.2+2.4)*i),0])
                        translate([-30,-1.1,-8])
                        cube([60,2.2,5]);
                    }
                }
                translate([0,0,-9])
                cylinder(15,r=22);
            }
        }
    }else{
        translate([-s/2+r,-s/2+r,0])
        difference(){
            union(){
                hull(){
                    translate([0,0,12])
                    minkowski(){
                        cube([s+2-(r+1)*2,s+2-(r+1)*2,.25]);
                        cylinder(.25,r=(r+1));
                    }
                    translate([0,0,1])
                    minkowski(){
                        cube([s+3-(r+1.5)*2,s+3-(r+1.5)*2,.25]);
                        cylinder(.25,r=(r+1.5));
                    }
                }
                hull(){
                    translate([0,0,1])
                    minkowski(){
                        cube([s+3-(r+1.5)*2,s+3-(r+1.5)*2,.25]);
                        cylinder(.25,r=(r+1.5));
                    }
                    translate([0,0,-3])
                    minkowski(){
                        cube([s+15-(r+7.5)*2,s+15-(r+7.5)*2,.25]);
                        cylinder(.25,r=(r+7.5));
                    }
                }
                hull(){
                    translate([0,0,-3])
                    minkowski(){
                        cube([s+15-(r+7.5)*2,s+15-(r+7.5)*2,.25]);
                        cylinder(.25,r=(r+7.5));
                    }
                    translate([0,0,-8])
                    minkowski(){
                        cube([s+15-(r+7.5)*2,s+15-(r+7.5)*2,.25]);
                        cylinder(.25,r=(r+7.5));
                    }
                }
                hull(){
                    translate([0,0,-8])
                    minkowski(){
                        cube([s+15-(r+7.5)*2,s+15-(r+7.5)*2,.25]);
                        cylinder(.25,r=(r+7.5));
                    }
                    translate([0,0,-15])
                    minkowski(){
                        cube([s+25-(r+12.5)*2,s+25-(r+12.5)*2,.25]);
                        cylinder(.25,r=(r+12.5));
                    }
                }
            }
            translate([0,0,8.1])
            minkowski(){
                cube([s-2-(r-1)*2,s-2-(r-1)*2,2.25]);
                cylinder(2.25,r=(r-1));
            }
            translate([0,0,7.6])
            cube([12,12,10],center=true);
            translate([32,0,7.6])
            cube([12,12,10],center=true);
            translate([0,32,7.6])
            cube([12,12,10],center=true);
            translate([32,32,7.6])
            cube([12,12,10],center=true);
            translate([37/2-2.5,37/2-2.5,20])
            hull(){
                cube([50,50,.1],center=true);
                translate([0,0,-10])
                cube([37,37,.1],center=true);
            }
        }
    }
}