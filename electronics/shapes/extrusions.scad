//sideThumb();
module sideThumb(l=20,tbs=2.5){
    rotate([90,0,0])
    linear_extrude(height=l)
    translate([-tbs*2.5,0,0])
    2dThumb();
}

//insideThumb();
module insideThumb(tbs=2.5){
    translate([-(10-tbs*2.5),-(10-tbs*2.5),0])
    rotate_extrude(angle=90,convexity=10)
    translate([10,0,0])
    mirror([1,0,0])
    2dThumb();
}

//2dThumb();
module 2dThumb(tbs=2.5){
    translate([0,-tbs,0])
    union(){
        difference(){
            square([10,5]);
            scale([2.5,1,1])
            circle(tbs,$fn=30);
        }
        translate([-3,tbs,0])
        square([3,5-tbs]);
        translate([tbs*2.5,-3,0])
        square([10-tbs*2.5,3]);
    }

}

hdmiw = 11.2;
hdmih = 3.2;
//hdmiProfile();
module hdmiProfile(profile="Full",color="Silver"){
    hdmiw = profile == "Full" ? 11.2:6.5;
    hdmih = profile == "Full" ? 3.2:2.9;
    hdmimw = profile == "Full" ? 8.3:4.44;
    hdmimh = profile == "Full" ? -0.3:-0.38;
    color(color)
    hull(){
        translate([-hdmiw/2+.5,hdmih/2-.5,0])
        circle(0.5,$fn=15);
        translate([hdmiw/2-.5,hdmih/2-.5,0])
        circle(0.5,$fn=15);
        translate([-hdmiw/2+.5,hdmimh,0])
        circle(0.5,$fn=15);
        translate([hdmiw/2-.5,hdmimh,0])
        circle(0.5,$fn=15);
        translate([hdmimw/2,-hdmih/2+.5,0])
        circle(0.5,$fn=15);
        translate([-hdmimw/2,-hdmih/2+.5,0])
        circle(0.5,$fn=15);
    }
}

module microUsbProfile(micusbw = 6.9,micusbh = 1.85){
  hull(){
        translate([-micusbw/2,micusbh/2,0])
        circle(0.3,$fn=15);
        translate([micusbw/2,micusbh/2,0])
        circle(0.3,$fn=15);
        translate([-micusbw/2,0,0])
        circle(0.3,$fn=15);
        translate([micusbw/2,0,0])
        circle(0.3,$fn=15);
        translate([micusbw/2-micusbh/2,-micusbh/2,0])
        circle(0.3,$fn=15);
        translate([-(micusbw/2-micusbh/2),-micusbh/2,0])
        circle(0.3,$fn=15);
    }
}

module roundedRect(r=0.5,w=20,h=11){
    hull(){
        translate([-w/2+r,h/2-r,0])
        circle(r,$fn=15);
        translate([w/2-r,h/2-r,0])
        circle(r,$fn=15);
        translate([w/2-r,-h/2+r,0])
        circle(r,$fn=15);
        translate([-w/2+r,-h/2+r,0])
        circle(r,$fn=15);
    }
}

module 2020alumExtrude(x=20,y=20){
    or = 1.5; // outside square radius
    ttr = 2;  // top of t-nut channel radius
    r1 = .5;  // radius for most outside corners
    r2 = .1;  // radius for sharp inside corners
    tnw = 11; // t-nut channel width
    tth = 6.1; // t-nut channel total height
    tsh = 1.8; // t-nut shoulder height
    ecr = 5/2; // extrusion center radius
    ns = 6.2; //narrow shoulder width
    bs = 7.2; // broad shoulder width
    
    difference(){
        roundedRect(or,x,y);
        hull(){
            translate([0,0])
            circle(r1);
        }
    }
}