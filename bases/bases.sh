#!/bin/bash

set -e

: ${OPENSCAD:="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"}
: ${CONVERTSTL:="./convertSTL.rb"}
#declare -a style=("plain" "stone")
declare -a style=("plain")
declare -a boolean=("union" "difference")
#declare -a square_basis=("25mm" "inch" "wyloch")
#declare -a square_basis=("25mm" "inch")
declare -a square_basis=("inch")
#declare -a shape=("square" "curved" "diagonal")
declare -a shape=("square")
#declare -a largecurved=("a" "b" "c")
#declare -a largecurvedsize=("6" "8")
#declare -a odddiagonalsize=("2" "4")


##
## 1x1 - 4x4, square, diagonal, curved
##

for style in "${style[@]}"
do
	for basis in "${square_basis[@]}"
	do
		for s in "${shape[@]}"
		do
			for x in {1..8}
			do
				for y in {1..8}
				do

 				  if [ $x -ge $y ] ; then

					#
					# openlock,openvlex
					#
						mkdir -p _out/openlock,openvlex
					$OPENSCAD -o _out/openlock,openvlex/$style#base+$s.${x}x${y}.openlock,openvlex.stl \
						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
						-D "shape=\"$s\"" \
						-D "style=\"${style}\"" \
						-D "topless=\"false\"" \
						-D "lock=\"triplex\"" -D "magnet_hole=0" -D 'priority="lock"' \
						-D "ov_sockets=\"square\"" \
						-D "ov_part=\"all\"" \
						-D "ov_additional_stability_bars=\"true\"" \
						-D "ov_material_saving=\"checker\"" \
						bases.scad

					#
					# magnetic,openlock,openvlex+single_part
					#
						mkdir -p _out/magnetic,openlock,openvlex+single_part
					$OPENSCAD -o _out/magnetic,openlock,openvlex+single_part/$style#base+$s.${x}x${y}.magnetic,openlock,openvlex+single_part.stl \
						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
						-D "shape=\"$s\"" \
						-D "style=\"${style}\"" \
						-D "topless=\"false\"" \
						-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' \
						-D "ov_sockets=\"square\"" \
						-D "ov_part=\"all\"" \
						-D "ov_additional_stability_bars=\"false\"" \
						-D "ov_material_saving=\"checker\"" \
						bases.scad

					#
					# magnetic,openlock,openvlex+upper_part
					#
						mkdir -p _out/magnetic,openlock,openvlex+dual_parts
					$OPENSCAD -o _out/magnetic,openlock,openvlex+dual_parts/$style#base+$s.${x}x${y}.magnetic,openlock,openvlex+upper_part.stl \
						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
						-D "shape=\"$s\"" \
						-D "style=\"${style}\"" \
						-D "topless=\"false\"" \
						-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' \
						-D "ov_sockets=\"square\"" \
						-D "ov_part=\"upper\"" \
						-D "ov_additional_stability_bars=\"false\"" \
						-D "ov_material_saving=\"checker\"" \
						bases.scad

					#
					# magnetic,openlock,openvlex+lower_part
					#
						mkdir -p _out/magnetic,openlock,openvlex+dual_parts
					$OPENSCAD -o _out/magnetic,openlock,openvlex+dual_parts/$style#base+$s.${x}x${y}.magnetic,openlock,openvlex+lower_part.stl \
						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
						-D "shape=\"$s\"" \
						-D "style=\"${style}\"" \
						-D "topless=\"false\"" \
						-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' \
						-D "ov_sockets=\"square\"" \
						-D "ov_part=\"lower\"" \
						-D "ov_additional_stability_bars=\"false\"" \
						-D "ov_material_saving=\"checker\"" \
						bases.scad

					if [ $x -gt 2 ] && [ $y -gt 2 ] ; then

						#
						# openlock,openvlex+border_only
						#
							mkdir -p _out/openlock,openvlex
						$OPENSCAD -o _out/openlock,openvlex/$style#base+$s.${x}x${y}.openlock,openvlex+border_only.stl \
							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
							-D "shape=\"$s\"" \
							-D "style=\"${style}\"" \
							-D "topless=\"false\"" \
							-D "lock=\"triplex\"" -D "magnet_hole=0" -D 'priority="lock"' \
							-D "ov_sockets=\"square\"" \
							-D "ov_part=\"all\"" \
							-D "ov_additional_stability_bars=\"true\"" \
							-D "ov_material_saving=\"whole_center\"" \
							bases.scad

						#
						# magnetic,openlock,openvlex+border_only,single_part
						#
							mkdir -p _out/magnetic,openlock,openvlex+single_part
						$OPENSCAD -o _out/magnetic,openlock,openvlex+single_part/$style#base+$s.${x}x${y}.magnetic,openlock,openvlex+border_only,single_part.stl \
							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
							-D "shape=\"$s\"" \
							-D "style=\"${style}\"" \
							-D "topless=\"false\"" \
							-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' \
							-D "ov_sockets=\"square\"" \
							-D "ov_part=\"all\"" \
							-D "ov_additional_stability_bars=\"false\"" \
							-D "ov_material_saving=\"whole_center\"" \
							bases.scad

						#
						# magnetic,openlock,openvlex+border_only,upper_part
						#
							mkdir -p _out/magnetic,openlock,openvlex+dual_parts
						$OPENSCAD -o _out/magnetic,openlock,openvlex+dual_parts/$style#base+$s.${x}x${y}.magnetic,openlock,openvlex+border_only,upper_part.stl \
							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
							-D "shape=\"$s\"" \
							-D "style=\"${style}\"" \
							-D "topless=\"false\"" \
							-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' \
							-D "ov_sockets=\"square\"" \
							-D "ov_part=\"upper\"" \
							-D "ov_additional_stability_bars=\"false\"" \
							-D "ov_material_saving=\"whole_center\"" \
							bases.scad

						#
						# magnetic,openlock,openvlex+border_only,lower_part
						#
							mkdir -p _out/magnetic,openlock,openvlex+dual_parts
						$OPENSCAD -o _out/magnetic,openlock,openvlex+dual_parts/$style#base+$s.${x}x${y}.magnetic,openlock,openvlex+border_only,lower_part.stl \
							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
							-D "shape=\"$s\"" \
							-D "style=\"${style}\"" \
							-D "topless=\"false\"" \
							-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' \
							-D "ov_sockets=\"square\"" \
							-D "ov_part=\"lower\"" \
							-D "ov_additional_stability_bars=\"false\"" \
							-D "ov_material_saving=\"whole_center\"" \
							bases.scad
					fi

					if [ $x -eq $y ] && [ $x -gt 1 ] && [ $x -lt 5 ] ; then

						#
						# openlock,openvlex+radial
						#
							mkdir -p _out/openlock,openvlex+radial
						$OPENSCAD -o _out/openlock,openvlex+radial/$style#base+$s.${x}x${y}.openlock,openvlex+radial.stl \
							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
							-D "shape=\"$s\"" \
							-D "style=\"${style}\"" \
							-D "topless=\"false\"" \
							-D "lock=\"triplex\"" -D "magnet_hole=0" -D 'priority="lock"' \
							-D "ov_sockets=\"radial\"" \
							-D "ov_part=\"all\"" \
							-D "ov_additional_stability_bars=\"true\"" \
							bases.scad

						#
						# magnetic,openlock,openvlex+radial,upper_part
						#
							mkdir -p _out/magnetic,openlock,openvlex+radial
						$OPENSCAD -o _out/magnetic,openlock,openvlex+radial/$style#base+$s.${x}x${y}.magnetic,openlock,openvlex+radial,upper_part.stl \
							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
							-D "shape=\"$s\"" \
							-D "style=\"${style}\"" \
							-D "topless=\"false\"" \
							-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' \
							-D "ov_sockets=\"radial\"" \
							-D "ov_part=\"upper\"" \
							-D "ov_additional_stability_bars=\"false\"" \
							bases.scad

						#
						# magnetic,openlock,openvlex+radial,lower_part
						#
							mkdir -p _out/magnetic,openlock,openvlex+radial
						$OPENSCAD -o _out/magnetic,openlock,openvlex+radial/$style#base+$s.${x}x${y}.magnetic,openlock,openvlex+radial,lower_part.stl \
							-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
							-D "shape=\"$s\"" \
							-D "style=\"${style}\"" \
							-D "topless=\"false\"" \
							-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' \
							-D "ov_sockets=\"radial\"" \
							-D "ov_part=\"lower\"" \
							-D "ov_additional_stability_bars=\"false\"" \
							bases.scad

					fi


				  fi

				done
			done
		done
	done
