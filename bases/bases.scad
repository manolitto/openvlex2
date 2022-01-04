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

/* [OpenVLex Sockets] */
// OpenVLex vertical locking sockets
ov_sockets = "square"; // [none: Disable OpenVLex, square: Standard square grid OpenVLex, radial: Radial OpenVLex sockets]
 
/* [OpenVLex Magnetic Part] */
// Which part to render for magnetic OpenVLex
ov_part = "all"; // [all, upper, lower, sockets_only, bottom_sockets]
// Cut out round "windows" on the side faces to increase the magnetic pull
ov_magnet_window = "true"; // [true, false]

/* [OpenVLex Additional Supports] */
// Add additional supports? (Recommended for OpenVLex triplex)
ov_additional_stability_bars = "true"; // [true, false]
// notch out unneeded parts of the base tile to save material and print time
ov_material_saving = "checker"; // [none: none - massive base without any center notches, whole_center: whole center notch, checker: checkerboard holes]

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
        if (ov_sockets == "none") {
            translate([1,-magnet_hole/2,1]) cube([magnet_hole/2,magnet_hole,8]);
            translate([1,-0.9,-2]) cube([magnet_hole/2,1.8,10]);
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
 * OpenVLex 2 Feature
 */


// OpenVLex socket

module openvlex_socket_impl(recess=true) {
    
    z_corr = ov_part == "sockets_only" || ov_part == "bottom_sockets" ? 0.0 : 0.1;  // make it oversized on z axis when used as negative
    
    // diameters bottom to top:
    ov_bw_d = 4.8;      // bottom widening diameter
    ov_bw_z = 1.2;      // bottom widening z
    ov_bw_h = 0.3;      // bottom widening height

    ov_hole_d = 3.8;    // OpenVLex hole diameter
    ov_hole_h = 6.0;    // OpenVLex hole height
    
    ov_tw_d = 5.0;      // top widening diameter
    ov_tw_z = 3.4;      // top widening z
    ov_tw_h = 2.3;      // top widening height
    
    ov_recess_d = 11.0; // diameter of top recess for the jack's plate
    ov_recess_z = 5.7;  // z of top recess for the jack's plate
    ov_recess_h = 0.3;  // height of top recess for the jack's plate
    
    // bottom widening:
    color("blue") translate([-ov_bw_d/2, -ov_bw_d/2, -z_corr])
    hull() {
       translate([(ov_bw_d-ov_hole_d)/2,(ov_bw_d-ov_hole_d)/2, ov_bw_h + ov_bw_z + z_corr])
          cube([ov_hole_d,ov_hole_d,0.01]);
       cube([ov_bw_d,ov_bw_d, ov_bw_z + z_corr]);
    }

    // plug hole:
    color("orange") translate([-ov_hole_d/2, -ov_hole_d/2, -z_corr])
    cube([ov_hole_d,ov_hole_d, ov_hole_h +2*z_corr]);
    
    // top widening:
    color("red") translate([-ov_tw_d/2, -ov_tw_d/2, ov_tw_z])
    hull() {
       translate([0,0,ov_tw_h])
          cube([ov_tw_d,ov_tw_d, ov_hole_h - ov_tw_h - ov_tw_z + z_corr]);
       translate([(ov_tw_d-ov_hole_d)/2,(ov_tw_d-ov_hole_d)/2,0])
          cube([ov_hole_d, ov_hole_d, 0.01]);
    }
    
    if (recess) {
        // flat recess for the jack's plate:
        color("green") translate([-ov_recess_d/2, -ov_recess_d/2, ov_recess_z])
        cube([ov_recess_d,ov_recess_d,ov_recess_h + z_corr]);
    }
    
}

module openvlex_top_socket() {
    openvlex_socket_impl(recess=true);
}

module openvlex_bottom_socket() {
    translate([0,0,6]) rotate([180,0,0]) 
    openvlex_socket_impl(recess=false);
}

module openvlex_connector_socket(top=true) {
    if (top) {
        openvlex_top_socket();
    } else {
        openvlex_bottom_socket();
    }
}



// OpenVLex positive

module openvlex_ground_plate(x, y, square_basis) {
    if (shape == "square") {
        openvlex_ground_plate_square(x, y, square_basis);
    } else if (shape == "curved" ) {
        openvlex_ground_plate_curved(x, y, square_basis);
    } else {
        assert(false, concat("OpenVLex not supported for shape ", shape)); 
    }
}

module openvlex_ground_plate_square(x, y, square_basis) {
    cube([square_basis*x, square_basis*y, 1.4]);
}

module openvlex_ground_plate_curved(x, y, square_basis) {
    intersection() {
        scale([x,y,1]) cylinder(1.4,square_basis,square_basis,$fn=200);
        openvlex_ground_plate_square(x, y, square_basis);
    }
}


module openvlex_middle_block(x,y,square_basis) {
    clip_length = (lock == "openlock" || lock == "triplex")
                    ? 19.5
                    : 0;     // infinitylock,  dragonlock currently not supported!

    module middle_block_square() {
        translate([clip_length/2, clip_length/2, 0])
        cube([square_basis*x-clip_length,square_basis*y-clip_length,6]);
    }

    if (shape == "square") {
        middle_block_square();
    } else if (shape == "curved") {
        intersection() {
            scale([x,y,1]) cylinder(6,square_basis-clip_length/2/x,square_basis-clip_length/2/y,$fn=200);
            middle_block_square();
        }
    }
}

module openvlex_top_cover(x,y,square_basis) {
    if (shape == "square") {
        openvlex_top_cover_square(x,y,square_basis);
    } else if (shape == "curved") {
        openvlex_top_cover_curved(x,y,square_basis);
    } else {
        assert(false, concat("OpenVLex not supported for shape ", shape)); 
    }
}

module openvlex_top_cover_square(x,y,square_basis) {
    translate([0,0,5.4])
        cube([square_basis*x,square_basis*y,0.6]);
}

module openvlex_top_cover_curved(x,y,square_basis) {
    intersection() {
        translate([0,0,5.4]) scale([x,y,1]) cylinder(0.6,square_basis,square_basis,$fn=200);
        openvlex_top_cover_square(x, y, square_basis);
    }
}

module openvlex_magnet_shells_positive(x, y, square_basis) {
  mshell_w = 11;
  mshell_l = 10;
  mshell_h = 6;
  if (y > 1 || priority == "magnets") {
    for ( i = [0 : y-1] ) {
        translate([0, square_basis*(i+1)-square_basis/2-mshell_w/2, 0])
            cube([mshell_l,mshell_w,mshell_h]);
        if (shape == "square") {
            translate([square_basis*x-mshell_l, square_basis*(i+1)-square_basis/2-mshell_w/2, 0])
                cube([mshell_l,mshell_w,mshell_h]);
        }
    }
  }
  if (x > 1 || priority == "magnets") {
    for ( i = [0 : x-1] ) {
        translate([square_basis*(i+1)-square_basis/2-mshell_w/2, 0, 0])
            cube([mshell_w,mshell_l,mshell_h]);
        if (shape == "square") {
            translate([square_basis*(i+1)-square_basis/2-mshell_w/2, square_basis*y-mshell_l, 0])
                cube([mshell_w,mshell_l,mshell_h]);
        }
    }
  }
}

module openvlex_stability_bars_positive(x, y, square_basis) {

    sbar_w1 = 0.45;
    sbar_w2 = 1.0;
    sbar_l2 = 1.0;
    sbar_indent = 7.2;
    sbar_l = 19.5/2 - sbar_indent;
    sbar_l1 = sbar_l - sbar_l2;
    sbar_h = 6;
    
    for ( i = [0 : y-1] ) {
        translate([sbar_indent, square_basis*(i+1)-square_basis/2-sbar_w2/2, 0])
            hull() {
                translate([0,(sbar_w2-sbar_w1)/2,0]) cube([sbar_l, sbar_w1, sbar_h]);
                translate([sbar_l1,0,0]) cube([sbar_l2, sbar_w2, sbar_h]);
            }
        if (shape == "square") {    
            translate([square_basis*x-sbar_l-sbar_indent, square_basis*(i+1)-square_basis/2-sbar_w2/2, 0])
                hull() {
                    translate([0,(sbar_w2-sbar_w1)/2,0]) cube([sbar_l, sbar_w1, sbar_h]);
                    translate([0,0,0]) cube([sbar_l2, sbar_w2, sbar_h]);
                }
        }
    }
    for ( i = [0 : x-1] ) {
        translate([square_basis*(i+1)-square_basis/2-sbar_w2/2, sbar_indent, 0])
            hull() {
                translate([(sbar_w2-sbar_w1)/2,0,0]) cube([sbar_w1, sbar_l, sbar_h]);
                translate([0,sbar_l1,0]) cube([sbar_w2, sbar_l2, sbar_h]);
            }
        if (shape == "square") {    
            translate([square_basis*(i+1)-square_basis/2-sbar_w2/2, square_basis*y-sbar_l-sbar_indent, 0])
                hull() {
                    translate([(sbar_w2-sbar_w1)/2,0,0]) cube([sbar_w1, sbar_l, sbar_h]);
                    translate([0,0,0]) cube([sbar_w2, sbar_l2, sbar_h]);
                }
        }
    }
}

module openvlex_positive(x, y, square_basis,edge_width) {

    openvlex_ground_plate(x,y,square_basis);
    openvlex_middle_block(x,y,square_basis);
    openvlex_top_cover(x,y,square_basis);
    
    if (magnet_hole > 0) {
      openvlex_magnet_shells_positive(x,y,square_basis);
    } else {
        if (ov_additional_stability_bars == "true") {
            color("blue")
            openvlex_stability_bars_positive(x,y,square_basis);
        }
    }

}


// OpenVLex negative

function is_inside_curve(x,y,square_basis,xs,ys)
    = y/x * sqrt(x*square_basis*x*square_basis - xs*xs) >= ys;

function is_ov_socket_inside_curve(x,y,square_basis,i,j)
    = is_inside_curve(x,y,square_basis,
                      i*square_basis + square_basis/2 + 11/2,
                      j*square_basis + square_basis/2 + 11/2);

module openvlex_square_sockets_negative(x,y,square_basis, top=true) {
    
    for ( i = [0 : x-1] ) {
        for ( j = [0 : y-1] ) {
            if (shape == "curved") {
                if (is_ov_socket_inside_curve(x,y,square_basis,i,j)) {
                    translate([i*square_basis, j*square_basis,0])
                    translate([square_basis/2, square_basis/2,0])
                    openvlex_connector_socket(top);
                }
            } else {
                translate([i*square_basis, j*square_basis,0])
                translate([square_basis/2, square_basis/2,0])
                openvlex_connector_socket(top);
            }
            
        }
    }
}

module openvlex_radial_marker_arc_negative(x,y,square_basis, top=true) {
    
    module sector(radius, angles, fn = 24) {
        r = radius / cos(180 / fn);
        step = -360 / fn;

        points = concat([[0, 0]],
            [for(a = [angles[0] : step : angles[1] - 360]) 
                [r * cos(a), r * sin(a)]
            ],
            [[r * cos(angles[1]), r * sin(angles[1])]]
        );

        difference() {
            circle(radius, $fn = fn);
            polygon(points);
        }
    }

    module arc(radius, angles, width = 1, fn = 24) {
        difference() {
            sector(radius + width, angles, fn);
            sector(radius, angles, fn);
        }
    } 

    z_corr = ov_part == "sockets_only" ? 0.0 : 0.1;  // make it oversized on z axis when used as negative

    marking_w = 0.2;
    marking_h = 0.13;
    h = top == true ? 6-marking_h : 0;

    // 1x "marc"
    translate([0,0,h])
    linear_extrude(marking_h +z_corr)
    arc(square_basis - marking_w/2, [5,85], marking_w, fn=100);

    // 2x "marc"
    if (x > 1 && y > 1 && shape == "square" || x > 2 && y > 2) {
        translate([0,0,h])
        linear_extrude(marking_h +z_corr)
        arc(square_basis*2 - marking_w/2,
            [x <= 2 ? 20 : 5, y <= 2 ? 70 : 85],
            marking_w, fn=100);
    }
    
    // 3x "marc"
    if (x > 2 && y > 2 && shape == "square" || x > 3 && y > 3) {
        translate([0,0,h])
        linear_extrude(marking_h +z_corr)
        arc(square_basis*3 - marking_w/2,
            [x <= 3 ? 20 : 5, y <= 3 ? 70 : 85],
            marking_w, fn=100);
    }
    
    // 4x "marc"
    if (x > 3 && y > 3 && shape == "square" || x > 4 && y > 4) {
        translate([0,0,h])
        linear_extrude(marking_h +z_corr)
        arc(square_basis*4 - marking_w/2,
            [x <= 4 ? 20 : 5, y <= 4 ? 70 : 85],
            marking_w, fn=100);
    }
    
    // 5x "marc"
    if (x > 4 && y > 4) {
        translate([0,0,h])
        linear_extrude(marking_h +z_corr)
        arc(square_basis*5 - marking_w/2,
            [x <= 5 ? 20 : 5, y <= 5 ? 70 : 85],
            marking_w, fn=100);
    } else if (x == 4 && y == 4 && shape == "square") {
        translate([0,0,h])
        linear_extrude(marking_h +z_corr)
        arc(square_basis*5 - marking_w/2,
            [40, 50],
            marking_w, fn=100);
    }
}

module openvlex_radial_sockets_negative(x,y,square_basis, top=true) {

    function sagita(r, s) = r - sqrt (4*r*r - s*s) / 2;

    jack_size = 4;
    socket_size = 11.0; // diameter of top recess for the jack's plate
    min_corner_dist = 19.0;

    assert(x == y, "Radial OpenVLex connectors only supported for equal width and length");

    //echo(square_basis - socket_size/2 - sagita(square_basis, socket_size));

    // 1x inner circle
    rotate([0,0,45])
    translate([min_corner_dist, 0, 0])
    openvlex_connector_socket(top);

    // 2x belt
    if (x > 1) {
        rotate([0,0,45/2])
        translate([square_basis + square_basis/2, 0, 0])
        openvlex_connector_socket(top);
    }
    if (y > 1) {
        rotate([0,0,45/2+45])
        translate([square_basis + square_basis/2, 0, 0])
        openvlex_connector_socket(top);
    }

    // 2x concave floor part
    if (x == 2 && y == 2 && shape == "square") {
        
        echo(square_basis*2 + jack_size/2 + sagita(square_basis*2, jack_size));
        echo(sqrt(2 * square_basis*2*square_basis*2) - min_corner_dist);
        
        rotate([0,0,45])
//        translate([square_basis*2 + jack_size/2 + sagita(square_basis*2, jack_size), 0, 0])
        translate([sqrt(2 * square_basis*2*square_basis*2) - min_corner_dist, 0, 0])
        openvlex_connector_socket(top);
    }

    // 3x belt
    if (x > 2) {
        rotate([0,0,45/4])
        translate([square_basis*2 + square_basis/2, 0, 0])
        openvlex_connector_socket(top);

        rotate([0,0,45/4 * 3])
        translate([square_basis*2 + square_basis/2, 0, 0])
        openvlex_connector_socket(top);
    }
    if (y > 2) {
        rotate([0,0,45/4 * 5])
        translate([square_basis*2 + square_basis/2, 0, 0])
        openvlex_connector_socket(top);

        rotate([0,0,45/4 * 7])
        translate([square_basis*2 + square_basis/2, 0, 0])
        openvlex_connector_socket(top);
    }

    // 3x concave floor part
    if (x == 3 && y == 3 && shape == "square") {
        rotate([0,0,45])
        translate([sqrt(2 * square_basis*3*square_basis*3) - min_corner_dist, 0, 0])
        openvlex_connector_socket(top);
    }

    // 4x belt
    if (x > 3) {
        rotate([0,0,45/4])
        translate([square_basis*3 + square_basis/2, 0, 0])
        openvlex_connector_socket(top);

        rotate([0,0,45/4 * 3])
        translate([square_basis*3 + square_basis/2, 0, 0])
        openvlex_connector_socket(top);
    }
    if (y > 3) {
        rotate([0,0,45/4 * 5])
        translate([square_basis*3 + square_basis/2, 0, 0])
        openvlex_connector_socket(top);

        rotate([0,0,45/4 * 7])
        translate([square_basis*3 + square_basis/2, 0, 0])
        openvlex_connector_socket(top);
    }
    
    // 4x concave floor part
    if (x == 4 && y == 4 && shape == "square") {
        rotate([0,0,45/24*19])
        translate([square_basis*4 + socket_size/2 + sagita(square_basis*4, socket_size), 0, 0])
        openvlex_connector_socket(top);

        rotate([0,0,45])
        translate([sqrt(2 * square_basis*4*square_basis*4) - min_corner_dist, 0, 0])
        openvlex_connector_socket(top);

        rotate([0,0,45/24*29])
        translate([square_basis*4 + socket_size/2 + sagita(square_basis*4, socket_size), 0, 0])
        openvlex_connector_socket(top);

    }
}

module openvlex_sockets_negative(x, y, square_basis, top=true) {
    if (ov_sockets == "square") {
        openvlex_square_sockets_negative(x,y,square_basis, top);
    } else if (ov_sockets == "radial") {
        if (shape == "square") {
            openvlex_radial_marker_arc_negative(x,y,square_basis, top);
        }
        openvlex_radial_sockets_negative(x,y,square_basis, top);
    }
}

module openvlex_bottom_sockets_negative(x,y,square_basis) {
    if (ov_sockets == "square") {
        openvlex_square_bottom_sockets_negative(x,y,square_basis);
    } else if (ov_sockets == "radial") {
        openvlex_radial_bottom_sockets_negative(x,y,square_basis);
    }
}

module openvlex_openlock_chamber_negative(x,y,square_basis) {
    
    module openlock_chamber() {
        translate([6, -8, -0.1]) cube([4.7, 8*2, 5.4 + 0.1]);
    }
    
    if (y > 1) {
        for ( i = [1 : y-1] ) {
            translate([0,square_basis*i,0]) openlock_chamber();
            if (shape == "square") {
                translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) openlock_chamber();
            }
        }
    }
    if (x > 1) {
        for ( i = [1 : x-1] ) {
            translate([square_basis*i,0,0]) rotate([0,0,90]) openlock_chamber();
            if (shape == "square") {
                translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) openlock_chamber();
            }
        }
    }
}

