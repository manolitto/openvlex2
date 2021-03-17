/*
 * OpenVLex Bases v2.0.4
 *
 * Credits: OpenForge 2.0
 * Original Work by Devon Jones
 * https://www.patreon.com/masterworktools
 */

/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6,7,8]
y = 2; //[1,2,3,4,5,6,7,8]

/* [Square Basis] */
// What is the size in mm of a square?
square_basis = "inch"; // [25mm:Dwarven Forge/Hirstarts, inch:OpenLOCK/Dragonlock/Dungeonworks, wyloch:Wyloch]

/* [Lock] */
// Dragonlock - connector between squares, pips on either side for stacking
// InfinityLock - connector between squares and in the middle of squares
// OpenLOCK - connector between squares
// OpenLOCK Triplex - connector between squares and in the middle of squares
lock = "triplex";// [openlock,triplex,infinitylock,dragonlock,none]

/* [Magnets] */
// Size of hole for magnet.  6 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 6.0;

/* [Priority] */
// Do you want lock or magnets to win when the two conflict
priority = "magnets"; // [lock,magnets]

/* [Shape] */
// What type of tile is this for
shape = "square"; // [square,diagonal,curved,alcove]

/* [Curved Options] */
// Options for curved, will be ignored if the tile type is not curved
// curvedconcave - concaved base instead of convex
// curvedlarge - 6x6 and 8x8 are made of 3 tiles, a, b & c
// curvedsquare - When you want a curved wall, with floors on both sides, but a square won't work
curvedconcave = "false"; // [true,false]
curvedlarge = undef; // [undef,a,b,c,d,e,f]
curvedsquare = "false"; // [true,false]

/* [Notch Options] */
// Removes a square from the tile of notch_x by notch_y
notch = "false"; // [true,false]
notch_x = 2; // [1,2,3]
notch_y = 2; // [1,2,3]

/* [Dynamic Floors] */
// Add support for dynamic floors
dynamic_floors = "false";  // [true,false]

/* [Topless] */
// remove top of openlock bays
topless = "false"; // [true, false]

/* [External] */
// Set to true if you want a side to be exteral, that side will be extended by half and have connection bays removed

external_north = "false"; // [true, false]
external_south = "false"; // [true, false]
external_east = "false"; // [true, false]
external_west = "false"; // [true, false]

/* [OpenVLex] */
// OpenVLex Render Mode?
openvlex = "complete"; // [none, complete, magnetic_upper, magnetic_lower]

/* [Additional Supports] */
// Add additional supports? (Recommended for OpenVLex)
additional_supports = "none"; // [none, two, three]


/*
 * Dragonlock connection bay
 */
module dragonlock_nub(square_basis) {
    translate([0,-square_basis/2,0]) {
        hull() {
            translate([3.92,16.62,-1]) cube([4.85,4.85,1]);
            translate([3.92+.74,16.62+.74,0]) cube([4.85-.74*2,4.85-.74*2,1.03]);
        }
        translate([3.92+.74,16.62+.74,1]) cube([4.85-.74*2,4.85-.74*2,4.21]);
    }
}
module dragonlock_positive() {
    translate([0,-7.8418,0.4]) cube([2,7.8418*2,5.6]);
    //translate([3.92-1,16.62-1,0.4]) cube([6.85,6.85,5.6]);
    //translate([3.92-1,-16.62-1-4.85,0.4]) cube([6.85,6.85,5.6]);
}

module dragonlock_negative(priority="lock") {
    difference() {
        translate([-1,-6.8418,1.3695]) cube([5.1,6.8418*2,3.225]);
    }
    difference() {
        hull() {
            if(priority == "lock") {
                translate([3.17,-12.7,-1]) cube([8.512,12.71*2,6]);
                translate([3.145,-12.7,-1]) cube([8.512,12.71*2,6.206]);
            } else {
                translate([3.17,-9,-1]) cube([8.512,9*2,6]);
                translate([3.145,-9,-1]) cube([8.512,9*2,6.206]);
            }
        }
        translate([10.29,-12.8,5.206]) rotate([0,45,0]) cube([8.512,12.8*2,6.206]);
        translate([3,-3.9095,-1.1]) cube([10,3.9095*2,2.4695]);
        translate([3,-4.7685,-1.1]) rotate([0,0,39.15]) cube([5,5,2.4695]);
        mirror([0,1,0]) translate([3,-4.7685,-1.1]) rotate([0,0,39.15]) cube([5,5,2.4695]);
        translate([7,-2.12,-1]) cube([5,2.12*2,10]);
        translate([8.069,0,-1]) cylinder(10,2.815,2.811,$fn=50); 
        translate([8.069,0,-1.1]) cylinder(2.4695,4.62,4.62,$fn=50);
    }
}

module dragonlock_interior(north=true,south=true,east=true,west=true,center=true) {
    module edge() {
        difference() {
            hull() {
                translate([3.17,-12.67,-1]) cube([8.512,12.67*2,6]);
                translate([3.145,-12.7,-1]) cube([8.512,12.67*2,6.206]);
            }
            translate([10.29,-12.8,5.206]) rotate([0,45,0]) cube([8.512,12.8*2,6.206]);
        }
    }
    
    translate([0,25.4,0]) {
        if(center) {
            difference() {
                translate([12.7,-12.7,-1]) cube([50.8-12.7*2,50.8-12.7*2,6.206]);
                translate([25.4,0,0]) rotate([0,0,45]) translate([-.75,-30,-2]) cube([1.5,60,20]);
                translate([25.4,0,0]) rotate([0,0,-45]) translate([-.75,-30,-2]) cube([1.5,60,20]);
            }
        }

        if (!west) {
            edge();
        }
        if (!south) {
            translate([25.4,-25.4,0]) rotate([0,0,90]) edge();
        }
        if (!east) {
            translate([50.8,0,0]) rotate([0,0,180]) edge();
        }
        if (!north) {
            translate([25.4,25.4,0]) rotate([0,0,270]) edge();
        }
        dragonlock_nub(square_basis);
        translate([25.4,-25.4,0]) rotate([0,0,90]) dragonlock_nub(square_basis);
        translate([50.8,0,0]) rotate([0,0,180]) dragonlock_nub(square_basis);
        translate([25.4,25.4,0]) rotate([0,0,270]) dragonlock_nub(square_basis);
    }
}

/*
 * Infinity Lock connection bay
 */
module infinitylock_positive() {
    translate([0,-6.6,0.4]) cube([2,6.6*2,5.6]); 
}

module infinitylock_negative() {
    translate([-1,-5.6,1.4]) cube([2.6,5.6*2,4.2]);

    hull() {
        translate([0,-3.83,1.4]) cube([1.6,3.83*2,4.2]);
        translate([0,-3.36,1.4]) cube([2.15,3.36*2,4.2]);
    }
    translate([0,-3.36,1.4]) cube([2.8,3.36*2,4.2]);
    hull() {
        translate([2.7,-3.36,1.4]) cube([2.7,3.36*2,4.2]);
        translate([3.84,-3.83,1.4]) cube([1,3.83*2,4.2]);
    }
    translate([4.8,-3.83,-1]) cube([3.44,3.83*2,6.6]);
}

/*
 * Openlock connection bay
 */
module openlock_chamber(buffer=0) {
    add = topless == "true" ? 10 : 0;
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,4.2+add]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,4.2+add]);
        translate([3+0.01,-5,1.4]) cube([2,5*2,4.2+add]);
    }
    hull() {
        translate([5,-5,1.4]) cube([1,5*2,4.2+add]);
        translate([6,-5,1.4]) cube([1,5*2,4.7]);
    }
    translate([6,-6.4,-1]) cube([4.7,6.4*2,7.1]);
}

module openlock_supports() {
    module support() {
        translate([-1.1,2.05,1.2]) cube([3.1,1,4.6]);
        hull() {
            translate([-1.1,2.05,1.4]) cube([3.1,1,2.1]);
            translate([-1.1,2.05-.2,1.9]) cube([3.1,1.4,1.1]);
        }
        hull() {
            translate([-1.1,2.05,3.5]) cube([3.1,1,2.1]);
            translate([-1.1,2.05-.2,4.0]) cube([3.1,1.4,1.1]);
        }
    }
    if (topless != "true") {
        support();
        mirror([0,1,0]) support();
    }
}

module openlock_positive() {
    translate([0,-8,0.4]) cube([2,16,5.6]); 
}

