#!/usr/bin/env python

#   Copyright 2015-2016 Scott Bezek and the splitflap contributors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


from __future__ import division
from __future__ import print_function

import errno
import functools
import logging
import os
import shutil
import subprocess
import sys

from multiprocessing.dummy import Pool

import openscad

logging.basicConfig(level=logging.DEBUG)

def generate_gif(output_folder, output_name):
    command = [
        'convert',
        os.path.join(output_folder, 'frame*.png'),
        '-set', 'delay', '1x10',
        os.path.join(output_folder, output_name),
    ]
    logging.debug(command)
    subprocess.check_call(command)

def render_rotation(output_folder, input_name, cam_distance, num_frames, start_frame, variables):
    def render_frame(i):
        angle = 135 + i * 360 / num_frames
        openscad.run(
            input_name,
            os.path.join(output_folder, 'frame_%05d.png' % (start_frame + i)),
            output_size = [640, 480],
            camera_translation = [0, 0, 0],
            camera_rotation = [60, 0, angle],
            camera_distance = cam_distance,
            variables = variables,
            colorscheme = 'Nature',
        )
    pool = Pool()
    for _ in pool.imap_unordered(render_frame, range(num_frames)):
        # Consume results as they occur so any exception is rethrown
        pass
    pool.close()
    pool.join()

output_folder = os.path.join('build', 'animation')

shutil.rmtree(output_folder, ignore_errors=True)
os.makedirs(output_folder)

num_frames = 50
cam_distance = 200
if len(sys.argv) > 3:
    cam_distance = float(sys.argv[3])

render_rotation(output_folder, sys.argv[1], cam_distance, num_frames, 0, {
    'render_enclosure': 1,
})

generate_gif(output_folder, sys.argv[2])
