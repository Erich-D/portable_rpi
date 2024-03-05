module potentiometer(){
    translate([-9.5/2,-4/2,0])
    color("DodgerBlue",0.9) cube([9.5,4,10]);
    translate([-9.5/2+1.5,4/2-1.5,9.5])
    color("Gold") difference(){
        cylinder(2,r=2.25/2);
        translate([-0.25,-1.5,1.25])
        cube([0.5,3,2]);
    }
    for(i=[0:1:2]){
        translate([-2.56+i*2.56,0,-2]) color("Silver") cylinder(6,r=.25);
    }
}