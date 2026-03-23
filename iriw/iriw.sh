#!/bin/bash
#SBATCH -J iriw
#SBATCH -p pmem
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 96
#SBATCH --time=00:20:00
#SBATCH --output=iriw_slurm_log.txt

g++ -O3 -pthread iriw.cpp -o iriw

echo "=== NUMA topology ==="
lscpu --parse=CPU,CORE,SOCKET | grep -v '#' | awk -F, '{print "Thread "$1" -> Socket "$3}' | head -10
echo "..."
lscpu --parse=CPU,CORE,SOCKET | grep -v '#' | awk -F, '{print "Thread "$1" -> Socket "$3}' | tail -10

time ./iriw 48 10000000 48 >> iriw_result.csv