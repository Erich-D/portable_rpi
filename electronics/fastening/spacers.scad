
module ring(or=10,ir=5,h=2){
  difference(){
    cylinder(h,r=or,center=true);
    cylinder(h+1,r=ir,center=true);
  }
}