module openlock_negative(supports=true) {
    difference() {
        openlock_chamber(1);
        if(supports) {
            openlock_supports();
        }
    }
}

/*
 * Magnets
 */
module magnet_positive(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,0]) cylinder(.41,magnet_hole/2+1-.25,magnet_hole/2+1, $fn=100);
        translate([magnet_hole/2+1,0,0.4]) cylinder(5.6,magnet_hole/2+1,magnet_hole/2+1, $fn=100);
    }
}

module magnet_negative(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        if (openvlex == "none") {
            translate([magnet_hole/2+1,0,1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);
            translate([magnet_hole/2+1,0,-2]) cylinder(10,.9,.9,$fn=50);
        } else {
            // handled later
        }
    }
}

/*
 * Connector Layout
 */
module center_connector_positive(edge, ordinal, magnet_hole=5.5, lock, priority="lock") {
    if (edge == 1) {
        if (priority == "lock" && (lock == "openlock" || lock == "triplex")) {
            openlock_positive();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_positive();
        } else {
            magnet_positive(magnet_hole);
        }
    } else {
        if (priority == "lock" && lock == "triplex") {
            openlock_positive();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_positive();
        } else {
            magnet_positive(magnet_hole);
        }
    }
}

module center_connector_negative(edge, ordinal, magnet_hole=5.5, lock, priority="lock") {
    if (edge == 1) {
        if (priority == "lock" && (lock == "openlock" || lock == "triplex")) {
            openlock_negative();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_negative();
        } else if (priority == "lock" && lock == "dragonlock") {
            dragonlock_negative(priority="magnets");
        } else {
            magnet_negative(magnet_hole);
        }
    } else {
        if (priority == "lock" && lock == "triplex") {
            openlock_negative();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_negative();
        } else {
            magnet_negative(magnet_hole);
        }
    }
}

module joint_connector_positive(edge, ordinal, magnet_hole=5.5, lock, priority="lock") {
    if(lock == "openlock" || lock == "triplex") {
        openlock_positive();
    } else if (lock == "infinitylock") {
        infinitylock_positive();
    }
}

module joint_connector_negative(edge, ordinal, magnet_hole=5.5, lock, priority="lock") {
    if(lock == "openlock" || lock == "triplex") {
        openlock_negative();
    } else if (lock == "infinitylock") {
        infinitylock_negative();
    } else if (lock == "dragonlock") {
        dragonlock_negative(priority);
    }
}

/*
 * Dynamic Floor Bases
 */
module df_positive_square(x,y,square_basis, edge_width) {
    cube([square_basis/2+4.75,square_basis/2+4.75,6]);
    translate([square_basis*x-square_basis/2-4.75,0,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
    translate([0,square_basis*y-square_basis/2-4.75,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
    translate([square_basis*x-square_basis/2-4.75,square_basis*y-square_basis/2-4.75,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
    translate([square_basis/2+3.75,square_basis/2+3.75,0]) cube([square_basis*x-(square_basis/2+3.75)*2,square_basis*y-(square_basis/2+3.75)*2,6]);
    if (x > 2) {
        for ( i = [2 : x-1] ) {
            translate([(i-.5)*square_basis-9.5/2,0,0]) cube([9.5,square_basis/2+4.75,6]);
            translate([(i-.5)*square_basis-9.5/2,square_basis*y-square_basis/2-4.75,0]) cube([9.5,square_basis/2+4.75,6]);
        }
    }
    if (y > 2) {
        for ( i = [2 : y-1] ) {
            translate([0,(i-.5)*square_basis-9.5/2,0]) cube([square_basis/2+4.75,9.5,6]);
            translate([square_basis*x-square_basis/2-4.75,(i-.5)*square_basis-9.5/2,0]) cube([square_basis/2+4.75,9.5,6]);
        }
    }
}

module df_positive(x,y,square_basis, shape, edge_width) {
    if(shape == "square") {
        df_positive_square(x,y,square_basis,edge_width);
    } else if (shape == "curved") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.a") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.b") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.c") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "diagonal") {
        echo("Diagonal does not support Dynamic Floors");
    }
}

module df_negative_square(x,y,square_basis, edge_width) {
    for ( i = [0 : x-1] ) {
        for ( j = [0 : y-1] ) {
            translate([i*square_basis, j*square_basis,0]) translate([square_basis/2,square_basis/2,6-2.1]) cylinder(2.5,5.5/2,5.5/2, $fn=100);
        }
    }
}

module df_negative(x,y,square_basis, shape, edge_width) {
    if(shape == "square") {
        df_negative_square(x,y,square_basis,edge_width);
    } else if (shape == "curved") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.a") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.b") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.c") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "diagonal") {
        echo("Diagonal does not support Dynamic Floors");
    }
}

/*
 * Connector Positive
 */
module connector_positive(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) {
    if(shape == "square") {
        connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority);
    } else if (shape == "curved") {
        if (x == 4 && y == 4 && curvedlarge) {
            connector_positive_curved_large_4(square_basis,edge_width);
        } else if(x == 6 && y == 6) {
            connector_positive_curved_large_6(square_basis,edge_width);
        } else if (x == 8 && y == 8) {
            connector_positive_curved_large_8(square_basis,edge_width);
        } else if (x > 4 || y > 4) {
            echo("Curved does not support ", x, "x", y);
        } else {
            connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
        }
    } else if (shape == "diagonal") {
        connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else if (shape == "alcove") {
        connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,west=false,east=false,north=false);
    }
}

module connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=true,south=true,east=true,west=true) {
    if(notch == "true") {
        connector_positive_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=north,south=false,east=east,west=false);
        if(south) {
            translate([square_basis*notch_x,0,0]) connector_positive_square_impl(x-notch_x,y-notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=true,east=false,west=false);
            translate([0,square_basis*notch_y,0]) connector_positive_square_impl(notch_x,notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=true,east=false,west=false);
        }
        if(west) {
            translate([square_basis*notch_x,0,0]) connector_positive_square_impl(notch_x,notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=false,east=false,west=true);
            translate([0,square_basis*notch_y,0]) connector_positive_square_impl(x-notch_x,y-notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=false,east=false,west=true);
        }
    } else {
        connector_positive_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north,south,east,west);
    }
}

module connector_positive_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=true,south=true,east=true,west=true) {
    for ( i = [0 : y-1] ) {
        if(west && !ext_west) {
            translate([0,square_basis*(i+1)-square_basis/2,0]) center_connector_positive(y,i,magnet_hole,lock,priority);
        }
        if(east && !ext_east) {
            translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) center_connector_positive(y,i,magnet_hole,lock,priority);
        }
    }
    if (y > 1) {
        for ( i = [1 : y-1] ) {
            if(west && !ext_west) {
                translate([0,square_basis*i,0]) joint_connector_positive(y,i,magnet_hole,lock,priority);
            }
            if(east && !ext_east) {
                translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) joint_connector_positive(y,i,magnet_hole,lock,priority);
            }
        }
    }
    for ( i = [0 : x-1] ) {
        if(south && !ext_south) {
            translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_positive(x,i,magnet_hole,lock,priority);
        }
        if(north && !ext_north) {
            translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) center_connector_positive(x,i,magnet_hole,lock,priority);
        }
    }
    if (x > 1) {
        for ( i = [1 : x-1] ) {
            if(south && !ext_south) {
                translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_positive(y,i,magnet_hole,lock,priority);
            }
            if(north && !ext_north) {
                translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) joint_connector_positive(y,i,magnet_hole,lock,priority);
            }
        }
    }
}

module connector_positive_curved_large_4(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_positive_large_4_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        translate([-4*square_basis,0,0]) connector_positive_square(2,3,square_basis,edge_width,magnet_hole,lock,priority,west=false,north=false);
    } else if(curvedlarge == "c") {
        translate([2*square_basis,0,0]) connector_positive_square(2,3,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else {
        echo("Curved 6x6 only supports a, b & c");
    }
}

module connector_positive_curved_large_6(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_positive_large_6_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        connector_positive_large_6_b(x,y,square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            connector_positive_large_6_a(square_basis,edge_width,magnet_hole,lock,priority);
        }
    } else {
        echo("Curved 6x6 only supports a, b & c");
    }
}

module connector_positive_curved_large_8(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_positive_large_8_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        connector_positive_large_8_b(x,y,square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            connector_positive_large_8_a(square_basis,edge_width,magnet_hole,lock,priority);
        }
    } else {
        echo("Curved 8x8 only supports a, b & c");
    }
}