module openvlex_magnet_negative() {
    h_top = 0.3;
    h_bottom = 0.6;
    h_middle = 6.0 - 0.3 - h_top - h_bottom;
    small_hole = magnet_hole - 2.4;

    hull() {
        // smaller top hole
        translate([magnet_hole/2+1,0, h_bottom+h_middle]) cylinder(h_top, small_hole/2, small_hole/2, $fn=30);
        translate([1, -small_hole/2, h_bottom+h_middle]) cube([small_hole/2, small_hole, h_top]);

        // main hole    
        translate([magnet_hole/2+1,0, h_bottom]) cylinder(h_middle, magnet_hole/2, magnet_hole/2, $fn=60);
        translate([1, -magnet_hole/2, h_bottom]) cube([magnet_hole/2, magnet_hole, h_middle]);
    }
    // bottom tiny hole
    translate([magnet_hole/2+1,0,-0.1]) cylinder(h_bottom+0.2,.9,.9,$fn=30);
    translate([1.5,-0.9,-0.1]) cube([magnet_hole/2-0.5,1.8,h_bottom+0.2]);
}

/**
 * 
 **/
module openvlex_magnet_wall_window() {
    if (ov_magnet_window == "true") {
        union() {
            translate([-0.01,0,3]) rotate([0,90,0]) cylinder(0.40+0.02,1.6,1.6,$fn=30);
            translate([ 0.40,0,3]) rotate([0,90,0]) cylinder(0.60+0.01,1.6,2.4,$fn=30);
        }
    }
}

