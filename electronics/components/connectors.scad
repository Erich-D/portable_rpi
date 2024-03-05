include<../shapes/extrusions.scad>
use<../components/connectors.scad>
use<../shapes/compound.scad>

module usbCpanelMount(){
    hull(){
        translate([-4,0,0])
        cylinder(4,r=4);//cylinder(2,4,3);
        translate([4,0,0])
        cylinder(4,r=4);
    }
    translate([0,0,-10.5/2])
    cube([12,5.2,10.5],center=true);
    translate([0,0,-9.5/2])
    cube([13,4.8,9.5],center=true);
    translate([0,0,-10.5/2])
    cube([18,7,8.5],center=true);
}

module hdmiPcbFemaleSocket(){
    translate([0,11,1.85])
    rotate([90,0,0])
    union(){
        color("Silver"){ 
        difference(){
            union(){
                linear_extrude(height = 11)
                hdmiProfile();
                translate([5.3,0,7.5])
                rotate([90,0,0])
                cylinder(3,r=.4);
                translate([-5.3,0,7.5])
                rotate([90,0,0])
                cylinder(3,r=.4);
                translate([5.3,-(hdmih/2+.25),0])
                elbow();
                translate([-5.3,-(hdmih/2+.25),0])
                mirror([1,0,0])
                elbow();
            }
            translate([0,0,2])
            linear_extrude(height = 12)
            offset(r=-.2) hdmiProfile();
        }}
        translate([0,.15,4.5])
        color("White") cube([8.3,.3,7],center=true);
        for(i=[0:1:18]){
            translate([-3.66+i*.4,-(hdmih/2+.25),.3])
            rotate([0,90,0])
            color("Gold") elbow(w=0.12);
        }
        for(i=[0:1:18]){
            translate([-3.6+i*.4,0,6.6])
            color("Gold")
            difference(){
                cube([.3,.4,3],center=true);
                translate([0,-.15,0])
                cube([.175,.4,3.2],center=true);
            }
        }
    }
}

module microUSBpcbFemaleSocket(micusbw = 6.9,micusbh = 1.85){
    translate([0,5,1.85/2+.3])
  rotate([90,0,0])
  union(){
    color("Silver")
    difference(){
      union(){
        linear_extrude(height=5)
        microUsbProfile();
        translate([3.40,-(micusbh/2+.25),5-2.5-.2])
        elbow(h=2);
        translate([-3.40,-(micusbh/2+.25),5-2.5-.2])
        mirror([1,0,0])
        elbow(h=2);
      }
      translate([0,0,1])
      linear_extrude(height = 12)
      offset(r=-.2) microUsbProfile();
    }
    translate([0,.35,1.5+1])
    color("Black") cube([3.5,.3,3],center=true);
    for(i=[0:1:4]){
        translate([-1.3+i*.65,-(micusbh/2+.25),.3])
        rotate([0,90,0])
        color("Gold") elbow(h=2,w=0.12);
    }
    for(i=[0:1:4]){
        translate([-1.3+i*.65,.2,2.5])
        color("Gold")
        difference(){
            cube([.3,.4,3],center=true);
            translate([0,-.15,0])
            cube([.175,.4,3.2],center=true);
        }
    }
  }
}

// ************ modules for making headers ***************
module header(pinNum=20,rows=2){
    difference(){
        color("Black",0.9)
        cube([pinNum*2.5+1.25,rows*2.5,11]);
        for(r=[0:1:rows-1]){
            translate([2,r*2.5+1.25,11])
            rotate([180,0,0])
            headrHole(pinNum);
        }
    }
    for(r=[0:1:rows-1]){
            translate([2,r*2.5+1.25,-12])
            headrPins(pinNum);
        }
}

//headrPins();
module headrPins(pinNum=20){
    for(i=[0:1:pinNum-1]){
        translate([i*2.5,0,-0.01])
        color("Silver")
        cylinder(15,r=0.5);
    }
}

//headrHole();
module headrHole(pinNum=20){
    for(i=[0:1:pinNum-1]){
        translate([i*2.5,0,-0.01]){
            color("DarkSlateGray",0.8)
            union(){
                rotate([0,0,45])
                cylinder(1.5,1.5,.75,$fn=4);
                cylinder(3,r=.75,$fn=10);
            }
        }
    }
}
// ********* end of header modules ***************

