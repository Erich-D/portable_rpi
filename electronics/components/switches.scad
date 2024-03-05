use<../shapes/compound.scad>

module smallSTDPswitch(){
    difference(){
        color("Silver") cube([9,4,3.5],center=true);
        translate([0,0,-.5])
        color("Silver") cube([8,4.5,3.5],center=true);
        translate([0,0,2])
        color("Silver") cube([3.5,1.5,4],center=true);
    }
    translate([0,0,-.25])
    color("Black") cube([8,4,3],center=true);
    translate([0,-.75,1.2])
    color("Black") cube([1.5,1.5,3]);
    translate([0,1.8,-1.76])
    rotate([90,0,90])
    color("Silver") elbow(h=1,f=1.2);
    translate([0,-1.8,-1.76])
    rotate([90,0,-90])
    color("Silver") elbow(h=1,f=1.2);
    translate([-2.5,1.8,-1.76])
    rotate([90,0,90])
    color("Silver") elbow(h=1,f=1.2);
    translate([-2.5,-1.8,-1.76])
    rotate([90,0,-90])
    color("Silver") elbow(h=1,f=1.2);
    translate([2.5,1.8,-1.76])
    rotate([90,0,90])
    color("Silver") elbow(h=1,f=1.2);
    translate([2.5,-1.8,-1.76])
    rotate([90,0,-90])
    color("Silver") elbow(h=1,f=1.2);
}

module smallMomentarySwitch(){
    translate([-3,-3,0.2])
    union(){
        color("Black",0.9){
            cube([6,6,3]);
            translate([5,5,2.9])
            cylinder(1,r=.5);
            translate([1,5,2.9])
            cylinder(1,r=.5);
            translate([5,1,2.9])
            cylinder(1,r=.5);
            translate([1,1,2.9])
            cylinder(1,r=.5);
        }
        color("Silver",0.9)
        translate([0,0,3])
        cube([6,6,.5]);
        color("Blue",0.9)
        translate([3,3,3.4])
        cylinder(1.6,r=1.75,$fn=20);
        color("Silver",0.9){
        translate([5.8,1,-0.2])
        rotate([90,0,0])
        elbow();
        translate([5.8,5,-0.2])
        rotate([90,0,0])
        elbow();
        translate([0.2,1,-0.2])
        rotate([90,0,180])
        elbow();
        translate([.2,5,-0.2])
        rotate([90,0,180])
        elbow();
        }
    }

}