module openvlex_magnets_negative(x,y,square_basis) {
  if (y > 1 || priority == "magnets") {
    for ( i = [0 : y-1] ) {
        translate([0,square_basis*(i+1)-square_basis/2,0]) openvlex_magnet_negative();
        translate([0,square_basis*(i+1)-square_basis/2,0]) openvlex_magnet_wall_window();
        if (shape == "square") {
            translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) openvlex_magnet_negative();
            translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) openvlex_magnet_wall_window();
        }
        //translate([0,square_basis*(i+1)-square_basis/2,0]) openvlex_magnet_wall_window();
    }
  }
  if (x > 1 || priority == "magnets") {
    for ( i = [0 : x-1] ) {
        translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) openvlex_magnet_negative();
        translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) openvlex_magnet_wall_window();
        if (shape == "square") {
            translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) openvlex_magnet_negative();
            translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) openvlex_magnet_wall_window();
        }
    }
  }
}

module openvlex_magnetic_lower_filter(x,y,square_basis) {
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
}

module openvlex_magnetic_upper_filter(x,y,square_basis) {
    // cut away lower part:
    translate([-0.1,-0.1,-0.1])
        cube([square_basis*x+0.2,square_basis*y+0.2,0.61 +0.1]);
}

module openvlex_square_negative(x,y,square_basis,edge_width) {
    openvlex_sockets_negative(x,y,square_basis);
    
