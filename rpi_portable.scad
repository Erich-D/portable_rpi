use <D:\Documents\OpenSCAD\CycloidDrive\utilities.scad>
use<rpi4_model\more\davex\raspberry-pi-4-model-b-openscad-model-w-io\90c673e1-6bf9-4234-935d-6cf6b8fdb27a.scad>
use<screen\7DP_CAPLCD.scad>
use<components/breakoutBoards.scad>
use<components/power.scad>
use<components/adapters.scad>
use<components/drives.scad>
use<components/connectors.scad>
use<shapes/extrusions.scad>
use<inserts.scad>//fastening
use<shapes/compound.scad>
use<battery/Ryobi_Batt.scad>
include<D:\Documents\OpenSCAD\libraries\Gears\gears.scad>
/* [View] */
Views = 0; // [0:example,1:custom,2:top(part),3:bottom(part),4:screen(part)]
/* [Cut View] */
Cut_Radius = 80; //[1:360]
/* [Shell Dimensions] */
// width
X = 200; //[150:300]
// depth
Y = 150; //[100:200]
// height
Z = 88; //[50:140]
// changes height of front of case
Front_Height = 42; //[30:140]
// sets radius for box edges
Corner_Radius = 10; //[8:15]
// bevels front of encloser
Front_Backset = 6; //[0:6]
/* [Battery Offsets] */
// adjusts battery position in X axis
Battery_Position_X = -35; //[-60:5]
// adjusts battery position in X axis
Battery_Position_Y = 5; //[0:20]
// adjusts battery position in X axis
Battery_Position_Z = 0; //[0:20]
/* [Pad 1 Position] */
Pad1_X = -22; //[-150:150]
Pad1_Y = 34; //[-100:100]
Pad1_Z = 10; //[0:140]
/* [Pad 2 Position] */
Pad2_X = 58; //[-150:150]
Pad2_Y = -12; //[-100:100]
Pad2_Z = 13; //[0:140]
/* [Front USB Position] */
USB_X = -33; //[-150:150]
USB_Y = 7; //[-1:20]
USB_Z = 4; //[0:40]
/* [Hidden] */
widthOfEncloser = X;
depthOfEncloser = Y;
radiusOfCorners = Corner_Radius; 
depthOfBevel = 110;
overallHeight = Z;
frontHeight = Front_Height;
WallThickness = 4;
angle = atan2(overallHeight-frontHeight,depthOfBevel);
batPos = [Battery_Position_X,depthOfEncloser/2+Battery_Position_Y,overallHeight/2+Battery_Position_Z];
rpiPos = [Pad1_X,Pad1_Y,Pad1_Z];
pad2Pos = [Pad2_X,Pad2_Y,Pad2_Z];
frontUsbPos = [USB_X,-depthOfEncloser/2+USB_Y,6+WallThickness+USB_Z];// min z is 11.5/2 + WallThickness
rj45Pos = [37,depthOfEncloser/2-7,49];
usbCharge1Pos = [widthOfEncloser/2-WallThickness,depthOfEncloser/2-radiusOfCorners-20,overallHeight-radiusOfCorners-5];
usbCharge2Pos = [-widthOfEncloser/2+WallThickness,depthOfEncloser/2-radiusOfCorners-20+17,overallHeight-radiusOfCorners-5];
tbs = 2.5; // thumb base radius  **  sets base radius for thumb profile used in screen cutout
w=20;
h=11;
r=.5;
$fn=25;
//************** component modules ***************** main modules and line to find them
/*
    exampleView(); 78
    mainBody(cr=radiusOfCorners, width=widthOfEncloser, depth=depthOfEncloser, mid=depthOfBevel, height=overallHeight,front=frontHeight,shell=true); 118
    shell(s=-1,f=overallHeight+30); 231
    baseBase(); 307
    frontUsb(); 358
    customView(); 408
*/
//exampleView();  // this view uses rpi_shell.stl and the default values it was made with to provide example
module exampleView(){
    difference(){
        union(){
        renderedShell();
        baseBase();
        }
        translate([-200/2,-150/2,0])
        sphere(Cut_Radius);
    }
    translate([-22,34,10])// default numbers for pad1
    rotate([0,0,90])
    pistackCut(false);
    translate([32,68,49])// default
    rotate([90,-90,180])
    translate([-33,3.5,0])
    RPiRJ45BreakoutBoard();
    translate([3,-150/2+110/2,42+110/2*sin(atan2(88-42,110))])
    rotate([atan2(88-42,110),0,0])
    translate([0,0,-4.6])
    7DP_CAPLCD(false,true);
    translate([58,-12,13])// default
    rotate([0,0,0])
    sshd();
    translate([0,150/2,70])
    rotate([90,90,0])
    lm2596_adjV();
    translate([200/2-3,150/2-10-20,88-10-5]) // default
    rotate([180,0,180])
    drokUsbBuck();
    translate([-200/2+3,150/2-10-20+17,88-10-5]) // default
    rotate([180,0,0])
    drokUsbBuck();
    translate([-35,150/2+5,88/2+0]) // default
    rotate([90,0,180])
    batTopPlug();
}
// ********************** modules for building project shell ********************************

