#!/bin/bash

#SBATCH --job-name=3dgs-v2
#SBATCH --output=3dgs-v2-%j.out
#SBATCH --error=3dgs-v2-%j.err
#SBATCH --time=00:30:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4
#SBATCH --gpus=1
#SBATCH --mail-type=NONE

echo "Running job: $SLURM_JOB_NAME!"
echo "We are running on $(hostname)"
echo "----------------------Job started at $(date) ----------------------"


source .venv/bin/activate

nvidia-smi

python 3dgs_renderer_v2.py 5splats.ply 5splats.png \
  --width 400 --height 400 --focal-length 350 \
  --camera-position 0 0 -2 --look-at 0 0 0 --up 0 -1 0

echo "----------------------lego_v2.png started at $(date) ----------------------"
python 3dgs_renderer_v2.py lego.ply lego_v2.png \
  --width 400 --height 400 --focal-length 350 --device cuda:0 \
  --camera-position -2 -2 3 --look-at 0 0 0 --up 0 0 -1
echo "----------------------lego_v2.png ended at $(date) ----------------------"

echo "----------------------lego_init_v2.png started at $(date) ----------------------"
python 3dgs_renderer_v2.py data/lego/init.ply lego_init_v2.png \
  --width 400 --height 400 --focal-length 350 --device cuda:0 \
  --camera-position -2 -2 3 --look-at 0 0 0 --up 0 0 -1
echo "----------------------lego_init_v2.png ended at $(date) ----------------------"

echo "----------------------lego_v3.png started at $(date) ----------------------"
python 3dgs_renderer_v3.py lego.ply lego_v3.png \
  --width 400 --height 400 --focal-length 350 --device cuda:0 \
  --camera-position -2 -2 3 --look-at 0 0 0 --up 0 0 -1
echo "----------------------lego_v3.png ended at $(date) ----------------------"

echo "----------------------lego_init_v3.png started at $(date) ----------------------"
python 3dgs_renderer_v3.py data/lego/init.ply lego_init_v3.png \
  --width 400 --height 400 --focal-length 350 --device cuda:0 \
  --camera-position -2 -2 3 --look-at 0 0 0 --up 0 0 -1
echo "----------------------lego_init_v3.png ended at $(date) ----------------------"

echo "----------------------Job ended at $(date) ----------------------"

