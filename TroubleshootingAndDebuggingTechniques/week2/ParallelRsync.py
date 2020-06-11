#!/usr/bin/env python

#Run Rsync in Parallel
from multiprocessing import Pool
import subprocess
import os

src = "/home/student-03-526ffa422206/data/prod/"
dest = "/home/student-03-526ffa422206/data/prod_backup/"

folders = ['alpha',  'beta', 'delta',  'gamma',  'kappa',  'omega',  'sigma']
srcdir = []

for folder in folders:
  srcdir.append(src + folder)

def run(task):
  subprocess.call(["rsync", "-arq", task, dest])

if __name__ == "__main__":
  p = Pool(len(srcdir))
  p.map(run, srcdir)