// *** creates main shape of body can be adjusted in customizer
//mainBody();
module mainBody(cr=radiusOfCorners, width=widthOfEncloser, depth=depthOfEncloser, mid=depthOfBevel, height=overallHeight,front=frontHeight,shell=true){
    hull(){
        translate([width/2-cr,-depth/2+cr+Front_Backset,cr])// front right
        sphere(cr);
        translate([-width/2+cr,-depth/2+cr+Front_Backset,cr])// front left
        sphere(cr);
        translate([width/2-cr,depth/2,cr])// back right
        sphere(cr);
        translate([-width/2+cr,depth/2-cr,cr])// back left
        sphere(cr);
        //upper front
        harc = frontHeight+cr*tan(angle);
        translate([-width/2+cr,-depth/2+cr,front-cr]) // left
        sphere(cr);
        translate([width/2-cr,-depth/2+cr,front-cr]) // right
        sphere(cr);
        //upper mid
        translate([width/2-cr,-depth/2+mid+cr,height-cr])
        sphere(cr);
        translate([-width/2+cr,-depth/2+mid+cr,height-cr])
        sphere(cr);
        //upper back
        translate([width/2-cr,depth/2,height-cr])//output
        sphere(cr);
        translate([-width/2+cr,depth/2-cr,height-cr])
        sphere(cr);
        if(true){
            translate([batPos[0],shell ? batPos[1]:batPos[1]-8,batPos[2]])// z=66
            rotate([90,0,180])
            scale([shell ? 1:1-WallThickness/67,shell ? 1:1-WallThickness/37,shell ? 1:1-WallThickness/11])
            base();
        }
    }
}

module innerBody(wt=WallThickness){
    mainBody(cr=radiusOfCorners-wt, width=widthOfEncloser-wt*2, depth=depthOfEncloser-wt*2, mid=depthOfBevel, height=overallHeight-wt*2,front=frontHeight-wt*2,shell=false);
}

// adds block to cut relif and mount for GPIO extension panel
module gpioFill(){
    intersection(){
        translate([widthOfEncloser/2-33+Battery_Position_X,depthOfEncloser/2-6,0])//-33+Battery_Position_X
        cube([widthOfEncloser,50,overallHeight]);
        mainBody();
    }
}

// adds block to cut screen relief and mount out of
//screenFill();
module screenFill(){
    angle = atan2(overallHeight-frontHeight,depthOfBevel);
    intersection(){
        translate([0,0,frontHeight+(depthOfBevel+12)/2*sin(angle)])
        rotate([angle,0,0])
        translate([0,0,-6])
        cube([260,260,15],center=true);
        mainBody();
    }
}
module piFill(){
    intersection(){
        union(){
            translate(rpiPos)
            RpiX703ups(pad=true);
            translate([-widthOfEncloser/2,rpiPos[1]-26,0])
            cube([12,68,30]);
        }
        mainBody();
    }
}

module pad2Fill(){
    intersection(){
        translate(pad2Pos)
        rotate([0,0,0])
        sshd(pad=true);
        mainBody();
    }
}

module frontUsbFill(){
    //[USB_X,-depthOfEncloser/2+USB_Y,6+WallThickness+USB_Z]
    w = (15+17.5)*2+15;
    intersection(){
        translate([-w+17.5/2+15+USB_X,-depthOfEncloser/2,0])
        cube([w,20,18+USB_Z]);
        innerBody();
    }
}