    if (lock == "openlock" || lock == "triplex") {
        openvlex_openlock_chamber_negative(x,y,square_basis);
    } else if (lock == "dragonlock") {
        connector_negative(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority);
        if (x > 1 && y > 1) {
            dragonlock_nub(square_basis);
            translate([square_basis*x,0,0]) rotate([0,0,90]) dragonlock_nub(square_basis);
            translate([square_basis*x,square_basis*y,0]) rotate([0,0,180]) dragonlock_nub(square_basis);
            translate([0,square_basis*y,0]) rotate([0,0,270]) dragonlock_nub(square_basis);
        }
    }
    
    if (magnet_hole > 0) {
        openvlex_magnets_negative(x,y,square_basis) ;
    }
    
    // if (ov_part == "lower") {
    //     openvlex_magnetic_lower_filter(x,y,square_basis);
    // } else if (ov_part == "upper") {
    //     openvlex_magnetic_upper_filter(x,y,square_basis);
    // }
    
}

module openvlex_negative(x,y,square_basis,edge_width) {
    if(shape == "square") {
        openvlex_square_negative(x,y,square_basis,edge_width);
    } else if (shape == "curved") {
        openvlex_square_negative(x,y,square_basis,edge_width);
    } else {
        assert(false, concat("OpenVLex not supported for shape ", shape)); 
    }
}



