#!/bin/bash
#SBATCH -J iriw
#SBATCH -p obl
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 128
#SBATCH --time=00:20:00
#SBATCH --output=iriw_slurm_log.txt

g++ -O3 -pthread iriw.cpp -o iriw

echo "=== HOST ==="
hostname

echo "=== CPU INFO ==="
lscpu | grep -E "Model name|Socket|Core|Thread|CPU\(s\):|NUMA"

echo "=== FULL TOPOLOGY ==="
lscpu --parse=CPU,CORE,SOCKET | grep -v '#'


time ./iriw 128 10000000 64 >> iriw_result.csv