module usbChargeFill(){
    translate(usbCharge1Pos)
    rotate([180,0,180])
    drokUsbBuck(pad=true);
    translate(usbCharge2Pos)
    rotate([180,0,0])
    drokUsbBuck(pad=true);
}

module mountPads(){
    intersection(){
        union(){
            translate([-widthOfEncloser/2+5,-depthOfEncloser/2+Front_Backset,0])
            cylinder(20,r=10);
            translate([widthOfEncloser/2-5,-depthOfEncloser/2+Front_Backset,0])
            cylinder(20,r=10);
            translate([-widthOfEncloser/2+5,depthOfEncloser/2,2])
            cylinder(20,r=10);
            // translate([widthOfEncloser/2-5,depthOfEncloser/2,0])
            // cylinder(20,r=10);
        }
        mainBody();
    }
}

module fanPads(){
    intersection(){
        union(){
            translate([-widthOfEncloser/2+7,0,20])
            rotate([0,90,0])
            fan(mount=true);
        }
        mainBody();
    }
}

// ******* creates project shell with major cutouts and block inserts for device mounts ** will return horizontal section of shell strating from s and ending at f 
module shell(s=-1,f=overallHeight+30){
    angle = atan2(overallHeight-frontHeight,depthOfBevel);
    intersection(){
        difference(){
            union(){
                difference(){
                    mainBody();
                    translate([0,0,WallThickness])
                    innerBody();
                    batPlug();
                }
                gpioFill();
                screenFill();
                piFill();
                pad2Fill();
                frontUsbFill();
                usbChargeFill();
                mountPads();
            }
            translate(frontUsbPos)
            //frontUsb();
            import("frontUsbCut.stl",convexity=10);
            translate([frontUsbPos[0]-32.5,frontUsbPos[1],frontUsbPos[2]])
            //frontUsb();
            import("frontUsbCut.stl",convexity=10);
            translate([3,-depthOfEncloser/2+depthOfBevel/2,frontHeight+depthOfBevel/2*sin(angle)])
            rotate([angle,0,0])
            translate([0,0,-4.6])
            //7DP_CAPLCD(true);
            import("screenCut7DP.stl",convexity=10);
            translate([-widthOfEncloser/2+8,-depthOfEncloser/2+Front_Backset+5,13.99])
            import("3x12insertSet.stl",convexity=10);
            translate([widthOfEncloser/2-8,-depthOfEncloser/2+Front_Backset+5,13.99])
            import("3x12insertSet.stl",convexity=10);
            translate([-widthOfEncloser/2+8,depthOfEncloser/2-8,21.7])//hdmi port screw holes
            import("3x12insertSet.stl",convexity=10);
            translate([-widthOfEncloser/2+8,depthOfEncloser/2-40,21.7])
            import("3x12insertSet.stl",convexity=10);
            translate([widthOfEncloser/2-6,depthOfEncloser/2,13.99])
            import("3x12insertSet.stl",convexity=10);
            translate([USB_X+16,-depthOfEncloser/2+Front_Backset+USB_Y+2.5,14])//12-7.9
            rotate([180,0,0])
            import("3x8insertSet.stl",convexity=10);
            //insertSet(3,8);
            translate([USB_X-16.5,-depthOfEncloser/2+Front_Backset+USB_Y+2.5,14])
            rotate([180,0,0])
            import("3x8insertSet.stl",convexity=10);
            translate([USB_X-48.5,-depthOfEncloser/2+Front_Backset+USB_Y+2.5,14])
            rotate([180,0,0])
            import("3x8insertSet.stl",convexity=10);
            translate([rpiPos[0],rpiPos[1]+5,4])
            import("ovalVent.stl",convexity=10);
            translate([pad2Pos[0],pad2Pos[1],4])
            rotate([0,0,90])
            import("ovalVent.stl",convexity=10);
            translate(batPos+[0,.1,0])
            rotate([90,0,180])
            scale([1.1,1.1,1.1])
            hull(){batTopPlug();}
            translate([0,depthOfEncloser/2,70])
            rotate([90,90,0])
            lm2596_adjV(true);
            translate([-20,batPos[1],batPos[2]])
            rotate([-90,0,0])
            usbCpanelMount();
            translate([0,depthOfBevel/2,overallHeight-.5])
            momentarySwitch(true);
        }
        translate([0,0,s+f/2])
        cube([310,310,f],center=true);
    }
}
// ********************** END modules for building project shell ********************************