module connector_positive_curved(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) {
    intersection() {
        connector_positive_curved_uncropped(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority);
        scale([x,y,1]) cylinder(6,square_basis,square_basis,$fn=200);
    }
}

module connector_positive_curved_uncropped(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) {
    if (x > 1 && x == y) {
        rotate([0,0,22.5])
        translate([square_basis*x,0,0]) rotate([0,0,180])
        center_connector_positive(0,0,magnet_hole,lock,priority);

        rotate([0,0,45])
        translate([square_basis*x,0,0]) rotate([0,0,180])
        joint_connector_positive(0,0,magnet_hole,lock,priority);

        rotate([0,0,67.5])
        translate([square_basis*x,0,0]) rotate([0,0,180])
        center_connector_positive(0,0,magnet_hole,lock,priority);
    }
}


module connector_negative_curved(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) {
    if (x > 1 && x == y) {
        rotate([0,0,22.5])
        translate([square_basis*x,0,0]) rotate([0,0,180])
        center_connector_negative(0,0,magnet_hole,lock,priority);

        rotate([0,0,45])
        translate([square_basis*x,0,0]) rotate([0,0,180])
        joint_connector_negative(0,0,magnet_hole,lock,priority);

        rotate([0,0,67.5])
        translate([square_basis*x,0,0]) rotate([0,0,180])
        center_connector_negative(0,0,magnet_hole,lock,priority);
    }
}

