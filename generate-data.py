#!/usr/bin/python

from __future__ import print_function

import os
from os.path import splitext, join
import subprocess
import sys
import time

TEST_EXT = '.ml'
BASELINE_EXT = '.out'
FLAGS = ['-nosugar', '-data', '-noincomplete-warning']

def find_tests(root):
    tests = []
    for path, dirs, files in os.walk(root):
        files = [(f[0], f[1]) for f in [splitext(f) for f in files]]
        tests.extend([(path, f[0]) for f in files if f[1] == TEST_EXT])
    return tests

def parse_data(line):
    tokens = line.strip().split(',')
    return { "name" : tokens[0], "examples" : int(tokens[1]), "size" : int(tokens[2]), "time" : float(tokens[3]) }

def print_data(prog, path, base, trials):
    cmd = [prog] + FLAGS + [join(path, base + TEST_EXT)]
    data = parse_data(subprocess.check_output(cmd, stderr=subprocess.STDOUT))
    for i in range(0, trials-1):
        data["time"] += parse_data(subprocess.check_output(cmd, stderr=subprocess.STDOUT))["time"]
    data["time"] /= float(trials)
    print("{0},{1},{2},{3}".format(data["name"], data["examples"], data["size"], data["time"]))

def print_usage(args):
    print("Usage: {0} <prog> <test|testdir> <#/trials>".format(args[0]))

def main(args):
    if len(args) == 4:
        prog = args[1]
        path = args[2]
        trials = int(args[3])
        if not os.path.exists(prog):
            print_usage(args)
        elif os.path.exists(path) and os.path.isdir(path):
            for path, base in find_tests(path):
                print_data(prog, path, base, trials)
        else:
            path, filename = os.path.split(path)
            base, ext = splitext(filename)
            if ext != TEST_EXT:
                print_usage(args)
            else:
                print_data(prog, path, base, trials)
    else:
        print_usage(args)

if __name__ == '__main__':
    main(sys.argv)