// *********************** import models for battery base and connection tower ***********************
module baseBase(){
    difference(){
        translate(batPos)
        rotate([90,0,180])
        base();
        translate([0,depthOfEncloser/2,70])
        rotate([90,90,0])
        lm2596_adjV(true);
        translate([-20,batPos[1],batPos[2]])
        rotate([-90,0,0])
        usbCpanelMount();
        translate(rpiPos)
        rotate([0,0,90])
        pistackCut();
    }
}

module batPlug(){
    translate(batPos)
    rotate([90,0,180])
    scale([1,1,1])
    hull(){
        base();
    }
}

// translate(batPos)
// rotate([90,0,180])
// batTopPlug();
module batTopPlug(){
    translate([36.25,52,0])//[34.25,140,-11.75]
    rotate([0,180,180])
    tower();
}

//base();
module base(){
    // translate([5.5,28.5,0])
    // import("battery/Ryobi_18V_Batt_Connect_no_ears_V3.stl", convexity=3);
    ryobi_base();
}

module tower(){
    //import("battery/Ryobi_18V_Battery_Connector_Tower_V3.stl");
    ryobi_tower();
}
// *********************** END import models for battery base and connection tower ***********************

module renderedShell(){
    import("rpi_shell.stl",convexity=10);
}

// frontUsb();
module frontUsb(){
    //[USB_X,-depthOfEncloser/2+USB_Y,6+WallThickness+USB_Z]
    rotate([-90,0,0])
    union(){
        intersection(){
            linear_extrude(height=15)
            roundedRect(.5,17.5,11.5);
            translate([0,0,-38.78+9])
            rotate([90,0,0])
            cylinder(16,r=38.78,center=true,$fn=80);
        }
        translate([0,0,8])
        linear_extrude(height=5)
        roundedRect(.5,15.5,10);
        difference(){
            linear_extrude(height=30)
            roundedRect(.5,18.5,12.5);
            translate([0,0,-0.01])
            intersection(){
                linear_extrude(height=15)
                roundedRect(.5,19,13);
                translate([0,0,-38.78+9])
                rotate([90,0,0])
                cylinder(16,r=40.78,center=true,$fn=80);
            }
        }
        hull(){
            linear_extrude(height=.1)
            roundedRect(.5,17.5,11.5);
            translate([0,0,-7])
            linear_extrude(height=.1)
            roundedRect(.5,21.5,15.5);
        }
    }
}

module pistackCut(cut=true){
    translate([87/2-53.5,87/2+3,10.5+1])
    rotate([-90,0,0])
    rpiAudioExt(cut);

    RpiX703ups(cut=cut);
    translate([87/2,87/2-3.5*2-49,6.5])
    rotate([0,0,90])
    rpi4b(cut=cut);

    translate([87/2-26,87/2-3,9.5])
    rotate([90,0,180])
    hdmiToMicroAdapter(cut);
}

module customView(){
    fullShell();
    translate(rpiPos)
    rotate([0,0,90])
    pistackCut(false);
    translate(rj45Pos)
    rotate([90,-90,180])
    translate([-33,3.5,0])
    RPiRJ45BreakoutBoard();
    translate([3,-depthOfEncloser/2+depthOfBevel/2,frontHeight+depthOfBevel/2*sin(angle)])
    rotate([angle,0,0])
    translate([0,0,-4.6])
    7DP_CAPLCD(false,true);
    translate(pad2Pos)
    rotate([0,0,0])
    sshd();
    translate([0,depthOfEncloser/2,70])
    rotate([90,90,0])
    lm2596_adjV();
    translate(usbCharge1Pos) 
    rotate([180,0,180])
    drokUsbBuck();
    translate(usbCharge2Pos) 
    rotate([180,0,0])
    drokUsbBuck();
    translate(batPos) 
    rotate([90,0,180])
    batTopPlug();
    baseBase();
    translate([0,depthOfBevel/2,overallHeight-.5])
    momentarySwitch();
}

