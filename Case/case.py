#!/usr/bin/env python3
# Copyright (C) 2013-2017 Florian Festi
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

from boxes import *
import sys

class Case(Boxes):
    """Closed box with screw on top and mounting holes"""

    ui_group = "Box"
    def __init__(self):
        Boxes.__init__(self)
        self.addSettingsArgs(edges.FingerJointSettings)
        self.addSettingsArgs(edges.LidSettings)
        self.buildArgParser("x", "y", "h", "outside")
        self.argparser.add_argument(
            "--triangle", action="store", type=float, default=25.,
            help="Sides of the triangles holding the lid in mm")
        self.argparser.add_argument(
            "--d3", action="store", type=float, default=3.,
            help="Diameter of the mounting screw holes in mm")
        self.argparser.add_argument(
            "--outsidemounts", action="store", type=boolarg, default=True,
            help="Add external mounting points")
        self.argparser.add_argument(
            "--holedist", action="store", type=float, default=7.,
            help="Distance of the screw holes from the wall in mm")

    def front(self):
        self.hole(motion_x, motion_y, d=motion_diam)
        self.hole(volume_x, volume_y, d=volume_diam)

    def right(self):
        self.rectangularHole(socket_x, socket_y, socket_w, socket_h);
        self.rectangularHole(power_x, power_y, power_w, power_h);

    def pcb_frame(self, idx):
        screw_distance=(0,0)
        sizes = [[self.x, screw_distance[0]], [self.y, screw_distance[1]]]
        if idx % 2 == 0:
            sizes.reverse()
        ((length, screw_x_dist), (width, screw_y_dist)) = sizes
        """
        screw_x = (length - screw_x_dist) / 2
        screw_y = (width - screw_y_dist) / 2

        self.hole(screw_x, screw_y, d=screw_diam)
        """
        self.hole(screw_xy + pcb_margin[idx-1], screw_xy + pcb_margin[idx], d=screw_diam)

        # This draws the frame from the far side back towards to the
        # original origin, so burn is corrected to the right side
        self.moveTo(length - frame_w - pcb_margin[(idx+1)%4], pcb_margin[(idx)%4] + frame_w + frame_r + self.burn, 180)
        self.corner(90, frame_r)
        self.corner(-90)
        self.edge(length - frame_r * 2 - frame_w * 2 - pcb_margin[(idx-1)%4] - pcb_margin[(idx+1)%4])

    def render(self):

        t = self.thickness
        #self.h = h = self.h + 2*t # compensate for lid
        x, y, h = self.x, self.y, self.h

        # X is left-to-right, Y is back-to-front
        # Front
        self.rectangularWall(x, h, "fFNF", callback=[self.front], move="right")
        # Right
        self.rectangularWall(y, h, "ffLf", callback=[self.right], move="up right")
        # Left
        self.rectangularWall(y, h, "ffef", callback=[], move="left")
        # Back
        self.rectangularWall(x, h, "fFMF", callback=[], move="up left")

        # Flanged bottom
        self.flangedWall(x, y, edges="FFFF",
                         flanges=[0, flange_size, 0, flange_size], r=flange_size / 2,
                         callback=[lambda:self.hole(flange_hole_dist, flange_hole_dist, d=flange_hole_diam)] * 4, move='up')

        # Sliding lid
        self.rectangularWall(y, x + lid_size_play, "Qnlm", move="right")

        # PCB mounting frame
        self.rectangularWall(y, x, "eeee", callback=self.pcb_frame)

if __name__ == '__main__':
    box = Case()
    box.parseArgs(sys.argv[1:])

    # PCB dimensions
    pcb_thickness = 1.6
    pcb_x = 95
    pcb_y = 61

    # Space around the PCB within the case. Originally intended to be
    # 1mm or so, but increased on the right (and left for consistency)
    # so the RJ jack does not stick into the case side (which prevents
    # lowering the PCB into the case). Also increased in the back to
    # have some room to tilt out the PCB, but not in the front (so the
    # potmeter still ends up against the case).
    # [left, front, right, back]
    pcb_margin = [4.5, 1, 4.5, 9]

    # Material thickness
    box.thickness = 2.8

    # Burn is the compensation, so half the cutting width
    box.burn = 0.4 / 2
    box.x = pcb_x + pcb_margin[0] + pcb_margin[2]
    box.y = pcb_y + pcb_margin[1] + pcb_margin[3]
    # Volume control is the highest, add thickness of PCB, mounting
    # frame and a bit of play
    box.h = 20.5 + pcb_thickness + box.thickness + 0.5

    # Dimension of the mounting flanges
    flange_size = 20
    flange_hole_dist = 7
    flange_hole_diam = 3.5

    # Do not print a scale reference
    box.reference = False

    # A little extra play to fit the fingers. Value is relative to
    # thickness!
    box.edgesettings['FingerJoint']['play'] = 0.08
    box.edgesettings['FingerJoint']['surroundingspaces'] = 1
    # A little extra play for sliding. Value is relative to thickness!
    box.edgesettings['Lid']['play'] = 0.15
    # Increase space size to get just two fingers on the end of the lid
    # (to prevent holes very nearby the power connector hole and make it
    # easier to close the box)
    box.edgesettings['Lid']['finger'] = 2
    box.edgesettings['Lid']['space'] = 14
    box.edgesettings['Lid']['surroundingspaces'] = 0
    # Add a bit extra space above the lid, otherwise the notches that
    # hold the lid are prone to breaking. Value is relative to
    # thickness!
    box.edgesettings['Lid']['edge_width'] = 2
    # The spring was not really positioned correctly by default, so just
    # skip it
    box.edgesettings['Lid']['spring'] = "none"


    # A little extra length for the lid so there is a bit of room to
    # drop it in. This is probably better added at the hole for the
    # second pin, but that's not so easy.
    lid_size_play = 1

    # Measured from PCB top to center of motion detector, add
    # thickness of PCB and mounting frame.
    motion_y = 12 + pcb_thickness + box.thickness
    motion_x = box.x / 2
    motion_diam = 10 + 0.5

    # Value from Piher PC16 potmeter datasheet, PCB top to center of volume
    # knob. Add thickness of PCB and mounting frame.
    volume_y = 12.5 + pcb_thickness + box.thickness
    volume_x = box.x - (27 + pcb_margin[2])
    volume_diam = 10 + 0.5

    # Value from Molex connector datasheet, PCB top to center of socket.
    # Add thickness of PCB and mounting frame.
    socket_y = 11.5/2 + pcb_thickness + box.thickness
    socket_x = 15.8 + pcb_margin[1]
    socket_w = 13.21 + 1
    socket_h = 11.5 + 1
    # Extend 2mm downard for the connector release clip
    socket_y -= 1
    socket_h += 2

    power_y = 14.2 + pcb_thickness + box.thickness
    # Slightly off-center to accomodate connectors that are larger on
    # the upper side
    power_y += 0.5
    power_x = 40 + pcb_margin[1]
    power_w = 7.5 + 4
    power_h = 3 + 6

    # Width of mounting frame bezels, excluding pcb_margin
    frame_w = 0.8
    # Radius of the corners in the mounting frame. Measured from corner
    # of PCB to desired edge, but applied from edge of bezel, so
    # compensate for that
    frame_r = 8.5 - frame_w

    # Distance between PCB edge and screw holes (Is 4.5mm in the PCB
    # design, but somehow the lasercutter would offset the holes
    # slightly, especially in the x axis...)
    screw_xy = 4.3
    screw_diam = 2

    box.open()
    box.render()
    box.close()