module material_saving_whole_center(x,y,square_basis) {
    translate([square_basis/2+5.5 - 0.01, square_basis/2+5.5 - 0.01, -1])
    cube([square_basis * (x-2) + square_basis - 11 + 0.02, square_basis * (y-2) + square_basis - 11 + 0.02, 10]);
}

module material_saving_stripes(x,y,square_basis) {
    oversize = 5.5;
    for ( i = [0 : x-2] ) {
        translate([square_basis/2+5.5 + i*square_basis - 0.01, square_basis/2+5.5 - 0.01 - oversize, -1])
        cube([square_basis - 11 + 0.02, square_basis * (y-2) + square_basis - 11 + 0.02 + oversize*2, 10]);
    }
}

module material_saving_checker(x,y,square_basis) {
    oversize = 4;
    cw = square_basis - 11 + 0.02; // 14.42
    cl = square_basis - 11 + 0.02 + oversize * 2; // 22.42
    ch = 10;
    bulge = 0.4;
    r = (4*bulge*bulge + 1.4*1.4)/(8*bulge);
    for ( i = [0 : x-2] ) {
        for ( j = [0 : y-2] ) {
            union() {
                translate([(i+1) * square_basis - cw/2, (j+1) * square_basis - cl/2, -1])
                    cube([cw, cl, ch]);
                translate([(i+1) * square_basis - cl/2, (j+1) * square_basis - cw/2, -1])
                    cube([cl, cw, ch]);
            }
        }
    }
}

module material_saving_lock_shaft(x,y,square_basis) {
    cw = square_basis - 11 + 0.01;
    cl = 3; //4;
    ch = 10;
    bar = 3;
    if (x >= 2) {
        for ( i = [1 : x-1] ) {
            translate([i * square_basis - cw/2, square_basis/2 - bar/2 - cl, -1])
                cube([cw, cl, ch]);
            translate([i * square_basis - cw/2, (y-1)*square_basis + square_basis/2 + bar/2, -1])
                cube([cw, cl, ch]);
        }
    }
    if (y >= 2) {
        for ( j = [1 : y-1] ) {
            translate([square_basis/2 - bar/2 - cl, j*square_basis - cw/2, -1])
                cube([cl, cw, ch]);
            translate([(x-1)*square_basis + square_basis/2 + bar/2, j*square_basis - cw/2, -1])
                cube([cl, cw, ch]);
        }
    }
}