done

##
## 1x1 - 4x4 - Curve Concave
##
# for basis in "${square_basis[@]}"
# do
# 	for s in "${shape[@]}"
# 	do
# 		for x in {1..4}
# 		do
# 			for y in {1..4}
# 			do
# 				##
# 				## magnetic
# 				##
# 				echo "curveconcave.$basis.$s.${x}x${y}"
# 				mkdir -p $basis/curveconcave/$s/magnetic/
# 				$OPENSCAD -o $basis/curveconcave/$s/magnetic/base.curveconcave.$s.$basis.${x}x${y}.magnetic.stl \
# 					-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\""\
# 					-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 					-D "style=\"${style}\"" \
# 					-D "topless=\"false\"" \
# 					-D "lock=\"none\"" -D "magnet_hole=6" bases.scad
# 				$CONVERTSTL $basis/curvedconcave/$s/magnetic/base.curvedconcave.$s.$basis.${x}x${y}.magnetic.stl
# 				mv $basis/curvedconcave/$s/magnetic/base.curvedconcave.$s.$basis.${x}x${y}.magnetic-binary.stl $basis/curvedconcave/$s/magnetic/base.curvedconcave.$s.$basis.${x}x${y}.magnetic.stl

# 				##
# 				## magnetic.openlock
# 				##
# 				mkdir -p $basis/curveconcave/$s/magnetic.openlock/
# 				$OPENSCAD -o $basis/curveconcave/$s/magnetic.openlock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.openlock.stl \
# 					-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
# 					-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 					-D "style=\"${style}\"" \
# 					-D "topless=\"false\"" \
# 					-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnetic"' bases.scad
# 				$CONVERTSTL $basis/curveconcave/$s/magnetic.openlock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.openlock.stl
# 				mv $basis/curveconcave/$s/magnetic.openlock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.openlock-binary.stl $basis/curveconcave/$s/magnetic.openlock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.openlock.stl

