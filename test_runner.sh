#!/bin/bash
#SBATCH --uenv=prgenv-gnu/24.11:v1
#SBATCH --view=modules
#SBATCH --job-name=env_test
#SBATCH --ntasks=1
#SBATCH --output=log.out
#SBATCH --time=00:05:00
#SBATCH --account=a-g34
#SBATCH --partition=debug
########################################################

set -x

module load boost cmake cray-mpich cuda gcc hdf5 nccl
echo $(ml)

export CPATH=$CPATH:/user-environment/linux-sles15-neoverse_v2/gcc-13.3.0/cray-mpich-8.1.30-wb5peugemrg2ebx7psp2iz2abmqy3rgz/include

export MPICH_RDMA_ENABLED_CUDA=1
export MPICH_GPU_SUPPORT_ENABLED=1
export FV3_DACEMODE=BuildAndRun
export PACE_FLOAT_PRECISION=64
export PACE_LOGLEVEL=INFO
export PYTHONOPTIMIZE=1
export OMP_NUM_THREADS=24
export GT_CACHE_ROOT=/sometestpath/ok

echo $(which python)
srun -n 1 conda run --name FV3_clariden python -c "import os; print(os.environ['FV3_DACEMODE']); print(os.environ['GT_CACHE_ROOT'])"

