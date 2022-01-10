# OpenVLex Plain Riser Stacking System


## About

The new OpenVLex stackable riser system makes it possible to stack risers of any [OpenForge risers](https://mmf.io/o/192663) compatible height by simply snapping them together.

  ![Plain Riser System](../img/plain-riser-system.png)

Simply reuse standard OpenVLex bases (>= v2.4) together with "snappy" interlayer parts (green) or platform parts for the top most layer (blue).

### Save material and be flexible!

  ![Plain Riser - Saving Parts and Material](../img/plain-riser-saving-parts.png)

In the picture above a 2x4 medium riser is built just from three standard OpenVLex bases (grey) with four 2x1 riser interlayers (green) and two 2x2 riser platforms (blue).

## Instructions

### Plain Platform Riser

Simply print one piece of `plain#riser+square,platform.1x1.openvlex.stl`, `plain#riser+square,platform.2x1.openvlex.stl`, or `plain#riser+square,platform.2x2.openvlex.stl` and enjoy the snapping when applied to an OpenVLex 2.4 base!

  ![Plain Riser - gluing](../img/plain-riser-snap.png)

### Interlayer Riser

For one interlayer part print two pieces of `plain#riser+square,interlayer_half.2x1.openvlex.stl` or `plain#riser+square,interlayer_half.2x2.openvlex.stl` and glue them together at the flat plain sides.

  ![Plain Riser - gluing](../img/plain-riser-gluing.png)
  
By combining several Interlayer Risers together with a Platform Riser and OpenVLex bases you can build every possible riser height. See pictures above!

### Special 1x1 Risers

The new riser vertical locking system cannot be used for 1x1 parts because there is no space for that locking mechanism. Instead, special 1x1 risers are provided which use the standard OpenVLex socket to give "plug-and-play" risers.

#### Platform 1x1 Riser

Simply print one piece of the 1x1 platform riser (`plain#riser+square,platform.1x1.openvlex.stl`) and plug it into a standard 1x1 OpenVLex base (`plain#base+square.1x1.openlock,openvlex.stl`).

  ![Plain 1x1 Platform Riser - gluing](../img/plain-riser-1x1-platform.png)

#### Low, Medium, and 1x1 High Riser

For an [OpenForge plain riser](https://mmf.io/o/192663) compatible low riser, print two pieces of the 1x1 platform riser (`plain#riser+square,platform.1x1.openvlex.stl`) and two standard 1x1 OpenVLex bases (`plain#base+square.1x1.openlock,openvlex.stl`). Glue **one** riser and **one** base part together as shown in the following picture:

  ![Plain 1x1 Low, Medium, High Riser](../img/plain-riser-1x1-low.png)
  
For medium and high risers, create multiple glued together 1x1 platform risers and standard 1x1 OpenVLex bases. You can then stack them to the height you need by simply plugging them together.

There is also a ready-to-use 1x1 low riser (`plain#riser+square,low.1x1.openvlex.stl`) which can be used as an alternative to the glued low riser.

### Facade Level Support Riser

This special facade level support blocks can be plugged into OpenVLex bases from the bottom to raise upper floor levels to a height which matches [OpenForge Facade](https://mmf.io/o/139980) parts. See blue block in sample picture below:

  ![1x1 Riser - gluing](../img/facade-level-adapter-sample.png)
  
These blocks are especially useful in corners to hold the upper level in place and aligned with the lower level.

### Printing Notes for Plain Risers

- Material: PLA or PETG
- Nozzle: 0.4 mm
- Layer height: 0.10 mm
- Fill Density: 10% to 15%