# 				##
# 				## openlock.magnetic for 1x & x1 square tiles
# 				##
# 				if [[ ( $x == 1 || $y == 1 ) ]] ; then
# 					mkdir -p $basis/curveconcave/$s/magnetic.openlock/
# 					$OPENSCAD -o $basis/curveconcave/$s/magnetic.openlock/base.${style}.$s.$basis.${x}x1.openlock.magnetic.stl \
# 						-D "x=${x}" -D "y=1" -D "square_basis=\"$basis\"" \
# 						-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 						-D "style=\"${style}\"" \
# 						-D "topless=\"false\"" \
# 						-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="lock"' bases.scad
# 					$CONVERTSTL $basis/curveconcave/$s/magnetic.openlock/base.${style}.$s.$basis.${x}x1.openlock.magnetic.stl
# 					mv $basis/curveconcave/$s/magnetic.openlock/base.${style}.$s.$basis.${x}x1.openlock.magnetic-binary.stl $basis/curveconcave/$s/magnetic.openlock/base.${style}.$s.$basis.${x}x1.openlock.magnetic.stl
# 				fi

# 				##
# 				## magnetic.openlock.topless
# 				##
# 				mkdir -p $basis/curveconcave/$s/magnetic.openlock.topless/
# 				$OPENSCAD -o $basis/curveconcave/$s/magnetic.openlock.topless/base.curveconcave.$s.$basis.${x}x${y}.magnetic.openlock.topless.stl \
# 					-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
# 					-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 					-D "style=\"${style}\"" \
# 					-D "topless=\"true\"" \
# 					-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnetic"' bases.scad
# 				$CONVERTSTL $basis/curveconcave/$s/magnetic.openlock.topless/base.curveconcave.$s.$basis.${x}x${y}.magnetic.openlock.topless.stl
# 				mv $basis/curveconcave/$s/magnetic.openlock.topless/base.curveconcave.$s.$basis.${x}x${y}.magnetic.openlock.topless-binary.stl $basis/curveconcave/$s/magnetic.openlock.topless/base.curveconcave.$s.$basis.${x}x${y}.magnetic.openlock.topless.stl

