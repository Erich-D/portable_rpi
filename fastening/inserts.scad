

module threadInsert(size=2.5,height=6){
    r1 = size*1.44/2;
    r2 = (size+.65)/2;
    union(){
        cylinder(.4,r=r1,$fn=20);
        translate([0,0,.4])
        cylinder(2,r1,r2,$fn=20);
        cylinder(height,r=r2,$fn=20);
    }
}

module insertSet(s=3,r=12){
    union(){
        threadInsert(s);
        translate([0,0,-r])
        cylinder(r+1,r=s/2+.2,$fn=30);
        translate([0,0,-r-3])
        cylinder(8,r=s-.2,$fn=30);
    }
}