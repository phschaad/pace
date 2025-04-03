#!/bin/bash
#SBATCH --constraint=gpu
#SBATCH --job-name=pace_c12_gpu
#SBATCH --ntasks=6
#SBATCH --nodes=2
#SBATCH --cpus-per-task=1
#SBATCH --output=driver.out
#SBATCH --time=00:45:00
#SBATCH --gpus=2
#SBATCH --account=a-g34
#SBATCH --partition=debug
########################################################

set -x

export MPICH_GPU_SUPPORT_ENABLED=1
export FV3_DACEMODE=Build
export PACE_FLOAT_PRECISION=64
export PACE_LOGLEVEL=INFO
export PYTHONOPTIMIZE=1
export OMP_NUM_THREADS=12

source $HOME/Repos/NOAA_pace/FV3_clariden/bin/activate
echo $(which python)
srun python -m pace.run $HOME/Repos/NOAA_pace/examples/configs/baroclinic_c12_gpu.yaml