module connector_positive_large_4_a(square_basis,edge_width,magnet_hole,lock,priority) {
    if (lock != "dragonlock" || magnet_hole > 0) {
        intersection() {
            translate([-2*square_basis,2*square_basis,0]) connector_positive_square(4,2,square_basis,edge_width,magnet_hole,lock,priority,north=false);
            translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
        }
    }
}

module connector_positive_large_6_a(square_basis,edge_width,magnet_hole,lock,priority) {
    if(curvedconcave == "true") {
        translate([0,square_basis*5,0]) connector_positive_square(3,1,square_basis,edge_width,magnet_hole,lock,priority,west=false,south=false);
    } else {
        translate([0,square_basis*5,0]) connector_positive_square(2,1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
        translate([square_basis*2,square_basis*3,0]) connector_positive_square(1,2,square_basis,edge_width,magnet_hole,lock,priority,north=false);
    }
}

module connector_positive_large_6_b(x,y,square_basis,edge_width) {
    if(curvedconcave == "true") {
        translate([square_basis*5, square_basis*3,0]) connector_positive_square(1,3,square_basis,edge_width,magnet_hole,lock,priority,west=false,north=false);
        translate([square_basis*3, square_basis*5,0]) connector_positive_square(3,1,square_basis,edge_width,magnet_hole,lock,priority,east=false,south=false);
    } else {
        translate([square_basis*6/2, square_basis*6/2,0]) connector_positive_square(6/2-1,6/2-1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    }
}

module connector_positive_large_8_a(square_basis,edge_width,magnet_hole,lock,priority) {
    if(curvedconcave == "true") {
        difference() {
            if(magnet_hole == 0 && lock == "dragonlock") {
            } else {
                translate([0,square_basis*6,0]) connector_positive_square(4,2,square_basis,edge_width,magnet_hole,lock,priority,west=false,south=false);
                translate([0,square_basis*6,0]) translate([square_basis*4,square_basis*(1)-square_basis/2,0]) rotate([0,0,180]) center_connector_positive(y,x,magnet_hole,lock,priority);
                translate([0,0,-2]) cylinder(10,x*square_basis-(10.2*square_basis/25)+edge_width+1,x*square_basis-(10.2*square_basis/25)+edge_width+1,$fn=200);
            }
        }
    } else {
        translate([0,square_basis*6,0]) connector_positive_square(4,2,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
        translate([0,square_basis*6,0]) translate([square_basis*4,square_basis*(1)-square_basis/2,0]) rotate([0,0,180]) center_connector_positive(y,x,magnet_hole,lock,priority);
    }
}


module connector_positive_large_8_b(x,y,square_basis,edge_width) {
    if(curvedconcave == "true") {
        translate([square_basis*7, square_basis*4,0]) connector_positive_square(1,4,square_basis,edge_width,magnet_hole,lock,priority,west=false,north=false);
        translate([square_basis*4, square_basis*7,0]) connector_positive_square(4,1,square_basis,edge_width,magnet_hole,lock,priority,east=false,south=false);
    } else {
        translate([square_basis*8/2, square_basis*8/2,0]) connector_positive_square(8/2-1,8/2-1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    }
}

/*
 * Connector Negative
 */
module connector_negative(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) {
    if(shape == "square") {
        connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority);
        
    } else if (shape == "curved") {
        if (x == 4 && y == 4 && curvedlarge) {
            connector_negative_curved_large_4(square_basis,edge_width);
        } else if(x == 6 && y == 6) {
            connector_negative_curved_large_6(square_basis,edge_width);
        } else if (x == 8 && y == 8) {
            connector_negative_curved_large_8(square_basis,edge_width);
        } else if (x > 4 || y > 4) {
            echo("Curved does not support ", x, "x", y);
        } else {
            difference() {
                connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
                if(curvedconcave == "true") {
                        translate([x*square_basis,y*square_basis,-1]) scale([((x*square_basis)-edge_width-2)/square_basis,((y*square_basis)-edge_width-2)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                }
            }
        }
    } else if (shape == "diagonal") {
        hyp = sqrt(square_basis*x*square_basis*x+square_basis*y*square_basis*y);
        difference() {
            connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
            translate([x*square_basis+square_basis*.25,0,0]) rotate([0,0,atan(x/y)-90]) mirror([1,0,0]) cube([hyp* 1.5,hyp*1.5,6]);
        }
    } else if (shape == "alcove") {
        connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,west=false,east=false,north=false);
    }
}

module connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=true,south=true,east=true,west=true) {
    if(notch == "true") {
        connector_negative_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=north,south=false,east=east,west=false);
        if(south) {
            translate([square_basis*notch_x,0,0]) connector_negative_square_impl(x-notch_x,y-notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=true,east=false,west=false);
            translate([0,square_basis*notch_y,0]) connector_negative_square_impl(notch_x,notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=true,east=false,west=false);
        }
        if(west) {
            translate([square_basis*notch_x,0,0]) connector_negative_square_impl(notch_x,notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=false,east=false,west=true);
            translate([0,square_basis*notch_y,0]) connector_negative_square_impl(x-notch_x,y-notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=false,east=false,west=true);
        }
    } else {
        connector_negative_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north,south,east,west);
    }
}

module connector_negative_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=true,south=true,east=true,west=true) {
    for ( i = [0 : y-1] ) {
        if(west && !ext_west) {
            translate([0,square_basis*(i+1)-square_basis/2,0]) center_connector_negative(y,i,magnet_hole,lock,priority);
        }
        if(east && !ext_east) {
            translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) center_connector_negative(y,i,magnet_hole,lock,priority);
        }
    }
    if (y > 1) {
        for ( i = [1 : y-1] ) {
            if(west && !ext_west) {
                translate([0,square_basis*i,0]) joint_connector_negative(y,i,magnet_hole,lock,priority);
            }
            if(east && !ext_east) {
                translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) joint_connector_negative(y,i,magnet_hole,lock,priority);
            }
        }
    }
    for ( i = [0 : x-1] ) {
        if(south && !ext_south) {
            translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_negative(x,i,magnet_hole,lock,priority);
        }
        if(north && !ext_north) {
            translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) center_connector_negative(x,i,magnet_hole,lock,priority);
        }
    }
    if (x > 1) {
        for ( i = [1 : x-1] ) {
            if(south && !ext_south) {
                translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_negative(y,i,magnet_hole,lock,priority);
            }
            if(north && !ext_north) {
                translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) joint_connector_negative(y,i,magnet_hole,lock,priority);
            }
        }
    }
}

module connector_negative_curved_large_4(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_negative_large_4_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        translate([-4*square_basis,0,0]) connector_negative_square(2,3,square_basis,edge_width,magnet_hole,lock,priority,west=false,north=false);
    } else if(curvedlarge == "c") {
        translate([2*square_basis,0,0]) connector_negative_square(2,3,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else {
        echo("Curved 6x6 only supports a, b & c");
    }
}

module connector_negative_curved_large_6(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_negative_large_6_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        connector_negative_large_6_b(x,y,square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            connector_negative_large_6_a(square_basis,edge_width,magnet_hole,lock,priority);
        }
    } else {
        echo("Curved 6x6 only supports a, b & c");
    }
}

module connector_negative_curved_large_8(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_negative_large_8_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        connector_negative_large_8_b(x,y,square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            connector_negative_large_8_a(square_basis,edge_width,magnet_hole,lock,priority);
        }
    } else {
        echo("Curved 8x8 only supports a, b & c");
    }
}

module connector_negative_large_4_a(square_basis,edge_width,magnet_hole,lock,priority) {
    intersection() {
        translate([-2*square_basis,2*square_basis,0]) connector_negative_square(4,2,square_basis,edge_width,magnet_hole,lock,priority,north=false);
        difference() {
            translate([0,0,.4]) scale([x-.1,y-.1,1]) cylinder(5.7,square_basis,square_basis,$fn=200);
            translate([-x*square_basis/2,(y-.65)*square_basis,-1]) cube([x*square_basis,y*square_basis,7]);
        }
    }
}