module bulges(x,y,square_basis) {
    oversize = 4;
    cl = square_basis - 11 + 0.02 + oversize * 2; // 22.42
    ch = 10;
    bulge = 0.4;
    r = 1.15; // (4*bulge*bulge + 1.4*1.4)/(8*bulge);
    s = 2 * sqrt(2 * r * bulge - bulge*bulge);
    h = square_basis - 11 - 0.01;
    difference() {
        union() {
            if (x >= 2) {
                for ( i = [1 : x-1] ) {
                    for ( j = [1 : y] ) {
                        if (j == 1 || j == y || ov_material_saving == "checker") {
                            translate([i*square_basis, j*square_basis - cl/2 - r + bulge, s/2])
                                rotate([0,90,0]) cylinder(h = h, r = r, center = true, $fn=60); 
                            translate([i*square_basis, j*square_basis - cl/2 - r + bulge, 6-s/2])
                                rotate([0,90,0]) cylinder(h = h, r = r, center = true, $fn=60); 
                            translate([i*square_basis, (j-1)*square_basis + cl/2 + r - bulge, s/2])
                                rotate([0,90,0]) cylinder(h = h, r = r, center = true, $fn=60); 
                            translate([i*square_basis, (j-1)*square_basis + cl/2 + r - bulge, 6-s/2])
                                rotate([0,90,0]) cylinder(h = h, r = r, center = true, $fn=60); 
                        }
                    }
                }
            }
            if (y >= 2) {
                for ( j = [1 : y-1] ) {
                    for ( i = [1 : x] ) {
                        if (i == 1 || i == x || ov_material_saving == "checker") {
                            translate([i*square_basis - cl/2 - r + bulge, j*square_basis, s/2])
                                rotate([90,0,0]) cylinder(h = h, r = r, center = true, $fn=60); 
                            translate([i*square_basis - cl/2 - r + bulge, j*square_basis, 6-s/2])
                                rotate([90,0,0]) cylinder(h = h, r = r, center = true, $fn=60); 
                            translate([(i-1)*square_basis + cl/2 + r - bulge, j*square_basis, s/2])
                                rotate([90,0,0]) cylinder(h = h, r = r, center = true, $fn=60); 
                            translate([(i-1)*square_basis + cl/2 + r - bulge, j*square_basis, 6-s/2])
                                rotate([90,0,0]) cylinder(h = h, r = r, center = true, $fn=60); 
                        }
                    }
                }
            }
        };

        // cut bottom
        translate([0,0,-10]) cube([x*square_basis, y*square_basis, 10]);
        // cut top
        translate([0,0, 6]) cube([x*square_basis, y*square_basis, 10]);

    }

}


module additional_support(x,y,square_basis) {
    oversize = 4;
    cl = square_basis - 11 + 0.02 + oversize * 2; // 22.42
    ch = 10;
    bulge = 0.4;
    r = 1.15; // (4*bulge*bulge + 1.4*1.4)/(8*bulge);
    s = 2 * sqrt(2 * r * bulge - bulge*bulge);
    h = square_basis - 11 - 0.01;
    union() {
        if (x >= 2) {
            for ( i = [1 : x-1] ) {
                translate([i*square_basis - h/2 - 0.8 - 0.01, square_basis/2 - 2 + 0.01, 1.8 + 0.01])
                    rotate([0,90,0])
                    linear_extrude(0.8 + 0.01)
                    polygon(points=[[0,0],[-3.6,0],[-3.6,-3]]);

                translate([i*square_basis - h/2 - 0.01, (y-1) * square_basis + square_basis/2 + 2 - 0.01, 1.8 + 0.01])
                    rotate([0,90,180])
                    linear_extrude(0.8 + 0.01)
                    polygon(points=[[0,0],[-3.6,0],[-3.6,-3]]);

                translate([i*square_basis + h/2 + 0.01, square_basis/2 - 2 + 0.01, 1.8 + 0.01])
                    rotate([0,90,0])
                    linear_extrude(0.8 + 0.01)
                    polygon(points=[[0,0],[-3.6,0],[-3.6,-3]]);

                translate([i*square_basis + h/2 + 0.8 + 0.01, (y-1) * square_basis + square_basis/2 + 2 - 0.01, 1.8 + 0.01])
                    rotate([0,90,180])
                    linear_extrude(0.8 + 0.01)
                    polygon(points=[[0,0],[-3.6,0],[-3.6,-3]]);
            }
        }
        if (y >= 2) {
            for ( j = [1 : y-1] ) {
                translate([square_basis/2 - 2 + 0.01, j*square_basis - h/2 - 0.01, 1.8 + 0.01])
                    rotate([0,90,270])
                    linear_extrude(0.8 + 0.01)
                    polygon(points=[[0,0],[-3.6,0],[-3.6,-3]]);

                translate([(x-1) * square_basis + square_basis/2 + 2 - 0.01, j*square_basis - h/2 - 0.8 - 0.01, 1.8 + 0.01])
                    rotate([0,90,90])
                    linear_extrude(0.8 + 0.01)
                    polygon(points=[[0,0],[-3.6,0],[-3.6,-3]]);

                translate([square_basis/2 - 2 + 0.01, j*square_basis + h/2 + 0.8 + 0.01, 1.8 + 0.01])
                    rotate([0,90,270])
                    linear_extrude(0.8 + 0.01)
                    polygon(points=[[0,0],[-3.6,0],[-3.6,-3]]);

                translate([(x-1) * square_basis + square_basis/2 + 2 - 0.01, j*square_basis + h/2 + 0.01, 1.8 + 0.01])
                    rotate([0,90,90])
                    linear_extrude(0.8 + 0.01)
                    polygon(points=[[0,0],[-3.6,0],[-3.6,-3]]);
            }
        }
    };

}



