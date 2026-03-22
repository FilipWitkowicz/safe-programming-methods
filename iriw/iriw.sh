#!/bin/bash
#SBATCH -J iriw
#SBATCH -p hgx
#SBATCH -w obl[1-2]
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 256
#SBATCH --time=00:20:00
#SBATCH --output=iriw_slurm_log.txt

g++ -O3 -pthread iriw.cpp -o iriw
time ./iriw 128 10000000 >> iriw_result.csv