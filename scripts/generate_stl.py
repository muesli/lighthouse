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

import openscad

logging.basicConfig(level=logging.DEBUG)

def generate_stl(input_name, output_folder, output_name, variables):
    openscad.run(
        input_name,
        os.path.join(output_folder, output_name),
        variables = variables,
    )

output_folder = os.path.join('build', 'stl')

shutil.rmtree(output_folder, ignore_errors=True)
os.makedirs(output_folder)

variables = {}
for i in range(1, int(len(sys.argv)/2)):
    variables.update({sys.argv[i*2] : sys.argv[i*2+1]})

generate_stl(sys.argv[1], output_folder, "render.stl", variables)
