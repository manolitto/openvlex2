/*
 * OpenVLex Gluing Stencil v2.3
 */

/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6,7,8]
y = 2; //[1,2,3,4,5,6,7,8]

/* [Square Basis] */
// What is the size in mm of a square?
square_basis = "inch"; // [25mm:Dwarven Forge/Hirstarts, inch:OpenLOCK/Dragonlock/Dungeonworks, wyloch:Wyloch]

/* [Shape] */
// What type of tile is this for
shape = "square"; // [square,diagonal,curved,alcove]



/*
 * OpenVLex
 */

module openvlex_positive(x,y,square_basis) {

    corner_h = 8;
    corner_h2 = 1.4;
    corner_l = 5;
    corner_w = 2;

    module nwall() {
        hull() {
            cube([corner_l, corner_w, corner_h]);
            translate([0,corner_w/2,corner_h]) cube([corner_l, corner_w/2, corner_h2]);
        }
    }
    module swall() {
        hull() {
            cube([corner_l, corner_w, corner_h]);
            translate([0,0,corner_h]) cube([corner_l, corner_w/2, corner_h2]);
        }
    }
    module ewall() {
        hull() {
            cube([corner_w, corner_l, corner_h]);
            translate([corner_w/2,0,corner_h]) cube([corner_w/2, corner_l, corner_h2]);
        }
    }
    module wwall() {
        hull() {
            cube([corner_w, corner_l, corner_h]);
            translate([0,0,corner_h]) cube([corner_w/2, corner_l, corner_h2]);
        }
    }

  union() {  
    
    
    translate([0,0,0])
        cube([square_basis*x,square_basis*y,5.0]);
    
    plug_sheet_diam = 10;  
      
    for ( i = [0 : x-1] ) {
        for ( j = [0 : y-1] ) {
            translate([i*square_basis, j*square_basis,0])
            translate([square_basis/2-plug_sheet_diam/2, square_basis/2-plug_sheet_diam/2, 0])
            cube([plug_sheet_diam,plug_sheet_diam,5.7]);
           
        }
    }

      
      
    // corners:
    
    //nw
    union() {
        translate([-corner_w,square_basis*y,0]) nwall();
        translate([-corner_w,square_basis*y-corner_l+corner_w,0]) wwall();
    }
    
    //ne
    union() {
        translate([square_basis*x-corner_l+corner_w,square_basis*y,0]) nwall();
        translate([square_basis*x,square_basis*y-corner_l+corner_w,0]) ewall();
    }
    
    //sw
    union() {
        translate([-corner_w,-corner_w,0]) swall();
        translate([-corner_w,-corner_w,0]) wwall();
    }
    
    //se
    union() {
        translate([square_basis*x-corner_l+corner_w,-corner_w,0]) swall();
        translate([square_basis*x,-corner_w,0]) ewall();
    }
  }


}


module openvlex_negative(x,y,square_basis) {
    
    // diameters bottom to top:
    of_bw_d = 6.8;      // bottom widening diameter
    of_bw_y = 0.0;      // bottom widening y
    of_bw_h = 2.4;      // bottom widening height

    of_hole_d = 3.8;    // OpenVLex hole diameter

    of_tw_d = 4.8;      // top widening diameter
    of_tw_y = 5.0;      // top widening y
    of_tw_h = 0.7;      // top widening height
    
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
           
        }
    }

    // chamfers for easier removing:
    chamfer_w = 4.6;
    chamfer_l = square_basis/2 - 10/2;
    chamfer_y = 4;
    
    for ( i = [0 : x-1] ) {
        translate([i*square_basis+square_basis/2-chamfer_w/2, -0.1, chamfer_y])
        cube([chamfer_w,chamfer_l+0.1,6.1]);

        translate([i*square_basis+square_basis/2-chamfer_w/2, square_basis*y-chamfer_l, chamfer_y])
        cube([chamfer_w,chamfer_l+0.1,6.1]);
    }
    
    for ( j = [0 : y-1] ) {
        translate([-0.1, j*square_basis+square_basis/2-chamfer_w/2, chamfer_y])
        cube([chamfer_l+0.1,chamfer_w,6.1]);

        translate([square_basis*x-chamfer_l, j*square_basis+square_basis/2-chamfer_w/2, chamfer_y])
        cube([chamfer_l+0.1,chamfer_w,6.1]);
    }

    // north markers
    marker_size = 4;
    marker_y = 4.4;
    translate([(square_basis/2-chamfer_w/2)/2,
                square_basis*y-square_basis/4+chamfer_w/4,
                marker_y])
    rotate(90)
    cylinder(h=10, r=marker_size/2, center=false, $fn=3);

    translate([square_basis*x - (square_basis/2-chamfer_w/2)/2,
               square_basis*y-square_basis/4+chamfer_w/4,
               marker_y])
    rotate(90)
    cylinder(h=10, r=marker_size/2, center=false, $fn=3);

}


/*
 * Top Level Function
 */
module base(x,y,square_basis) {
    difference() {
        union() {
            openvlex_positive(x,y,square_basis);
        }
        openvlex_negative(x,y,square_basis);
    }
    
}

function keyLookup (data, key) = search(key, data, num_returns_per_match=1)[0];


basis = [
    ["25mm", 25],
    ["inch", 25.4],
    ["wyloch", 31.75]
];
square_basis_number = basis[keyLookup(basis, [square_basis])][1];

color("Orange") base(x,y,square_basis_number);