# 				##
# 				## openlock.magnetic.topless for 1x & x1 square tiles
# 				##
# 				if [[ ( $x == 1 || $y == 1 ) ]] ; then
# 					mkdir -p $basis/curveconcave/$s/magnetic.openlock.topless/
# 					$OPENSCAD -o $basis/curveconcave/$s/magnetic.openlock.topless/base.${style}.$s.$basis.${x}x1.openlock.magnetic.topless.stl \
# 						-D "x=${x}" -D "y=1" -D "square_basis=\"$basis\"" \
# 						-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 						-D "style=\"${style}\"" \
# 						-D "topless=\"true\"" \
# 						-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="lock"' bases.scad
# 					$CONVERTSTL $basis/curveconcave/$s/magnetic.openlock.topless/base.${style}.$s.$basis.${x}x1.openlock.magnetic.topless.stl
# 					mv $basis/curveconcave/$s/magnetic.openlock.topless/base.${style}.$s.$basis.${x}x1.openlock.magnetic.topless-binary.stl $basis/curveconcave/$s/magnetic.openlock.topless/base.${style}.$s.$basis.${x}x1.openlock.magnetic.topless.stl
# 				fi

# 				##
# 				## openlock
# 				##
# 				mkdir -p $basis/curveconcave/$s/openlock/
# 				$OPENSCAD -o $basis/curveconcave/$s/openlock/base.curveconcave.$s.$basis.${x}x${y}.openlock.stl \
# 					-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
# 					-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 					-D "style=\"${style}\"" \
# 					-D "topless=\"false\"" \
# 					-D "lock=\"openlock\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
# 				$CONVERTSTL $basis/curveconcave/$s/openlock/base.curveconcave.$s.$basis.${x}x${y}.openlock.stl
# 				mv $basis/curveconcave/$s/openlock/base.curveconcave.$s.$basis.${x}x${y}.openlock-binary.stl $basis/curveconcave/$s/openlock/base.curveconcave.$s.$basis.${x}x${y}.openlock.stl

# 				##
# 				## openlock.triplex
# 				##
# 				mkdir -p $basis/curveconcave/$s/openlock.triplex/
# 				$OPENSCAD -o $basis/curveconcave/$s/openlock.triplex/base.curveconcave.$s.$basis.${x}x${y}.openlock.triplex.stl \
# 					-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
# 					-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 					-D "style=\"${style}\"" \
# 					-D "topless=\"false\"" \
# 					-D "lock=\"triplex\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
# 				$CONVERTSTL $basis/curveconcave/$s/openlock.triplex/base.curveconcave.$s.$basis.${x}x${y}.openlock.triplex.stl
# 				mv $basis/curveconcave/$s/openlock.triplex/base.curveconcave.$s.$basis.${x}x${y}.openlock.triplex-binary.stl $basis/curveconcave/$s/openlock.triplex/base.curveconcave.$s.$basis.${x}x${y}.openlock.triplex.stl

# 				if [ "$basis" = "inch" ]; then
# 					##
# 					## infinitylock
# 					##
# 					mkdir -p $basis/curveconcave/$s/infinitylock/
# 					$OPENSCAD -o $basis/curveconcave/$s/infinitylock/base.curveconcave.$s.$basis.${x}x${y}.infinitylock.stl \
# 						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
# 						-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 						-D "style=\"${style}\"" \
# 						-D "topless=\"false\"" \
# 						-D "lock=\"infinitylock\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
# 					$CONVERTSTL $basis/curveconcave/$s/infinitylock/base.curveconcave.$s.$basis.${x}x${y}.infinitylock.stl
# 					mv $basis/curveconcave/$s/infinitylock/base.curveconcave.$s.$basis.${x}x${y}.infinitylock-binary.stl $basis/curveconcave/$s/infinitylock/base.curveconcave.$s.$basis.${x}x${y}.infinitylock.stl

