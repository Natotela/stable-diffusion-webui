@echo off

set PYTHON=
set GIT=
set VENV_DIR=
set PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.8,max_split_size_mb:512
set ATTN_PRECISION=fp16
set SAFETENSORS_FAST_GPU=1
set COMMANDLINE_ARGS=--no-half-vae --lowvram --opt-sdp-attention --api --enable-insecure-extension-access --disable-safe-unpickle --lyco-dir "F:\Progz\stable-diffusion-webui\models\LyCORIS"

call webui.bat