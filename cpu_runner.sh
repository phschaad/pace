#!/bin/bash
#SBATCH --uenv=prgenv-gnu/24.11:v1
#SBATCH --view=modules
#SBATCH --job-name=c180_cpu
#SBATCH --ntasks=96
#SBATCH --output=/iopsstor/scratch/cscs/phschaad/second_stdout_c180_cpu.out
#SBATCH --time=00:40:00
#SBATCH --account=a-g34
#SBATCH --partition=normal
########################################################

set -x

module load boost cmake cray-mpich cuda gcc hdf5 nccl

export CPATH=$CPATH:/user-environment/linux-sles15-neoverse_v2/gcc-13.3.0/cray-mpich-8.1.30-wb5peugemrg2ebx7psp2iz2abmqy3rgz/include

export MPICH_RDMA_ENABLED_CUDA=1
export MPICH_GPU_SUPPORT_ENABLED=1
export FV3_DACEMODE=Build
export PACE_FLOAT_PRECISION=64
export PACE_LOGLEVEL=INFO
export PYTHONOPTIMIZE=1
export OMP_NUM_THREADS=1
export GT_CACHE_ROOT=/iopsstor/scratch/cscs/phschaad/second_c180_cpu_gtcache

srun -n 96 conda run --name FV3_clariden --no-capture-output python -m pace.run $HOME/Repos/NOAA_pace/examples/configs/baroclinic_c180_cpu.yaml