# 					##
# 					## magnetic.infinitylock
# 					##
# 					mkdir -p $basis/curveconcave/$s/magnetic.infinitylock/
# 					$OPENSCAD -o $basis/curveconcave/$s/magnetic.infinitylock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.infinitylock.stl \
# 						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
# 						-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 						-D "style=\"${style}\"" \
# 						-D "topless=\"false\"" \
# 						-D "lock=\"infinitylock\"" -D "magnet_hole=6" -D "priority=\"magnets\"" bases.scad
# 					$CONVERTSTL $basis/curveconcave/$s/magnetic.infinitylock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.infinitylock.stl
# 					mv $basis/curveconcave/$s/magnetic.infinitylock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.infinitylock-binary.stl $basis/curveconcave/$s/magnetic.infinitylock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.infinitylock.stl

# 					##
# 					## dragonlock
# 					##
# 					mkdir -p $basis/curveconcave/$s/dragonlock/
# 					$OPENSCAD -o $basis/curveconcave/$s/dragonlock/base.curveconcave.$s.$basis.${x}x${y}.dragonlock.stl \
# 						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
# 						-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 						-D "style=\"${style}\"" \
# 						-D "topless=\"false\"" \
# 						-D "lock=\"dragonlock\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
# 					$CONVERTSTL $basis/curveconcave/$s/dragonlock/base.curveconcave.$s.$basis.${x}x${y}.dragonlock.stl
# 					mv $basis/curveconcave/$s/dragonlock/base.curveconcave.$s.$basis.${x}x${y}.dragonlock-binary.stl $basis/curveconcave/$s/dragonlock/base.curveconcave.$s.$basis.${x}x${y}.dragonlock.stl

# 					##
# 					## magnetic.dragonlock
# 					##
# 					mkdir -p $basis/curveconcave/$s/magnetic.dragonlock/
# 					$OPENSCAD -o $basis/curveconcave/$s/magnetic.dragonlock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.dragonlock.stl \
# 						-D "x=${x}" -D "y=${y}" -D "square_basis=\"$basis\"" \
# 						-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 						-D "style=\"${style}\"" \
# 						-D "topless=\"false\"" \
# 						-D "lock=\"dragonlock\"" -D "magnet_hole=6" -D "priority=\"magnetic\"" bases.scad
# 					$CONVERTSTL $basis/curveconcave/$s/magnetic.dragonlock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.dragonlock.stl
# 					mv $basis/curveconcave/$s/magnetic.dragonlock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.dragonlock-binary.stl $basis/curveconcave/$s/magnetic.dragonlock/base.curveconcave.$s.$basis.${x}x${y}.magnetic.dragonlock.stl

# 					##
# 					## dragonlock.magnetic for 1x & x1 square tiles
# 					##
# 					if [[ ( $x == 1 || $y == 1 ) ]] ; then
# 						mkdir -p $basis/curveconcave/$s/magnetic.dragonlock/
# 						$OPENSCAD -o $basis/curveconcave/$s/magnetic.dragonlock/base.${style}.$s.$basis.${x}x1.dragonlock.magnetic.stl \
# 							-D "x=${x}" -D "y=1" -D "square_basis=\"$basis\"" \
# 							-D "shape=\"curved\"" -D "curvedconcave=\"true\"" \
# 							-D "style=\"${style}\"" \
# 							-D "topless=\"false\"" \
# 							-D "lock=\"dragonlock\"" -D "magnet_hole=6" -D 'priority="lock"' bases.scad
# 						$CONVERTSTL $basis/curveconcave/$s/magnetic.dragonlock/base.${style}.$s.$basis.${x}x1.dragonlock.magnetic.stl
# 						mv $basis/curveconcave/$s/magnetic.dragonlock/base.${style}.$s.$basis.${x}x1.dragonlock.magnetic-binary.stl $basis/curveconcave/$s/magnetic.dragonlock/base.${style}.$s.$basis.${x}x1.dragonlock.magnetic.stl
# 					fi
# 				fi
# 			done
# 		done
# 	done
# done

##
## Large Curved Sizes
##

#for style in "${style[@]}"
#do
#	for basis in "${square_basis[@]}"
#	do
#		for tile in "${largecurved[@]}"
#		do
#			for x in "${largecurvedsize[@]}"
#			do
				##
				## magnetic
				##