//*********** modules for making male headers ***********

//hPinRow(16);                   //makes row of pins
module hPinRow(num=40,color="Red"){
    for(i=[0:1:num-1]){
        translate([i*2.5,0,0])
        hPin(color);
    }
    translate([-1.25,-0.5,0])
    color(color)
    cube([2.5*num,1,2.25]);
}

//hPin();           //makes single header pin with colored stop
module hPin(c="Yellow"){
    color(c,0.9)
    rotate([0,0,360/8/2])
    cylinder(2.25,r=1.25,$fn=8);
    translate([0,0,-3])
    color("Silver")
    cylinder(12,r=0.5);
}

//*********** END modules for making male headers ***********

//************ modules for makes screw blocks ****************

// makes a line of screwblocks
module screwBlockLine(num=2){
    for(n=[0:1:num-1]){
        translate([n*5,0,0])
        screwBlock();
    }
}

// makes a single screwblock
module screwBlock(){
    color("Blue",0.9){
        difference(){
            cube([5,8,10]);
            translate([-0.5,8,6.5])
            rotate([atan2(1.75,3.5),0,0])
            translate([0,0,-2])
            cube([6,5,10]);
            translate([-0.5,0,6.5])
            rotate([-atan2(1.75/2,3.5),0,0])
            translate([0,-5,-2])
            cube([6,5,10]);
            translate([2.5,3,10-3.9])
            cylinder(4,r=1.5);
            translate([0.5,-0.1,1])
            cube([4,5,5]);
            translate([4.5,6,-0.1])
            cube([1.1,1,6.6]);
        }
        translate([-0.5,6,0])
        cube([1.1,1,6.6]);
    }
    color("Silver",0.9){
        translate([2.5,3,6.6])
        difference(){
            cylinder(3.5, r=1.5, $fn=25);
            translate([0,0,4])
            rotate([0,0,15])
            cube([8,0.5,2],center=true);
        }
        translate([2.5,3,-3])
        cylinder(4,r=0.75);
        translate([0.5,0,1])
        difference(){
            cube([4,5,5]);
            translate([0.5,-0.1,0.5])
            cube([3,6,2]);
        }
    }
}

//************END modules for makes screw blocks ****************

// **********************  module for ethernet block *****************
module etherline(num=4){
    for(i=[0:1:num-1]){
        translate([i*13.75,0,0])
        ether();
    }
    translate([0.1,13.5,-3])
    color("Silver",0.9)
    cylinder(4,r=0.5);
    translate([num*13.75+1.25-0.1,13.5,-3])
    color("Silver",0.9)
    cylinder(4,r=0.5);

    translate([3,6,-3])
    color("Black",0.9)
    clipPin();
    translate([num*13.75+1.25-3,6,-3])
    color("Black",0.9)
    clipPin();
}

module clipPin(){
    color("Black",0.9){
        difference(){
            union(){
                cylinder(1.5,1,1.5,$fn=15);
                translate([0,0,1.5])
                cylinder(2.5,r=1.5);
            }
            cube([0.5,4,4],center=true);
            translate([0,-2.25,0])
            cube([4,2,4],center=true);
            translate([0,2.25,0])
            cube([4,2,4],center=true);
        }
    }
}
//ether();
module ether(){
    difference(){
        color("Silver",0.9)
        cube([15,15,16]);
        translate([1.25,4,1.1])
        color("Black",0.9)
        union(){
            cube([12.5,7.5,15]);
            translate([2.75,7.4,0])
            cube([7,2,15]);
            translate([3.75,15,15])//3.75,7.4,0
            rotate([-15,0,0])
            translate([0,-7,-11])
            cube([4.5,3,15]);
        }
        
    }
    for(i=[0:1:7]){
        translate([i+3.75,2,1])
        contact();
    }
    for(i=[0:1:3]){
        translate([i*2.5+1,1,-3])
        color("Silver",0.9)
        cylinder(4,r=0.5);
    }
    for(i=[0:1:3]){
        translate([i*2.5+2.25,3.25,-3])
        color("Silver",0.9)
        cylinder(4,r=0.5);
    }
}