/*
 * Top Level Function
 */
module base(x,y,square_basis,
        shape="square",magnet_hole=6,lock="false",priority="magnets",dynamic_floors="false",curvedconcave="false") {
    df = dynamic_floors == "true" ? true : false;
    edge_width = magnet_hole >= 5.55 ? magnet_hole + 1 : 6.55;

    difference() {
        union() {
            difference() {
                union() {
                    difference() {
                        
                        union() {
                            plain_base(x,y,square_basis,lock,shape,edge_width);
                            if(df) {
                                df_positive(x,y,square_basis,shape,edge_width);
                            }
                            connector_positive(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) ;
                            if (shape == "curved") {
                                connector_positive_curved(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority);
                            }
                        }
                        
                        if(df) {
                            df_negative(x,y,square_basis, shape, edge_width);
                        }
                        connector_negative(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority);
                        if (shape == "curved") {
                            connector_negative_curved(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority);
                        }
                    }

                    if (ov_sockets != "none") {
                        openvlex_positive(x,y,square_basis,edge_width);
                    }
                }

                if (ov_sockets != "none") {
                    openvlex_negative(x,y,square_basis,edge_width);
                }

                if (x >= 2 && y >= 2) {
                    if (ov_material_saving == "whole_center") {
                        material_saving_checker(x, y, square_basis);
                        material_saving_whole_center(x, y, square_basis);
                    } else if (ov_material_saving == "checker") {
                        material_saving_checker(x, y, square_basis);
                    }
                }
                
                if (ov_material_saving == "checker" || ov_material_saving == "whole_center") {
                    material_saving_lock_shaft(x, y, square_basis);
                }
            };

            if (x >= 1 && y >= 1) {
                if (ov_material_saving == "checker" || ov_material_saving == "whole_center") {
                    bulges(x, y, square_basis);
                }
            }

            if (ov_material_saving == "checker" || ov_material_saving == "whole_center") {
                additional_support(x, y, square_basis); // this one is necessary for bridging the additional lock shaft top hole on the side
            }
        };

        if (ov_part == "lower") {
            openvlex_magnetic_lower_filter(x,y,square_basis);
        } else if (ov_part == "upper") {
            openvlex_magnetic_upper_filter(x,y,square_basis);
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

if (ov_part == "sockets_only") {

    color("red") 
    openvlex_sockets_negative(x,y,square_basis_number);
    
//    if (ov_sockets == "radial") {
//        // draw a block below for easier aligning with custom tiles:
//        color("grey") 
//        translate([0,0,-100.0])
//            cube([x*square_basis_number,y*square_basis_number,0.01]);
//    }

} else if (ov_part == "bottom_sockets") {

    color("orange")
    openvlex_sockets_negative(x,y,square_basis_number, top=false);

//    if (ov_sockets == "radial") {
//        // draw a block below for easier aligning with custom tiles:
//        color("grey") 
//        translate([0,0,-100.0])
//            cube([x*square_basis_number,y*square_basis_number,0.01]);
//    }
    
} else {

    if(lock == "infinitylock" && !valid_infinitylock_basis) {
        echo("ERROR: infinitylock is only compatible with inch basis");
    } else {
        /*color("Grey")*/
        base(x,y,square_basis_number,shape=shape,magnet_hole=magnet_hole,lock=lock,priority=priority,dynamic_floors=dynamic_floors);
    }
    
}

//plain_base(x,y,square_basis_number,shape,7);