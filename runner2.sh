#!/bin/bash
#SBATCH --constraint=gpu
#SBATCH --job-name=c12_pace_driver
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --output=driver.out
#SBATCH --time=00:30:00
#SBATCH --gpus=6
#SBATCH --account=g34
#SBATCH --partition=debug
########################################################

set -x

export FV3_DACEMODE=Build
export PACE_FLOAT_PRECISION=64
export PACE_LOGLEVEL=INFO
export PYTHONOPTIMIZE=1
export OMP_NUM_THREADS=12

source $HOME/Repos/NOAA_pace/venv_pace/bin/activate
echo $(which python)
srun python -m pace.run examples/configs/baroclinic_c12_gpu.yaml
