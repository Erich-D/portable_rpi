module elbow(t=0.4,h=3,f=0.65,w=0.53){
    translate([0,0,-w/2])
    union(){
        translate([0,t/2,0])
        cube([t,h-t/2,w]);
        translate([t/2,0,0])
        cube([f,t,w]);
        translate([t/2,t/2,0])
        cylinder(w,r=t/2,$fn=10);
    }
}

module twoRowSmdPin(){
    color("Silver") union(){
        translate([0,-3+.42,0])
        union(){
            rotate([0,90,0])
            elbow(.2,2.6,.4,.42);
            translate([0,.2,-1.375/2-.275])
            rotate([90,0,-90])
            elbow(.2,.66,.4,.42);
        }
        mirror([0,1,0])
        translate([0,-3+.42,0])
        union(){
            rotate([0,90,0])
            elbow(.2,2.6,.4,.42);
            translate([0,.2,-1.375/2-.275])
            rotate([90,0,-90])
            elbow(.2,.66,.4,.42);
        }
    }
}

module step(t=0.2,h=3,ul=2,ll=2,w=1){
    sq = [w,t];
    r = 0.5;
    translate([-w/2,0,0])
    union(){
        rotate([90,0,0])
        union(){
            linear_extrude(height=ul)
            square(sq);//lower
            translate([0,t,0])
            rotate([-90,0,0])
            rotate([0,90,0])
            rotate_extrude(angle=45,$fn=40)
            square([sq[1],sq[0]]);
        }
        translate([0,0,t])
        rotate([-45,0,0])
        linear_extrude(height=(h-t)/sin(45))
        square(sq);//angle

        translate([0,h-t/2*sin(45),3-t*sin(45)])
        rotate([90,0,0])
        union(){
            translate([0,0,-ll])
            linear_extrude(height=ll)
            square(sq);//upper
            translate([0,0,0])
            rotate([90,0,0])
            rotate([0,90,0])
            rotate_extrude(angle=45,$fn=40)
            translate([0,0])
            square([sq[1],sq[0]]);
        }
   } 
}

module board(w=66,h=56,mid=false)
color("Green",0.8){
    rd = 3.5;
    difference(){
        minkowski(){
            cube([w-rd*2,h-rd*2,1]);
            cylinder(1,r=rd);
        }
        translate([0,0,-0.5])
        cylinder(3,r=1.3,$fn=10);
        translate([0,h-rd*2,-0.5])
        cylinder(3,r=1.3,$fn=10);
        translate([w-rd*2,h-rd*2,-0.5])
        cylinder(3,r=1.3,$fn=10);
        translate([w-rd*2,0,-0.5])
        cylinder(3,r=1.3,$fn=10);
        // middle holes
        if(mid){
          translate([0,23,-0.5])
          cylinder(3,r=1.3,$fn=10);
          translate([w-rd*2,23,-0.5])
          cylinder(3,r=1.3,$fn=10);
        }
    }
}

module taperedCylinder(h1=1,h2=1,r1=.75,r2=1.5){
    union(){
        cylinder(h1,r1,r2);
        translate([0,0,h1-.01])
        cylinder(h2,r=r2);
    }
}

module batteryClip(){
    rotate([90,0,0])
    union(){
        translate([0,-1.49,0])
        cube([0.5,3.01,1.5],center=true);
        translate([-0.25,0,3.5])
        rotate([-90,0,0])
        linear_extrude(height=14)
        square([.5,7]);

        translate([-0.5,14,-3.5])
        rotate([0,0,0])
        rotate_extrude(angle=150,$fn=10)
        translate([.25,0,0])
        square([.5,7]);

        translate([-5*sin(30)-(.75*sin(30)+.74),14-5*cos(30)+(.5*cos(30)),3.5])
        union(){
            rotate([-90,0,-30])
            linear_extrude(height=5)
            square([.5,7]);
            translate([.18,-0.17,-7])
            cylinder(7,r=.25,$fn=12);
        }

