@echo off

set PYTHON=F:\Progz\ComfyUI_windows_portable\python_embeded\python.exe
set GIT=
set VENV_DIR=
set PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.7,max_split_size_mb:512
set ATTN_PRECISION=fp16
set SAFETENSORS_FAST_GPU=1
set COMMANDLINE_ARGS=--no-half-vae --medvram --opt-sdp-attention --api --enable-insecure-extension-access --disable-safe-unpickle

call ic-ui.bat