module connector_negative_large_6_a(square_basis,edge_width,magnet_hole,lock,priority) {
    if (curvedconcave == "true") {
        translate([square_basis*1,square_basis*5,0])
connector_negative_square(2,1,square_basis,edge_width,magnet_hole,lock,priority,west=false,south=false);
        if(lock == "openlock" || (lock == "infinitylock" && priority == "magnets")) {
            translate([0,square_basis*5,0])
connector_negative_square(1,1,square_basis,edge_width,magnet_hole,lock,"magnets",west=false,east=false,south=false);
        }
    } else {
        translate([0,square_basis*5,0]) connector_negative_square(2,1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
        translate([square_basis*2,square_basis*3,0]) connector_negative_square(1,2,square_basis,edge_width,magnet_hole,lock,priority,north=false);
    }
}

module connector_negative_large_6_b(x,y,square_basis,edge_width) {
    if(curvedconcave == "true") {
        difference() {
            union() {
                translate([square_basis*8/2, square_basis*6/2,0]) connector_negative_square(2,3,square_basis,edge_width,magnet_hole,lock,priority,west=false,north=false);
                translate([square_basis*6/2, square_basis*8/2,0]) connector_negative_square(3,2,square_basis,edge_width,magnet_hole,lock,priority,east=false,south=false);
            }
            translate([-2,-2,-1]) cube([square_basis*4.75+2, square_basis*4.75+2, 8]);
        }
    } else {
        translate([square_basis*6/2, square_basis*6/2,0]) connector_negative_square(6/2-1,6/2-1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    }
}

module connector_negative_large_8_a(square_basis,edge_width,magnet_hole,lock,priority) {
    if (curvedconcave == "true") {
        difference() {
            union() {
                if(lock == "triplex" || (lock == "infinitylock" && priority == "lock")) {
                    translate([square_basis*1,square_basis*7,0]) connector_negative_square(3,1,square_basis,edge_width,magnet_hole,lock,priority,west=false,south=false);
                    translate([square_basis*3,square_basis*6.5,0]) connector_negative_square(1,1,square_basis,edge_width,magnet_hole,lock,priority,west=false,south=false,north=false);
                } else {
                    translate([square_basis*1,square_basis*6,0]) connector_negative_square(3,2,square_basis,edge_width,magnet_hole,lock,priority,west=false,south=false);
                    translate([0,square_basis*6,0]) translate([square_basis*4,square_basis*(1)-square_basis/2,0]) rotate([0,0,180]) center_connector_negative(y,x,magnet_hole,lock,priority);
                    if(lock == "openlock" || (lock == "infinitylock" && priority == "magnets")) {
                        translate([square_basis*0,square_basis*7,0]) connector_negative_square(1,1,square_basis,edge_width,magnet_hole,lock="none",priority,west=false,east=false,south=false);
                    }
                }
            }
            translate([0,0,-2]) cylinder(10,x*square_basis-(10.2*square_basis/25)+edge_width-5,x*square_basis-(10.2*square_basis/25)+edge_width-5,$fn=200);
        }
    } else {
        translate([0,square_basis*6,0]) connector_negative_square(4,2,square_basis,edge_width,magnet_hole,lock,priority,west=true, east=false,south=true, north=false);
        translate([0,square_basis*6,0]) connector_negative_square(4,1,square_basis,edge_width,magnet_hole,lock,priority,east=true, west=false,south=false,north=false);
    }
}

module connector_negative_large_8_b(x,y,square_basis,edge_width) {
    if(curvedconcave == "true") {
        difference() {
            union() {
                translate([square_basis*6, square_basis*4,0]) connector_negative_square(2,4,square_basis,edge_width,magnet_hole,lock,priority,west=false,north=false);
                translate([square_basis*4, square_basis*6,0]) connector_negative_square(4,2,square_basis,edge_width,magnet_hole,lock,priority,east=false,south=false);
            }
            translate([-2,-2,-1]) cube([square_basis*6.75+2, square_basis*6.75+2, 8]);
        }
    } else {
        if(lock == "triplex" || lock == "infinitylock" && magnet_hole == 0) {
            translate([square_basis*8/2, square_basis*8/2,0]) connector_negative_square(2,2,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
            translate([square_basis*5.5, square_basis*8/2,0]) connector_negative_square(1,1,square_basis,edge_width,magnet_hole,lock,priority,east=false,west=false,north=false);
            translate([square_basis*8/2, square_basis*5.5,0]) connector_negative_square(1,1,square_basis,edge_width,magnet_hole,lock,priority,east=false,south=false,north=false);
        } else {
            translate([square_basis*8/2, square_basis*8/2,0]) connector_negative_square(3,3,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
        }
    }
}



/*
 * Plain base exterior
 */
module plain_base(x,y,square_basis,lock,shape,edge_width) {
    if(shape == "square") {
        plain_square(x,y,square_basis,lock,edge_width);
    } else if (shape == "curved") {
        if (x == 4 && y == 4 && curvedlarge) {
            plain_curved_large_4(square_basis,edge_width);
        } else if(x == 6 && y == 6) {
            plain_curved_large_6(square_basis,edge_width);
        } else if (x == 8 && y == 8) {
            plain_curved_large_8(square_basis,edge_width);
        } else if (x > 4 || y > 4) {
            echo("Curved does not support ", x, "x", y);
        } else {
            if (curvedconcave == "true") {
                plain_curved_concave(x,y,square_basis,lock,edge_width);
            } else {
                plain_curved(x,y,square_basis,lock,edge_width);
            }
        }
    } else if (shape == "diagonal") {
        plain_diagonal(x,y,square_basis,lock,edge_width);
    } else if (shape == "alcove") {
        plain_alcove(x,y,square_basis,lock,edge_width);
    }
}

module plain_square(x,y,square_basis,lock,edge_width) {
    difference() {
        plain_square_positive(x,y,square_basis);
        if(lock == "dragonlock") {
            dragonlock_square_negative(x,y,square_basis,edge_width);
        } else {
            plain_square_negative(x,y,square_basis,edge_width);
        }
    }
}

module plain_square_positive(x,y,square_basis) {
    e_north = ext_north ? square_basis/2 : 0;
    e_south = ext_south ? square_basis/2 : 0;
    e_east = ext_east ? square_basis/2 : 0;
    e_west = ext_west ? square_basis/2 : 0;
    
    difference() {
        hull() {
            translate([-e_west,-e_south,0.4]) cube([square_basis*x+e_west+e_east, square_basis*y+e_north+e_south, 6-.39]);
//            translate([0.25-e_west,0.25-e_south,0]) cube([square_basis*x-.5+e_west+e_east, square_basis*y-.5+e_north+e_south, 1]);
            translate([0.0-e_west,0.0-e_south,0]) cube([square_basis*x-.0+e_west+e_east, square_basis*y-.0+e_north+e_south, 1]);
        }
        if(notch == "true") {
            translate([-1,-1,-1]) cube([square_basis*notch_x+1, square_basis*notch_y+1, 8]);
            hull() {
                translate([-1,-1,0]) cube([square_basis*notch_x+1, square_basis*notch_y+1, .4]);
                translate([-1,-1,-0.01]) cube([square_basis*notch_x+1.25, square_basis*notch_y+1.25, 0.01]);
            }
        }
    }
}

module plain_square_negative(x,y,square_basis,edge_width) {
    e_north = ext_north ? square_basis/2 : 0;
    e_south = ext_south ? square_basis/2 : 0;
    e_east = ext_east ? square_basis/2 : 0;
    e_west = ext_west ? square_basis/2 : 0;

    intersection() {
        translate([edge_width-e_west,edge_width-e_south,0]) translate([1,1,-1]) cube([square_basis*x-((edge_width+1)*2)+e_west+e_east,square_basis*y-((edge_width+1)*2)+e_north+e_south,8]);
        difference() {
            translate([edge_width-e_west,edge_width-e_south,0]) translate([1,1,-1]) cube([square_basis*x-((edge_width+1)*2)+e_west+e_east,square_basis*y-((edge_width+1)*2)+e_north+e_south,8]);
            if(notch == "true") {
                translate([0,0,0.4]) cube([square_basis*notch_x+edge_width+1, square_basis*notch_y+edge_width+1, 6]);
                translate([0.25,.25,0]) cube([square_basis*notch_x+edge_width+1-.5, square_basis*notch_y+edge_width+1-.5, .4]);
            }
        }
    }
}

module dragonlock_square_negative(x,y,square_basis,edge_width,north=true,south=true,east=true,west=true,center=true) {
    module dragonlock_interior(north=true,south=true,east=true,west=true,center=true) {
        module edge() {
            difference() {
                hull() {
                    translate([3.17,-12.67,-1]) cube([8.512,12.67*2,6]);
                    translate([3.145,-12.7,-1]) cube([8.512,12.67*2,6.206]);
                }
                translate([10.29,-12.8,5.206]) rotate([0,45,0]) cube([8.512,12.8*2,6.206]);
            }
        }
        
        translate([0,25.4,0]) {
            if(center) {
                difference() {
                    translate([12.7,-12.7,-1]) cube([50.8-12.7*2,50.8-12.7*2,6.206]);
                    translate([25.4,0,0]) rotate([0,0,45]) translate([-.75,-30,-2]) cube([1.5,60,20]);
                    translate([25.4,0,0]) rotate([0,0,-45]) translate([-.75,-30,-2]) cube([1.5,60,20]);
                }
            }

            if (!west) {
                edge();
            }
            if (!south) {
                translate([25.4,-25.4,0]) rotate([0,0,90]) edge();
            }
            if (!east) {
                translate([50.8,0,0]) rotate([0,0,180]) edge();
            }
            if (!north) {
                translate([25.4,25.4,0]) rotate([0,0,270]) edge();
            }
        }
    }

    if (x > 1 && y > 1) {
        dragonlock_nub(square_basis);
        translate([square_basis*x,0,0]) rotate([0,0,90]) dragonlock_nub(square_basis);
        translate([square_basis*x,square_basis*y,0]) rotate([0,0,180]) dragonlock_nub(square_basis);
        translate([0,square_basis*y,0]) rotate([0,0,270]) dragonlock_nub(square_basis);
    }

    if (x > 1 && y > 1) {
        difference() {
            translate([square_basis/2,square_basis/2,-1]) cube([square_basis*(x-1), square_basis*(y-1),8]);
            if(notch == "true") {
                translate([0,0,0.4]) cube([square_basis*(notch_x+.5), square_basis*(notch_y+.5), 6]);
                translate([0.25,.25,0]) cube([square_basis*(notch_x+.5), square_basis*(notch_y+.5), .4]);
            }
            translate([square_basis*notch_x,0,0]) dragonlock_nub(square_basis);
            translate([0,square_basis*notch_y,0]) dragonlock_nub(square_basis);
        }
    }

/*    for(i = [2:2:x]) {
        for(j = [2:2:y]) {
            north = j == y;
            south = j == 2;
            west = i == 2;
            east = i == x;
            translate([25.4*(i-2),25.4*(j-2),0]) dragonlock_interior(north=north, south=south, west=west, east=east, center=center);
        }
    }*/
}


module plain_curved(x,y,square_basis,lock,edge_width) {
    difference() {
        intersection() {
            plain_square_positive(x,y,square_basis);
            hull() {
                translate([0,0,0.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                translate([0,0,0]) scale([(x-.25/square_basis),(y-0.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        
        if (lock == "dragonlock") {
            if (x > 1 && y > 1) {
                intersection() {
                    dragonlock_square_negative(x,y,square_basis,edge_width);
                    translate([0,0,-1]) scale([x-.5,y-.5,1]) cylinder(8,square_basis,square_basis,$fn=200);
                }
                translate([square_basis*x,0,0]) rotate([0,0,90]) dragonlock_nub(square_basis);
                translate([0,square_basis*y,0]) rotate([0,0,270]) dragonlock_nub(square_basis);
            }
        } else {
            intersection() {
                plain_square_negative(x,y,square_basis,edge_width);
                translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        }
    }
}

module plain_curved_concave(x,y,square_basis,lock,edge_width) {
    difference() {
        difference() {
            plain_square_positive(x,y,square_basis);
            hull() {
                translate([x*square_basis,y*square_basis,0.4]) scale([x-wall_width/square_basis,y-wall_width/square_basis,1]) cylinder(5.62,square_basis,square_basis,$fn=200);
                translate([x*square_basis,y*square_basis,-0.01]) scale([(x-.25/square_basis)-wall_width/square_basis,(y-0.25/square_basis)-wall_width/square_basis,1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        
        if (lock == "dragonlock") {
            if(x > 1 && y > 1) {
                difference() {
                    dragonlock_square_negative(x,y,square_basis,edge_width);
                    difference() {
                        translate([x*square_basis,y*square_basis,-1]) scale([((x*square_basis))/square_basis,((y*square_basis))/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                        translate([square_basis*x,0,0]) rotate([0,0,90]) dragonlock_nub(square_basis);
                        translate([0,square_basis*y,0]) rotate([0,0,270]) dragonlock_nub(square_basis);
                    }
                }
            }
        } else {
            difference() {
                plain_square_negative(x,y,square_basis,edge_width);
                translate([x*square_basis,y*square_basis,-1]) scale([x,y,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        }
    }
}

module plain_curved_large_4(square_basis, edge_width) {
    if(curvedlarge == "a") {
        plain_curved_large_4_a(square_basis,edge_width);
    } else if(curvedlarge == "b") {
        plain_curved_large_4_b(square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,0]) mirror([1,0,0]) {
            plain_curved_large_4_b(square_basis,edge_width);
        }
    } else if(curvedlarge == "d") {
        plain_curved_large_4_d(x,y,square_basis,edge_width);
    } else if(curvedlarge == "e") {
        plain_curved_large_4_e(x,y,square_basis,edge_width);
    } else if(curvedlarge == "f") {
        rotate([0,0,0]) mirror([1,0,0]) {
            plain_curved_large_4_f(square_basis,edge_width);
        }
    } else {
        echo("Curved 6x6 only supports a, b, c, d, e & f");
    }
}

module plain_curved_large_6(square_basis, edge_width) {
    if(curvedlarge == "a") {
        plain_curved_large_6_a(square_basis,edge_width);
    } else if(curvedlarge == "b") {
        plain_curved_large_b(x,y,square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            plain_curved_large_6_a(square_basis,edge_width);
        }
    } else {
        echo("Curved 6x6 only supports a, b & c");
    }
}

module plain_curved_large_8(square_basis, edge_width) {
    if(curvedlarge == "a") {
        plain_curved_large_8_a(square_basis,edge_width);
    } else if(curvedlarge == "b") {
        plain_curved_large_b(x,y,square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            plain_curved_large_8_a(square_basis,edge_width);
        }
    } else {
        echo("Curved 8x8 only supports a, b & c");
    }
}

module plain_curved_large_4_a(square_basis,edge_width) {
    innerx = 4;
    innery = 2;

    difference() {
        intersection() {
            translate([-2*square_basis,innery*square_basis,0]) plain_square_positive(innerx,innery,square_basis);
            hull() {
                translate([0,0,.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                translate([0,0,0]) scale([x-(.25/square_basis),y-(.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        if (lock == "dragonlock") {
            intersection() {
                translate([-innerx*square_basis/2,innery*square_basis,0]) dragonlock_square_negative(innerx,innery,square_basis,edge_width);
                translate([0,0,-1]) scale([((x*square_basis)-square_basis/2)/square_basis,((y*square_basis)-square_basis/2)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        } else {
            intersection() {
                translate([-2*square_basis,innery*square_basis,0]) plain_square_negative(innerx,innery,square_basis,edge_width);
                translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        }
    }
}

module plain_curved_large_4_b(square_basis,edge_width) {
    innerx = 2;
    innery = 4;

    difference() {
        intersection() {
            translate([-4*square_basis,0,0]) plain_square_positive(innerx,innery,square_basis);
            hull() {
                translate([0,0,.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                translate([0,0,0]) scale([x-(.25/square_basis),y-(.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        if (lock == "dragonlock") {
            intersection() {
                translate([-4*square_basis,0,0]) dragonlock_square_negative(innerx,innery,square_basis,edge_width);
                translate([0,0,-1]) scale([((x*square_basis)-square_basis/2)/square_basis,((y*square_basis)-square_basis/2)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        } else {
            intersection() {
                translate([-4*square_basis,0,0]) plain_square_negative(innerx,innery,square_basis,edge_width);
                translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        }
    }
}

module plain_curved_large_6_a(square_basis,edge_width) {
    x = 6;
    y = 6;
    innerx = 3;
    innery = 3;

    if (curvedconcave == "true") {
        difference() {
            union() {
                difference() {
                    difference() {
                        translate([0,innery*square_basis,0]) plain_square_positive(innerx,innery,square_basis);
                        translate([0,0,0.3]) cylinder(5.8,x*square_basis-(10.2*square_basis/25),x*square_basis-(10.2*square_basis/25),$fn=200);
                        translate([0,0,-0.1]) cylinder(0.5,x*square_basis-(10.2*square_basis/25)+.25,x*square_basis-(10.2*square_basis/25),$fn=200);
                    }
                    if(lock != "dragonlock") {
                        difference() {
                            translate([0,innery*square_basis,0]) plain_square_negative(innerx,innery,square_basis,edge_width);
                            translate([0,0,-1]) cylinder(8,x*square_basis-(10.2*square_basis/25)+edge_width,x*square_basis-(10.2*square_basis/25)+edge_width,$fn=200);
                        }
                    }
                }
            }
            union() {
                translate([-1,innery*square_basis-1,-1]) cube([square_basis*(innerx-1)+1, square_basis*(innery-1)+1, 8]);
                hull() {
                    translate([-1,innery*square_basis-1,0]) cube([square_basis*(innerx-1)+1, square_basis*(innery-1)+1, .4]);
                    translate([-1,innery*square_basis-1,-0.01]) cube([square_basis*(innerx-1)+1.25, square_basis*(innery-1)+1.25, 0.01]);
                }
            }
        }
    } else {
        difference() {
            union() {
                difference() {
                    intersection() {
                        translate([0,innery*square_basis,0]) plain_square_positive(innerx,innery,square_basis);
                        hull() {
                            translate([0,0,0.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                            translate([0,0,0]) scale([x-(.25/square_basis),y-(.25/square_basis),1]) cylinder(0.4,square_basis,square_basis,$fn=200);
                        }
                    }
                    if(lock != "dragonlock") {
                        intersection() {
                            translate([0,innery*square_basis,0]) plain_square_negative(innerx,innery,square_basis,edge_width);
                            translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                        }
                    }
                }
                hull() {
                    translate([0,innery*square_basis,0.4]) cube([square_basis*(innerx-1)+edge_width+1, square_basis*(innery-1)+edge_width+1, 5.6]);
                    translate([0.25,innery*square_basis+.25,0]) cube([square_basis*(innerx-1)+edge_width+1-.5, square_basis*(innery-1)+edge_width+1-.5, .4]);
                }
            }
            union() {
                translate([-1,innery*square_basis-1,-1]) cube([square_basis*(innerx-1)+1, square_basis*(innery-1)+1, 8]);
                hull() {
                    translate([-1,innery*square_basis-1,0]) cube([square_basis*(innerx-1)+1, square_basis*(innery-1)+1, .4]);
                    translate([-1,innery*square_basis-1,-0.01]) cube([square_basis*(innerx-1)+1.25, square_basis*(innery-1)+1.25, 0.01]);
                }
            }
        }
    }
}

module plain_curved_large_8_a(square_basis,edge_width) {
    innerx = 7;
    innery = 7;
    
    module plain_curved_large_8_a_convex() {
        difference() {
            intersection() {
                hull() {
                    translate([0,6*square_basis,0]) plain_square_positive(4,2,square_basis);
                }
                hull() {
                   #translate([0,0,.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                    translate([0,0,0]) scale([x-(.25/square_basis),y-(.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
                }
            }
            if(lock == "dragonlock") {
                intersection() {
                    translate([0,square_basis*6,0]) dragonlock_square_negative(4,2,square_basis,edge_width);
                    translate([0,0,-1]) scale([((x*square_basis)-square_basis/2)/square_basis,((y*square_basis)-square_basis/2)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                }
            } else {
                intersection() {
                    translate([0,6*square_basis,0]) plain_square_negative(4,2,square_basis,edge_width);
                    translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                }
            }
        }
    }
    
    module plain_curved_large_8_a_concave() {
        difference() {
            translate([0,6*square_basis,0]) plain_square_positive(4,2,square_basis);
            translate([0,0,0.3]) cylinder(5.8,x*square_basis-(10.2*square_basis/25),x*square_basis-(10.2*square_basis/25),$fn=200);
            translate([0,0,-0.1]) cylinder(0.5,x*square_basis-(10.2*square_basis/25)+.25,x*square_basis-(10.2*square_basis/25),$fn=200);
            if(lock == "dragonlock") {
                difference() {
                    translate([0,6*square_basis,0]) dragonlock_square_negative(4,2,square_basis,edge_width);
                    translate([0,0,-2]) cylinder(10,x*square_basis-(10.2*square_basis/25)+edge_width,x*square_basis-(10.2*square_basis/25)+edge_width,$fn=200);
                }
            } else {
                difference() {
                    translate([0,6*square_basis,0]) plain_square_negative(4,2,square_basis,edge_width);
                    translate([0,0,-2]) cylinder(10,x*square_basis-(10.2*square_basis/25)+edge_width,x*square_basis-(10.2*square_basis/25)+edge_width,$fn=200);
                }
            }
        }
    }
    
    if (curvedconcave == "true") {
        plain_curved_large_8_a_concave();
    }
    else {
        plain_curved_large_8_a_convex();
    }
}

module plain_curved_large_b(x,y,square_basis,edge_width) {
    innerx = x/2;
    innery = y/2;

    if(curvedconcave == "true") {
        difference() {
            difference() {
                translate([innerx*square_basis,innery*square_basis,0]) plain_square_positive(innerx,innery,square_basis);
                translate([0,0,.3]) cylinder(5.8,x*square_basis-(10.2*square_basis/25),x*square_basis-(10.2*square_basis/25),$fn=200);
                translate([0,0,-0.1]) cylinder(0.5,x*square_basis-(10.2*square_basis/25)+.25,x*square_basis-(10.2*square_basis/25),$fn=200);
            }
            if(lock == "dragonlock") {
                difference() {
                    translate([innerx*square_basis,innerx*square_basis,0]) dragonlock_square_negative(innerx,innery,square_basis,edge_width);
                    translate([0,0,-1]) cylinder(8,x*square_basis-(10.2*square_basis/25)+square_basis/2,x*square_basis-(10.2*square_basis/25)+square_basis/2,$fn=200);
                }
            } else {
                difference() {
                    translate([innerx*square_basis,innery*square_basis,0]) plain_square_negative(innerx,innery,square_basis,edge_width);
                    translate([0,0,-1]) cylinder(8,x*square_basis-(10.2*square_basis/25)+edge_width,x*square_basis-(10.2*square_basis/25)+edge_width,$fn=200);
                }
            }
        }
    } else {
        difference() {
            intersection() {
                translate([innerx*square_basis,innery*square_basis,0]) plain_square_positive(innerx,innery,square_basis);
                hull() {
                    translate([0,0,.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                    translate([0,0,0]) scale([x-(.25/square_basis),y-(.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
                }
            }
            if(lock == "dragonlock") {
                intersection() {
                    translate([innerx*square_basis,innerx*square_basis,0]) dragonlock_square_negative(innerx,innery,square_basis,edge_width);
                    translate([0,0,-1]) scale([((x*square_basis)-square_basis/2)/square_basis,((y*square_basis)-square_basis/2)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                }
            } else {
                intersection() {
                    translate([innerx*square_basis,innery*square_basis,0]) plain_square_negative(innerx,innery,square_basis,edge_width);
                    translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                }
            }
        }
    }
}

module plain_diagonal(x,y,square_basis,lock,edge_width) {
    hyp = sqrt(square_basis*x*square_basis*x+square_basis*y*square_basis*y);
    difference() {
        intersection() {
            plain_square_positive(x,y,square_basis);
            translate([x*square_basis,0,0]) rotate([0,0,atan(x/y)]) {
                translate([0,0,0.4]) cube([wall_width/2,hyp,5.6]);
                translate([0.25,0.25,0]) cube([wall_width/2-.5,hyp-.5,.4]);
                mirror([1,0,0]) cube([hyp,hyp,6]);
            }
        }
        if (lock == "dragonlock") {
            if (x > 1 && y > 1) {
                translate([square_basis/2,square_basis/2,-1]) cube([square_basis*(x-1), square_basis*(y-1),8]);
                dragonlock_nub(square_basis);
                translate([square_basis*x,0,0]) rotate([0,0,90]) dragonlock_nub(square_basis);
                difference() {
                    translate([0,square_basis*y,0]) rotate([0,0,270]) dragonlock_nub(square_basis);
                    translate([x*square_basis+square_basis*.2,0,0]) rotate([0,0,atan(x/y)-90]) mirror([1,0,0]) cube([hyp* 1.5,hyp*1.5,6]);
                }
                    
            }
        } else {
            plain_square_negative(x,y,square_basis,edge_width);
        }
    }
    intersection() {
        translate([x*square_basis,0,0]) rotate([0,0,atan(x/y)]) {
            hull() {
                translate([0,0,0.4]) cube([wall_width/2,hyp,56]);
                translate([0,0.25,0])cube([wall_width/2-.25,hyp-.5,0.4]);
            }
            mirror([1,0,0]) cube([wall_width/2,hyp,6]);
        }
        difference() {
            hull() {
                translate([0,0,0.4]) cube([square_basis*x, square_basis*y, 5.6]);
                translate([0.25,0.25,0]) cube([square_basis*x-.5, square_basis*y-.5, .4]);
            }
            if(lock == "dragonlock" && x > 1 && y > 1) {
                difference() {
                    translate([0,square_basis*(y-1),0]) dragonlock_nub();
                    translate([x*square_basis+square_basis*.2,0,0]) rotate([0,0,atan(x/y)-90]) mirror([1,0,0]) cube([hyp* 1.5,hyp*1.5,6]);
                }
                difference() {
                    translate([square_basis*x,square_basis,0]) rotate([0,0,180]) dragonlock_nub();
                    translate([0,y*square_basis+square_basis*.2,0]) rotate([0,0,atan(x/y)+180]) mirror([1,0,0]) cube([hyp* 1.5,hyp*1.5,6]);
                }
            }
        }
    }
}

module plain_alcove(x,y,square_basis,lock,edge_width) {
    mult = 25 / 10.2;
    wall_width = square_basis / mult;
    
    module semicircle() {
        hull() {
            difference() {
                translate([square_basis, 0, .4]) cylinder(5.6,x*square_basis/2+wall_width,x*square_basis/2+wall_width,$fn=200);
                translate([-wall_width-1,-x*square_basis-wall_width,-1]) cube([x*square_basis+wall_width*2+2,x*square_basis+wall_width,8]);
            }
            difference() {
                translate([square_basis, 0, 0]) cylinder(.4,x*square_basis/2+wall_width-.25,x*square_basis/2+wall_width-.25,$fn=200);
                translate([-wall_width-1,-x*square_basis-wall_width+.25,-1]) cube([x*square_basis+wall_width*2+2,x*square_basis+wall_width,8]);
            }
        }
    }

    if(lock == "dragonlock") {
        difference() {
            semicircle();
            difference() {
                translate([x*square_basis/2,0,-1]) cylinder(8,x*square_basis/2-.25, x*square_basis/2-.25,$fn=200);
                translate([0,0,-1]) cube([x*square_basis,square_basis/2,8]);
            }
        }
    } else {
        difference() {
            plain_square_positive(x,x/2,square_basis,edge_width);
            translate([-1,8,-1]) cube([x*square_basis+2,x*square_basis,8]);
            plain_square_negative(x,x/2,square_basis,edge_width);
        }
        difference() {
            semicircle();
            translate([x*square_basis/2,0,-1]) cylinder(8,x*square_basis/2-.25, x*square_basis/2-.25,$fn=200);
        }
    }
}







/*
 * OpenVLex Support
 */


module openvlex_cover_topmost(x, y, square_basis, of_sheet_diam=11) {
    translate([0,0,5.7])
    difference() {
        cube([square_basis*x,square_basis*y,0.3]);
        for ( i = [0 : x-1] ) {
            for ( j = [0 : y-1] ) {
                translate([i*square_basis, j*square_basis,0])
                translate([square_basis/2-of_sheet_diam/2, square_basis/2-of_sheet_diam/2,0])
                cube([of_sheet_diam,of_sheet_diam,0.4]);
            }
        }
    }
}

module openvlex_cover_supports(x, y, square_basis, of_sheet_diam = 11) {
    of_supp_diam = of_sheet_diam + 0.4;
    translate([0,0,5.4])
    for ( i = [0 : x-1] ) {
        for ( j = [0 : y-1] ) {
            translate([i*square_basis, j*square_basis,0])
            translate([square_basis/2-of_supp_diam/2, square_basis/2-of_supp_diam/2,0])
            cube([of_supp_diam,of_supp_diam,0.3]);
        }
    }
}

module openvlex_cover_bottom(x, y, square_basis, of_sheet_diam=11) {
    translate([0,0,5.4])
        cube([square_basis*x,square_basis*y,0.29]);
}

module openvlex_cover(x, y, square_basis) {
    of_sheet_diam = 11;
    union() {
        openvlex_cover_topmost(x,y,square_basis,of_sheet_diam);
        openvlex_cover_bottom(x,y,square_basis,of_sheet_diam);
    }
}

module openvlex_base(x, y, square_basis) {
        cube([square_basis*x,square_basis*y,1.4]);
}

module openvlex_tubes(x,y,square_basis) {
    openlock_clip_length = 19.5 + 0.1;
    //of_tube = 5.4;
    of_tube = (square_basis/2 - openlock_clip_length/2) * 2;
    for ( i = [0 : x-1] ) {
        for ( j = [0 : y-1] ) {
            // tube:
            translate([i*square_basis, j*square_basis,0])
            translate([square_basis/2-of_tube/2, square_basis/2-of_tube/2, 0])
            cube([of_tube,of_tube,6]);
        }
    }
}

module openvlex_middle_block(x,y,square_basis) {
    //translate([10,10,0]) cube([square_basis*x-20,square_basis*y-20,6]);
    translate([0,0,0]) cube([square_basis*x,square_basis*y,6]);
}



module openvlex_positive_cover(x,y,square_basis, edge_width) {
    translate([0,0,5.4])
        cube([square_basis*x,square_basis*y,0.6]);
}

module openvlex_positive_cover2(x,y,square_basis, edge_width) {
    translate([0,0,5.7])
        cube([square_basis*x,square_basis*y,0.3]);
    
    for ( i = [0 : x-1] ) {
        for ( j = [0 : y-1] ) {
            
            translate([i*square_basis, j*square_basis,0])
            translate([square_basis/2-7.5, square_basis/2-7.5, 5.4])
            cube([15,15,0.3]);
            
        }
    }
    
    
}






module openvlex_middle(x,y,square_basis, edge_width) {
    translate([10,10,0])
    cube([square_basis*x-20,square_basis*y-20,6]);
}


module of_single_column_support() {

    module support() {
        translate([0, 0, 1.2]) cube([2, 1, 4.6]);
        hull() {
            translate([0, 0,   1.4]) cube([2, 1,   2.1]);
            translate([0, -.2, 1.9]) cube([2, 1.4, 1.1]);
        }
        hull() {
            translate([0, 0,   3.5]) cube([2, 1,   2.1]);
            translate([0, -.2, 4.0]) cube([2, 1.4, 1.1]);
        }
    }

    if (additional_supports == "two") {
        
        // left
        translate([6.2, 1.1, 0]) support();
        
        // right
        translate([6.2, -2.1, 0]) support();
        
        
    } else if (additional_supports == "three") {
        
        // left
        translate([6.4, 2, 0]) support();
        
        // right
        translate([6.4, -3, 0]) support();

        // middle
        translate([7.4, -0.5, 0]) support();

    }
    
}




module of_additional_column_supports(x,y,square_basis) {
    for ( i = [0 : y-1] ) {
        translate([0,square_basis*(i+1)-square_basis/2,0])
            of_single_column_support();
        translate([square_basis*x,square_basis*(i+1)-square_basis/2,0])
            rotate([0,0,180]) of_single_column_support();
    }
    for ( i = [0 : x-1] ) {
        translate([square_basis*(i+1)-square_basis/2,0,0])
            rotate([0,0,90]) of_single_column_support();
        translate([square_basis*(i+1)-square_basis/2,square_basis*y,0])
            rotate([0,0,-90]) of_single_column_support();
    }
}




module openvlex_supports(x,y,square_basis,support_h) {
     
    cube([square_basis/2+4.75,square_basis/2+4.75,support_h]);
    
    translate([square_basis*x-square_basis/2-4.75,0,0])
    cube([square_basis/2+4.75,square_basis/2+4.75,support_h]);
    
    translate([0,square_basis*y-square_basis/2-4.75,0])
    cube([square_basis/2+4.75,square_basis/2+4.75,support_h]);
    
    translate([square_basis*x-square_basis/2-4.75,square_basis*y-square_basis/2-4.75,0])
    cube([square_basis/2+4.75,square_basis/2+4.75,support_h]);
    
    if (x > 2) {
        for ( i = [2 : x-1] ) {
            translate([(i-.5)*square_basis-9.5/2,0,0])
            cube([9.5,square_basis/2+4.75,support_h]);
            
            translate([(i-.5)*square_basis-9.5/2,square_basis*y-square_basis/2-4.75,0])
            cube([9.5,square_basis/2+4.75,support_h]);
        }
    }
    if (y > 2) {
        for ( i = [2 : y-1] ) {
            translate([0,(i-.5)*square_basis-9.5/2,0])
            cube([square_basis/2+4.75,9.5,support_h]);
            
            translate([square_basis*x-square_basis/2-4.75,(i-.5)*square_basis-9.5/2,0])
            cube([square_basis/2+4.75,9.5,support_h]);
        }
    }
    
    of_additional_column_supports(x,y,square_basis);
}




module openvlex_hole(x,y,square_basis) {
    
    // diameters bottom to top:
    of_bw_d = 4.8;      // bottom widening diameter
    of_bw_y = 1.2;      // bottom widening y
    of_bw_h = 0.3;      // bottom widening height

    of_hole_d = 3.8;    // OpenVLex hole diameter

    of_tw_d = 5.0;      // top widening diameter
    of_tw_y = 3.4;      // top widening y
    of_tw_h = 2.3;      // top widening height
    
    for ( i = [0 : x-1] ) {
        for ( j = [0 : y-1] ) {
            
            // bottom widening:

            translate([i*square_basis, j*square_basis,0])
            translate([square_basis/2-of_bw_d/2, square_basis/2-of_bw_d/2, -0.1])
            hull() {
               translate([(of_bw_d-of_hole_d)/2,(of_bw_d-of_hole_d)/2, of_bw_h + of_bw_y + 0.1])
                  cube([of_hole_d,of_hole_d,0.01]);
               cube([of_bw_d,of_bw_d, of_bw_y +0.1]);
            }

            // plug hole:
            
            translate([i*square_basis, j*square_basis,0])
            translate([square_basis/2-of_hole_d/2, square_basis/2-of_hole_d/2, -0.1])
            cube([of_hole_d,of_hole_d,6 +0.2]);
            
            // top widening:
            
            translate([i*square_basis,j*square_basis,0])
            translate([square_basis/2-of_tw_d/2, square_basis/2-of_tw_d/2, of_tw_y])
            hull() {
               translate([0,0,of_tw_h])
                  cube([of_tw_d,of_tw_d,9]);
               translate([(of_tw_d-of_hole_d)/2,(of_tw_d-of_hole_d)/2,0])
                  cube([of_hole_d,of_hole_d,0.01]);
            }
            
            // flat lowered area for the plug sheet:
            
            translate([i*square_basis, j*square_basis,0])
            translate([square_basis/2-5.5, square_basis/2-5.5, 5.7])
            cube([11,11,0.4]);
            
        }
    }
    
}

module openvlex_negative(x,y,square_basis, shape, edge_width) {
    if(shape == "square") {
        openvlex_hole(x,y,square_basis);
    } else if (shape == "curved") {
        echo("Curved does not support OpenVLex");
    } else if (shape == "curvedlarge.a") {
        echo("Curved does not support OpenVLex");
    } else if (shape == "curvedlarge.b") {
        echo("Curved does not support OpenVLex");
    } else if (shape == "curvedlarge.c") {
        echo("Curved does not support OpenVLex");
    } else if (shape == "diagonal") {
        echo("Diagonal does not support OpenVLex");
    }
}

module openvlex_magnet_negative(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,0.6]) cylinder(5.1,magnet_hole/2,magnet_hole/2, $fn=100);
        translate([magnet_hole/2+1,0,-0.1]) cylinder(1,.9,.9,$fn=50);
    }
}

module openvlex_magnets_negative(x,y,square_basis,edge_width,magnet_hole,lock,priority) {
    for ( i = [0 : y-1] ) {
            translate([0,square_basis*(i+1)-square_basis/2,0]) openvlex_magnet_negative(magnet_hole);
            translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) openvlex_magnet_negative(magnet_hole);
    }
    for ( i = [0 : x-1] ) {
            translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) openvlex_magnet_negative(magnet_hole);
            translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) openvlex_magnet_negative(magnet_hole);
    }
}

module openvlex_chambers(x,y,square_basis) {
    
    module openvlex_chamber() {
        translate([6, -8, -0.1]) cube([4.7, 8*2, 5.4 + 0.1]);
    }
    
    if (y > 1) {
        for ( i = [1 : y-1] ) {
            translate([0,square_basis*i,0]) openvlex_chamber();
            translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) openvlex_chamber();
        }
    }
    if (x > 1) {
        for ( i = [1 : x-1] ) {
            translate([square_basis*i,0,0]) rotate([0,0,90]) openvlex_chamber();
            translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) openvlex_chamber();
        }
    }
    
}








/*
 * Top Level Function
 */
module base(x,y,square_basis,
        shape="square",magnet_hole=6,lock="false",priority="magnets",dynamic_floors="false",curvedconcave="false",openvlex="false") {
    df = dynamic_floors == "true" ? true : false;
    edge_width = magnet_hole >= 5.55 ? magnet_hole + 1 : 6.55;


    difference() {
        union() {
            difference() {
                union() {
                    plain_base(x,y,square_basis,lock,shape,edge_width);
                    if(df) {
                        df_positive(x,y,square_basis,shape,edge_width);
                    }
                    if (openvlex != "none") {
                        openvlex_base(x,y,square_basis);
                        openvlex_middle_block(x,y,square_basis);
                        openvlex_supports(x,y,square_basis,6);
                    }
                    connector_positive(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) ;
                }
                if(df) {
                    df_negative(x,y,square_basis, shape, edge_width);
                }
                connector_negative(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) ;
            }
            if (openvlex != "none") {
                openvlex_cover(x,y,square_basis);
                openvlex_tubes(x,y,square_basis);
                if (priority == "lock" || magnet_hole == 0) {
                    openvlex_supports(x,y,square_basis,1.4);
                }
            }
        }
        if (openvlex != "none") {
            openvlex_negative(x,y,square_basis,shape,edge_width);
            openvlex_chambers(x,y,square_basis);
            
            if (magnet_hole != 0) {
                openvlex_magnets_negative(x,y,square_basis,edge_width,magnet_hole,lock,priority) ;
            }
            
            if (openvlex == "magnetic_lower") {
                // cut away upper part:
                translate([-0.1,-0.1,0.6])
                    cube([square_basis*x+0.2,square_basis*y+0.2,5.4 +0.1]);
                // make it a little bit smaller:
                of_ml_inset = 0.2;
                translate([-0.1, -4 + of_ml_inset, -0.1])
                    cube([square_basis*x+0.2, 4, 1.2]);
                translate([-0.1, square_basis*y - of_ml_inset, -0.1])
                    cube([square_basis*x+0.2, 4, 1.2]);
                
                translate([-4 + of_ml_inset, -0.1, -0.1])
                    cube([4, square_basis*y+0.2, 1.2]);
                translate([square_basis*x - of_ml_inset, -0.1, -0.1])
                    cube([4, square_basis*y+0.2, 1.2]);
                
            } else if (openvlex == "magnetic_upper") {
                // cut away lower part:
                translate([-0.1,-0.1,-0.1])
                    cube([square_basis*x+0.2,square_basis*y+0.2,0.61 +0.1]);
            }
        }
    }

    
}

function keyLookup (data, key) = search(key, data, num_returns_per_match=1)[0];


basis = [
    ["25mm", 25],
    ["inch", 25.4],
    ["wyloch", 31.75]
];
square_basis_number = basis[keyLookup(basis, [square_basis])][1];
wall_width = 10.2*square_basis_number/25;

// Compatability
valid_dragonlock_x = (x % 2 == 0);
valid_dragonlock_y = (y % 2 == 0);
valid_dragonlock_basis = (square_basis == "inch");

valid_infinitylock_basis = (square_basis == "inch");

ext_north = external_north == "true";
ext_south = external_south == "true";
ext_east = external_east == "true";
ext_west = external_west == "true";

if(lock == "infinitylock" && !valid_infinitylock_basis) {
    echo("ERROR: infinitylock is only compatible with inch basis");
} else {
    color("Grey") base(x,y,square_basis_number,shape=shape,magnet_hole=magnet_hole,lock=lock,priority=priority,dynamic_floors=dynamic_floors,openvlex=openvlex);
}

//plain_base(x,y,square_basis_number,shape,7);