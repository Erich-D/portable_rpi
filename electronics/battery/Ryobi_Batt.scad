module ryobi_base(){
    translate([5.5,28.5,0])
    import("Ryobi_18V_Batt_Connect_no_ears_V3.stl", convexity=3);
}

module ryobi_tower(){
    import("Ryobi_18V_Battery_Connector_Tower_V3.stl");
}