#				echo "$basis.$style.$tile.${x}x${x}"
#				mkdir -p $basis/$style/curved/magnetic/
#				$OPENSCAD -o $basis/$style/curved/magnetic/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\""\
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"none\"" -D "magnet_hole=6"  bases.scad
#				$CONVERTSTL $basis/$style/curved/magnetic/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.stl
#				mv $basis/$style/curved/magnetic/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic-binary.stl $basis/$style/curved/magnetic/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.stl

#				echo "$basis.$style.$tile.${x}x${x}"
#				mkdir -p $basis/$style/curvedconcave/magnetic/
#				$OPENSCAD -o $basis/$style/curvedconcave/magnetic/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\""\
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "curvedconcave=\"true\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"none\"" -D "magnet_hole=6"  bases.scad
#				$CONVERTSTL $basis/$style/curvedconcave/magnetic/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.stl
#				mv $basis/$style/curvedconcave/magnetic/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic-binary.stl $basis/$style/curvedconcave/magnetic/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.stl

				##
				## magnetic.openlock
				##
#				mkdir -p $basis/$style/curved/magnetic.openlock/
#				$OPENSCAD -o $basis/$style/curved/magnetic.openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
#				$CONVERTSTL $basis/$style/curved/magnetic.openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.stl
#				mv $basis/$style/curved/magnetic.openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock-binary.stl $basis/$style/curved/magnetic.openlock/base.${style}.curved.$basis.${x}x${y}.${tile}.magnetic.openlock.stl

#				mkdir -p $basis/$style/curvedconcave/magnetic.openlock/
#				$OPENSCAD -o $basis/$style/curvedconcave/magnetic.openlock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.openlock.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "curvedconcave=\"true\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
#				$CONVERTSTL $basis/$style/curvedconcave/magnetic.openlock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.openlock.stl
#				mv $basis/$style/curvedconcave/magnetic.openlock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.openlock-binary.stl $basis/$style/curvedconcave/magnetic.openlock/base.${style}.curvedconcave.$basis.${x}x${y}.${tile}.magnetic.openlock.stl

				##
				## magnetic.openlock.topless
				##
#				mkdir -p $basis/$style/curved/magnetic.openlock.topless/
#				$OPENSCAD -o $basis/$style/curved/magnetic.openlock.topless/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.topless.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"true\"" \
#					-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
#				$CONVERTSTL $basis/$style/curved/magnetic.openlock.topless/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.topless.stl
#				mv $basis/$style/curved/magnetic.openlock.topless/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.openlock.topless-binary.stl $basis/$style/curved/magnetic.openlock.topless/base.${style}.curved.$basis.${x}x${y}.${tile}.magnetic.openlock.topless.stl

#				mkdir -p $basis/$style/curvedconcave/magnetic.openlock.topless/
#				$OPENSCAD -o $basis/$style/curvedconcave/magnetic.openlock.topless/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.openlock.topless.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "curvedconcave=\"true\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"true\"" \
#					-D "lock=\"openlock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
#				$CONVERTSTL $basis/$style/curvedconcave/magnetic.openlock.topless/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.openlock.topless.stl
#				mv $basis/$style/curvedconcave/magnetic.openlock.topless/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.openlock.topless-binary.stl $basis/$style/curvedconcave/magnetic.openlock.topless/base.${style}.curvedconcave.$basis.${x}x${y}.${tile}.magnetic.openlock.topless.stl

				##
				## openlock
				##
#				mkdir -p $basis/$style/curved/openlock/
#				$OPENSCAD -o $basis/$style/curved/openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"openlock\"" -D "magnet_hole=0" bases.scad
#				$CONVERTSTL $basis/$style/curved/openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.stl
#				mv $basis/$style/curved/openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock-binary.stl $basis/$style/curved/openlock/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.stl

#				mkdir -p $basis/$style/curvedconcave/openlock/
#				$OPENSCAD -o $basis/$style/curvedconcave/openlock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.openlock.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "curvedconcave=\"true\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"openlock\"" -D "magnet_hole=0" bases.scad
#				$CONVERTSTL $basis/$style/curvedconcave/openlock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.openlock.stl
#				mv $basis/$style/curvedconcave/openlock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.openlock-binary.stl $basis/$style/curvedconcave/openlock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.openlock.stl

				##
				## openlock.triplex
				##