module contact(){
    difference(){
        color("Silver")
        cube([0.5,5,8]);
        color("Silver")
        translate([0,4,4])
        rotate([20,0,0])
        translate([-0.25,0,-3])
        cube([1,8,10]);
    }
}
// ********************** end module for ethernet block *****************

module JST2mm2pin(){
    translate([-4,-3,0])
    union(){
        color("White")
        difference(){
            cube([8,6,6.5]);
            translate([1.5,0.5,1.1])
            cube([5,3,5.5]);
            translate([3.5,3.4,1.1])
            cube([1,1,5.5]);

            translate([1.5,3.4,-.1])
            cube([1,3,5]);
            translate([5.5,3.4,-.1])
            cube([1,3,5]);

            translate([-.5,1,-.1])
            cube([1.5,2.5,7]);
            translate([7,1,-.1])
            cube([1.5,2.5,7]);
        }
        translate([7,2.25,0])
        rotate([90,0,0])
        color("Silver") elbow(t=.2,h=6.5,w=3);
        translate([1,2.25,0])
        rotate([90,0,180])
        color("Silver") elbow(t=.2,h=6.5,w=3);
        translate([3,.2,0])
        rotate([90,0,-90])
        color("Silver") elbow(t=.2,h=1.5,f=1);
        translate([5,.2,0])
        rotate([90,0,-90])
        color("Silver") elbow(t=.2,h=1.5,f=1);
        translate([3,2.5,0.5])
        color("Silver") cylinder(5.5,r=.35);
        translate([5,2.5,0.5])
        color("Silver") cylinder(5.5,r=.35);
    }
}

module JST2_5mm2pin(){
    translate([-5,-3,0.2])
    union(){
        color("White")
        difference(){
            union(){
                cube([10,6,4]);
                translate([1,0,3.99])
                cube([8,6,4]);
            }
            translate([1.5,0.5,2.5])
            cube([7,5,5.5]);
            translate([0,0.5,4])
            cube([10,0.5,5.5]);
            translate([5,-1.7,3])
            hull(){
                taperedCylinder(h2=4.1);
                translate([0,3.4,0])
                taperedCylinder(h2=4.1);
            }
            translate([-.5,1,-.2])
            cube([1.5,2.5,7]);
            translate([9,1,-.1])
            cube([1.5,2.5,7]);
        }
        translate([9,2.25,-0.2])
        rotate([90,0,0])
        color("Silver") elbow(t=.2,h=4,w=3);
        translate([1,2.25,-0.2])
        rotate([90,0,180])
        color("Silver") elbow(t=.2,h=4,w=3);
        translate([5+2.54/2,5.8,-0.2])
        rotate([90,0,90])
        color("Silver") elbow(t=.2,h=1.5,f=1);
        translate([5-2.54/2,5.8,-0.2])
        rotate([90,0,90])
        color("Silver") elbow(t=.2,h=1.5,f=1);
        translate([5-2.54/2,2.5,3])
        color("Silver") cylinder(4,r=.35);
        translate([5+2.54/2,2.5,3])
        color("Silver") cylinder(4,r=.35);
    }
}