        translate([-3.68,6.89,3.5])
        union(){
            rotate([-90,0,0])
            linear_extrude(height=3)
            square([.5,7]);
            translate([.75,0,-7])
            rotate([0,0,180])
            rotate_extrude(angle=150,$fn=10)
            translate([.25,0,0])
            square([.5,7]);
        }
    }
}

module roundedCorner(r=.625,s=10,h=6){
    translate([r,r,0])
    cylinder(h,r=r,$fn=18);
    translate([r,0,0])
    cube([s-r,s,h]);
    translate([0,r,0])
    cube([r+.1,s-r,h]);
}

module taperedBox(w1=15,h1=15.5,w2=19,h2=22,z=6){
    hull(){
        cube([w1,h1,.1],center=true);
        translate([0,0,z])
        cube([w2,h2,.1],center=true);
    }
}

module capsule(r=1.5,d=3,z=0.1){
    hull(){
        translate([-d/2,0,0])
        cylinder(z,r=r,$fn=22);
        translate([d/2,0,0])
        cylinder(z,r=r,$fn=22);
    }
}

module taperedCapsule(r1=1.5,d1=3,r2=2,d2=4,z=6){
    hull(){
        capsule(r1,d1);
        translate([0,0,z])
        capsule(r2,d2);
    }
}

module rpi4hdmiSideOutRelief(){
    union(){
      hull(){
          translate([-5.95/2+44,0,0])
          cylinder(6,3.75,6.5,$fn=10);
          translate([-5.95/2-1,0,0])
          cylinder(6,3.75,6.5,$fn=10);
      }
      translate([-5.95/2+45.5,2.25,0])
      cylinder(6,6,8.5);
    }
}

module hdmiBody(){
  color("Black")
  difference(){
      hdmiShell();
      translate([0,0,0])
      hdmiShell(19,10,0.01);
      translate([11,6,16])
      rotate([90,-90,0])
      hdmiShellCutouts();
      mirror([1,0,0])
      translate([11,6,16])
      rotate([90,-90,0])
      hdmiShellCutouts();
  }
  color("DarkSlateGray")
  hdmiShell(19,10,0.01);
}

module hdmiShell(w=20,h=11,r=.5){
    hull(){
    translate([-w/2+r,h/2-r,18])
    sphere(r,$fn=20);
    translate([-w/2+r,-h/2+r,18])
    sphere(r,$fn=20);
    translate([w/2-r,-h/2+r,18])
    sphere(r,$fn=20);
    translate([w/2-r,h/2-r,18])
    sphere(r,$fn=20);

    translate([-w/2+r,h/2-r,35])
    sphere(r,$fn=20);
    translate([-w/2+r,-h/2+r,35])
    sphere(r,$fn=20);
    translate([w/2-r,-h/2+r,35])
    sphere(r,$fn=20);
    translate([w/2-r,h/2-r,35])
    sphere(r,$fn=20);

    translate([-w/4+r,h/2-r-1.5,7])
    sphere(r,$fn=20);
    translate([-w/4+r,-h/2+r+1.5,7])
    sphere(r,$fn=20);
    translate([w/4-r,-h/2+r+1.5,7])
    sphere(r,$fn=20);
    translate([w/4-r,h/2-r-1.5,7])
    sphere(r,$fn=20);
  }
}

module hdmiShellCutouts(){
  intersection(){
      scale([1,.4,1])
      cylinder(20,r=15);
      union(){
          translate([-1,-6,-1])
          cube([2,12,22]);
          translate([-1+4,-6,-1])
          cube([2,12,22]);
          translate([-1+8,-6,-1])
          cube([2,12,22]);
          translate([-1+12,-6,-1])
          cube([2,12,22]);
      }
  }
}

module roundedVent(r1=25,r2=37.5){
    s = (r1 > r2) ? r1*2:r2*2;
    intersection(){
        scale([r2/r1,1,1])
        cylinder(10,r=r1,center=true);
        rotate([0,0,22])
        difference(){
            union(){
                for(i=[0:1:s/4.4+1]){
                    translate([-s/2+i*4.4,0,0])
                    cube([2,s+2,10],center=true);
                }
            }
            rotate([0,0,45])
            cube([2,s*2/sin(45),11],center=true);
        }
    }
}