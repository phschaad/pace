#!/bin/bash
#SBATCH --uenv=prgenv-gnu/24.11:v1
#SBATCH --view=modules
#SBATCH --constraint=gpu
#SBATCH --job-name=c180_gpu
#SBATCH --ntasks=6
#SBATCH --output=/iopsstor/scratch/cscs/phschaad/stdout_c180_gpu.out
#SBATCH --time=04:00:00
#SBATCH --gpus=6
#SBATCH --account=a-g34
#SBATCH --partition=normal
########################################################

set -x

module load boost cmake cray-mpich cuda gcc hdf5 nccl

export CPATH=$CPATH:/user-environment/linux-sles15-neoverse_v2/gcc-13.3.0/cray-mpich-8.1.30-wb5peugemrg2ebx7psp2iz2abmqy3rgz/include

export MPICH_RDMA_ENABLED_CUDA=1
export MPICH_GPU_SUPPORT_ENABLED=1
export FV3_DACEMODE=BuildAndRun
export PACE_FLOAT_PRECISION=64
export PACE_LOGLEVEL=INFO
export PYTHONOPTIMIZE=1
export OMP_NUM_THREADS=24
export GT_CACHE_ROOT=/iopsstor/scratch/cscs/phschaad/c180_gpu_gtcache

srun -n 6 conda run --name FV3_clariden python -m pace.run $HOME/Repos/NOAA_pace/examples/configs/baroclinic_c180_gpu.yaml