module usbCfemaleSocket(cut=false){
    translate([-5.75/2,0,-6.8])
    union(){
        if(!cut){
                color("Silver",0.9)
                difference(){
                    hull(){
                        cylinder(6.8,r=3.25/2,$fn=10);
                        translate([9-3.25,0,0])
                        cylinder(6.8,r=3.25/2,$fn=10);
                    }
                    translate([0,0,-.01])
                    hull(){
                        cylinder(6.9,r=2.56/2,$fn=10);
                        translate([9-3.25,0,0])
                        cylinder(6.9,r=2.56/2,$fn=10);
                    }
                }
                translate([2.875+5.75,0,.4])//2.875+5.75
                rotate([0,0,90])
                color("Silver",0.9) elbow(t=0.3,h=1.5,f=1.75,w=0.8);
                translate([-2.875,0,.4])//2.875+5.75
                mirror([1,0,0])
                rotate([0,0,90])
                color("Silver",0.9) elbow(t=0.3,h=1.5,f=1.75,w=0.8);
                translate([2.875+5.75,0,3.4+.6])//2.875+5.75
                rotate([0,0,90])
                color("Silver",0.9) elbow(t=0.3,h=1.5,f=1.75,w=1.2);
                translate([-2.875,0,3.4+.6])//2.875+5.75
                mirror([1,0,0])
                rotate([0,0,90])
                color("Silver",0.9) elbow(t=0.3,h=1.5,f=1.75,w=1.2);
                translate([0,0,0])
                color("Black")
                hull(){
                    cylinder(1.9,r=2.56/2,$fn=10);
                    translate([9-3.25,0,0])
                    cylinder(1.9,r=2.56/2,$fn=10);
                }
                color("White")
                translate([5.75/2-3.345,-0.72/2,0])
                cube([6.69,0.72,6]);
                for(i=[0:1:5]){
                    translate([5.75/2-2.5+i,0.3,0.15])//2.875+5.75
                    rotate([0,90,180])
                    color("Silver",0.9) elbow(t=0.2,h=1,f=0.8,w=0.56);
                }
        }else{
            color("Pink",0.5)
            translate([5.75/2,0,6])
            hull(){
                translate([-5.75/2,0,0])
                cylinder(1,r=3.5/2,$fn=10);
                translate([5.75/2,0,0])
                cylinder(1,r=3.5/2,$fn=10);
            }
            color("Pink",0.5)
            translate([5.75/2,0,7])
            hull(){
                hull(){
                    translate([-5.75/2,0,0])
                    cylinder(.1,r=7.3/2,$fn=10);
                    translate([5.75/2,0,0])
                    cylinder(.1,r=7.3/2,$fn=10);
                }
                translate([0,0,6])
                scale([1.5,1.1,1])
                hull(){
                    translate([-5.75/2,0,0])
                    cylinder(.1,r=7.3/2,$fn=10);
                    translate([5.75/2,0,0])
                    cylinder(.1,r=7.3/2,$fn=10);
                }
            }
        }
    }
}

module hdmiFemaleEnd(){
  union(){
        color("Silver"){ 
        difference(){
            linear_extrude(height = 11)
            hdmiProfile();
            translate([0,0,2])
            color("Black") linear_extrude(height = 12)
            offset(r=-.2) hdmiProfile();
        }}
        translate([0,.15,4.5])
        color("White") cube([8.3,.3,7],center=true);
        for(i=[0:1:18]){
            translate([-3.6+i*.4,0,6.6])
            color("Gold")
            difference(){
                cube([.3,.4,3],center=true);
                translate([0,-.15,0])
                cube([.175,.4,3.2],center=true);
            }
        }
    }
}

module UsbAFemalePcb(){
    translate([0,0,3+.1+.75])
    rotate([0,-90,0])
    union(){
        color("Silver") difference(){
            linear_extrude(height=10)
            roundedRect(w=6,h=13);
            translate([0,0,-0.5])
            linear_extrude(height=11)
            roundedRect(w=5.5,h=12.5);
        }
        color("Black") linear_extrude(height=3)
        roundedRect(w=5.5,h=12.5);
        translate([0,-5,0])
        color("Black") cube([1,10,9.5]);
        for(i=[0:1:3]){
            translate([-3.1-.75,-2.56*1.5+2.56*i,.1])
            rotate([0,90,-90])
            color("Silver") elbow(.2,2,1,.75);
            translate([-.1,-2.56*1.5-.5+2.56*i,.5])
            color("Gold") cube([.2,1,8]);
        }
        translate([-6/2-2.45,13/2-.1,1])
        color("Silver") cube([4,.2,.5]);
        translate([-6/2-2.45,-13/2-.1,1])
        color("Silver") cube([4,.2,.5]);
        translate([-6/2-2.45,13/2-.1,7])
        color("Silver") cube([4,.2,.5]);
        translate([-6/2-2.45,-13/2-.1,7])
        color("Silver") cube([4,.2,.5]);
    }
}