#				mkdir -p $basis/$style/curved/openlock.triplex/
#				$OPENSCAD -o $basis/$style/curved/openlock.triplex/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.triplex.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"triplex\"" -D "magnet_hole=0" bases.scad
#				$CONVERTSTL $basis/$style/curved/openlock.triplex/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.triplex.stl
#				mv $basis/$style/curved/openlock.triplex/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.triplex-binary.stl $basis/$style/curved/openlock.triplex/base.${style}.curved.$basis.${x}x${x}.${tile}.openlock.triplex.stl

#				mkdir -p $basis/$style/curvedconcave/openlock.triplex/
#				$OPENSCAD -o $basis/$style/curvedconcave/openlock.triplex/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.openlock.triplex.stl \
#					-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#					-D "curvedconcave=\"true\"" \
#					-D "style=\"${style}\"" \
#					-D "topless=\"false\"" \
#					-D "lock=\"triplex\"" -D "magnet_hole=0" bases.scad
#				$CONVERTSTL $basis/$style/curvedconcave/openlock.triplex/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.openlock.triplex.stl
#				mv $basis/$style/curvedconcave/openlock.triplex/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.openlock.triplex-binary.stl $basis/$style/curvedconcave/openlock.triplex/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.openlock.triplex.stl

				#if [ "$basis" = "inch" ]; then
					##
					## infinitylock
					##
#					mkdir -p $basis/$style/curved/magnetic.infinitylock/
#					$OPENSCAD -o $basis/$style/curved/magnetic.infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.infinitylock.stl \
#						-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#					-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"infinitylock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
#					$CONVERTSTL $basis/$style/curved/magnetic.infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.infinitylock.stl
#					mv $basis/$style/curved/magnetic.infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.magnetic.infinitylock-binary.stl $basis/$style/curved/magnetic.infinitylock/base.${style}.curved.$basis.${x}x${y}.${tile}.magnetic.infinitylock.stl

#					mkdir -p $basis/$style/curvedconcave/magnetic.infinitylock/
#					$OPENSCAD -o $basis/$style/curvedconcave/magnetic.infinitylock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.infinitylock.stl \
#						-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#						-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#						-D "curvedconcave=\"true\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"infinitylock\"" -D "magnet_hole=6" -D 'priority="magnets"' bases.scad
#					$CONVERTSTL $basis/$style/curvedconcave/magnetic.infinitylock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.infinitylock.stl
#					mv $basis/$style/curvedconcave/magnetic.infinitylock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.magnetic.infinitylock-binary.stl $basis/$style/curvedconcave/magnetic.infinitylock/base.${style}.curvedconcave.$basis.${x}x${y}.${tile}.magnetic.infinitylock.stl

					##
					## magnetic.infinitylock
					##
#					mkdir -p $basis/$style/curved/infinitylock/
#					$OPENSCAD -o $basis/$style/curved/infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.infinitylock.stl \
#						-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#						-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"infinitylock\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
#					$CONVERTSTL $basis/$style/curved/infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.infinitylock.stl
#					mv $basis/$style/curved/infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.infinitylock-binary.stl $basis/$style/curved/infinitylock/base.${style}.curved.$basis.${x}x${x}.${tile}.infinitylock.stl

#					mkdir -p $basis/$style/curvedconcave/infinitylock/
#					$OPENSCAD -o $basis/$style/curvedconcave/infinitylock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.infinitylock.stl \
#						-D "x=${x}" -D "y=${x}" -D "square_basis=\"$basis\"" \
#						-D "shape=\"curved\"" -D "curvedlarge=\"${tile}\"" \
#						-D "curvedconcave=\"true\"" \
#						-D "style=\"${style}\"" \
#						-D "topless=\"false\"" \
#						-D "lock=\"infinitylock\"" -D "magnet_hole=0" -D "priority=\"lock\"" bases.scad
#					$CONVERTSTL $basis/$style/curvedconcave/infinitylock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.infinitylock.stl
#					mv $basis/$style/curvedconcave/infinitylock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.infinitylock-binary.stl $basis/$style/curvedconcave/infinitylock/base.${style}.curvedconcave.$basis.${x}x${x}.${tile}.infinitylock.stl
#				fi
#			done
#		done
#	done
#done