module fullShell(cutView=true){
    difference(){
        shell();
        translate(rpiPos)
        rotate([0,0,90])
        //pistackCut();
        import("pistackCut.stl",convexity=10);
        batPlug();
        translate(rj45Pos)
        rotate([90,-90,180])
        translate([-33,3.5,0])
        import("rj45cut.stl",convexity=10);
        translate(pad2Pos)
        //sshd(true);
        import("sshdCut.stl",convexity=10);
        translate(usbCharge1Pos)
        rotate([180,0,180])
        import("usbBuckCut.stl",convexity=10);
        translate(usbCharge2Pos)
        rotate([180,0,0])
        import("usbBuckCut.stl",convexity=10);
        if(cutView){
            translate([-widthOfEncloser/2,-depthOfEncloser/2,0])
            sphere(Cut_Radius);
        }
    }
}

module topPart(){
    intersection(){
        fullShell(false);
        topIntersection();
    }
}

module topBackPart(){
    intersection(){
        fullShell(false);
        topBackIntersection();
    }
    baseBase();
}

module bottomPart(){
    intersection(){
        fullShell(false);
        difference(){
            bottomIntersection();
            // mirror([1,1,0])
            // translate([-10,-20,-15])
            // cube([depthOfEncloser/2+5,widthOfEncloser/2+25,30]);
            // translate([22,30,-15])
            // cube([depthOfEncloser/2+5,widthOfEncloser/2+25,30]);
        }
    }
}

module bottomIntersection(){
    translate([0,Battery_Position_Y*1.5,6])
    cube([widthOfEncloser+5,depthOfEncloser+5+Battery_Position_Y*3,12],center=true);
    translate([0,Front_Backset-0.2,11.99])
    linear_extrude(height=2)
    roundedRect(radiusOfCorners-1.75,widthOfEncloser-3,depthOfEncloser-1.5);//inset
    translate([-widthOfEncloser/2-3,Pad1_Y+10,Pad1_Z-3])
    rotate([0,90,0])
    linear_extrude(height=20)
    roundedRect(10,30,70);
}

module topIntersection(){
    difference(){
        translate([0,Battery_Position_Y*1.5,overallHeight/2+12])
        cube([widthOfEncloser+5,depthOfEncloser+5+Battery_Position_Y*3,overallHeight],center=true);// top of encloser
        translate([-widthOfEncloser/2-3,Pad1_Y+10,Pad1_Z-3])
        rotate([0,90,0])
        linear_extrude(height=20)
        roundedRect(10,30,70);// notch for hdmi/video/audio interface
        translate([0,Front_Backset-0.2,11.99])
        linear_extrude(height=2)
        roundedRect(radiusOfCorners-1.5,widthOfEncloser-3,depthOfEncloser-1.5);//top-bottom inset
        translate([-(widthOfEncloser+10)/2,batPos[1]-Battery_Position_Y-9,0])
        cube([widthOfEncloser+10,23+Battery_Position_Y,overallHeight+5]);// back removal
        translate([0,batPos[1]-Battery_Position_Y-9,overallHeight/2])
        rotate([90,0,0])
        linear_extrude(height=2)
        roundedRect(8,widthOfEncloser-4,overallHeight-4);// back inset
        frontUsbFill();
    }
}

//color("Pink",0.5) topBackIntersection();
module topBackIntersection(){
    difference(){
        translate([0,Battery_Position_Y*1.5,overallHeight/2+12])
        cube([widthOfEncloser+5,depthOfEncloser+5+Battery_Position_Y*3,overallHeight],center=true);
        translate([-widthOfEncloser/2-3,Pad1_Y+10,Pad1_Z-3])
        rotate([0,90,0])
        linear_extrude(height=20)
        roundedRect(10,30,70);
        translate([0,Front_Backset-0.2,11.99])
        linear_extrude(height=2)
        roundedRect(radiusOfCorners-1.5,widthOfEncloser-3,depthOfEncloser-1.5);//inset
        difference(){
            translate([-(widthOfEncloser+10)/2,batPos[1]-Battery_Position_Y-depthOfEncloser-9,0])
            cube([widthOfEncloser+10,depthOfEncloser,overallHeight+5]);

            translate([0,batPos[1]-Battery_Position_Y-9,overallHeight/2])
            rotate([90,0,0])
            linear_extrude(height=2)
            roundedRect(8,widthOfEncloser-4,overallHeight-4);
        }
    }
}

if(Views == 0){
    exampleView();
}else if(Views == 1){
    customView();
}else if(Views == 2){
    topPart();
}else if(Views == 3){
    bottomPart();
}else{
    // topIntersection();
    // bottomIntersection();
    //roundedVent();
    //pistackCut();
    //topBackPart();
    //2020alumExtrude(x=20,y=20);
    //insertSet(s=3,r=8);
    // difference(){
    //     cube([70,60,20]);
    //     translate([6,6,-1])
    //    RPiRJ45BreakoutBoard(true);
    // }
    //momentarySwitch();
    difference(){
        fan(mount=true);
        fan(cut=true);
    }
    
    
    // translate([0,0,-50])
    // difference(){
    //     surface(file="raspberry-pi-logo.png",center=true);
    //     translate([-40,-40,52])
    //     cube([80,80,100]);
    //     translate([-40,-40,-1])
    //     cube([80,80,51]);
    // }
    
    //import("rpi_logo_grill.stl",convexity=10);
}
//baseBase();
// translate(pad2Pos)
// rotate([0,0,0])
// sshd(cut=true);
// translate(pad2Pos)
// rotate([0,0,0])
// sshd();
// translate(rpiPos)
// rotate([0,0,90])
// pistackCut(false);
//intersection(){
    //basicShape();
//     translate([50,40,60])
//     cube([210,80,90]);
// }
//shell();
// module basicShape(){
//     difference(){
//         union(){
//         //shell();//12min for front :: 21 for hdmi/audio-video :: 
//         renderedShell();
//         baseBase();
//         }

//     }
// }
 //for(i=[0:1:USB_Num-1]){
            //offs = [17.5+15,0,0];
            // translate(frontUsbPos)
            // frontUsb();
            // translate([frontUsbPos[0]-32.5,frontUsbPos[1],frontUsbPos[2]])
            // frontUsb();
        //}

    // //     translate([17.5,19,50.6])
    // //     rotate([atan2(overallHeight-frontHeight,depthOfBevel),0,0])
    // //     translate([171/2,38,0])
    // //     rotate([0,0,180])
    // //     7DP_CAPLCD(true);
        

// // translate([59+32,142,10])
// // rotate([0,0,180])
// // union(){
// //     board_raspberrypi_4_model_b();
    
// // }
    

// translate([0,0,-1.5-7.5-4])
// //rotate([atan2(overallHeight-frontHeight,depthOfBevel),0,0])
// screenMount();
// module screenMount(){
//     difference(){
//         cube([189,124,3],center=true);
//         cube([146,79,4],center=true);
//         translate([-156/2,89/2,0]) cylinder(4,r=1.65,$fn=15,center=true);
//         translate([-156/2,-89/2,0]) cylinder(4,r=1.65,$fn=15,center=true);
//         translate([156/2,89/2,0]) cylinder(4,r=1.65,$fn=15,center=true);
//         translate([+156/2,-89/2,0]) cylinder(4,r=1.65,$fn=15,center=true);
//         translate([-70,60,0]) cylinder(4,r=1.65,$fn=15,center=true);
//         translate([-70,-60,0]) cylinder(4,r=1.65,$fn=15,center=true);
//         translate([70,-60,0]) cylinder(4,r=1.65,$fn=15,center=true);
//         translate([70,60,0]) cylinder(4,r=1.65,$fn=15,center=true);
//     }
// }
//baseBase();

// translate([widthOfEncloser-radiusOfCorners-57/2,depthOfEncloser,overallHeight/2])
// color("GreenYellow",0.6){
//     difference(){
//         cube([57,50,37],center=true);
//         cube([58,51,3],center=true);
//     }
// }
// scale([1,1,1])
// color("Pink",0.5)
// base();
// scale([1-WallThickness/67,1-WallThickness/37,1-WallThickness/11])
// color("Green",0.8)
// base();
// translate([0,-depthOfEncloser/2+7,frontHeight/4+4])










//screenClearance();
// module screenClearance(cr=radiusOfCorners,height=overallHeight,front=frontHeight,mid=depthOfBevel){
//     translate([0,cr-4,35])
//     rotate([atan2(height-front,mid),0,0])
//     translate([cr,0,-20])
//     cube([180,115,20]);
// }
