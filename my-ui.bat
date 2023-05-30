@echo off

set VENV_DIR=
REM set CKPT="F:\Progz\stable-diffusion-webui\models\Stable-diffusion\deliberate_v2.safetensors"
REM set PYTHON="%USERPROFILE%\AppData\Local\Programs\Python\Python310\python.exe"
set GIT=
REM set COMMANDLINE_ARGS=--gfpgan-dir "models\GFPGAN" --api --cors-allow-origins=https://www.painthua.com --ckpt %CKPT% --listen --xformers --opt-split-attention --no-half --precision full --medvram  --share --gradio-auth ic4:ni4ni

set REDUCED_VRAM_A="--opt-split-attention"
REM # Cross attention layer optimization significantly reducing memory use for almost no cost
set REDUCED_VRAM_Q="--opt-sub-quad-attention"
REM # Recommended if poor performance/failed generations with a configuration that xformers doesn't work for
set REDUCED_VRAM_old="--opt-split-attention-v1"
REM # not as memory hungry (it will use less VRAM, but will be more limiting in the max size of pics you can make).

REM --medvram : splitting it into three parts - cond (for transforming text into numerical representation), first_stage (for converting a picture into latent space and back), and unet (for actual denoising of latent space) and making it so that only one is in VRAM at all times, sending others to CPU RAM.
REM --lowvram : splitting unet into many modules, and only one module is kept in VRAM. Devastating for performance.

REM --gradio-img2img-tool color-sketch :  use colors in img2img
REM --enable-insecure-extension-access

REM for low VRAM: --upcast-sampling --precision full --no-half-vae

set GFPGAN=--gfpgan-dir "models\GFPGAN"

echo Do you want to generate images using the
echo 1. LOW vram, no xformers	sub-quad-attention
echo 2. LOW vram + xformers	+	split-attention
echo 3. Full Precision GFPGAN medvram
echo 4. FULL + listen - slowed-down
echo 5. experimental
set /P restore="Please enter 1 or 2 or 3 : "
IF /I "%restore%" == "1" (
    set COMMANDLINE_ARGS=--lowvram --no-half --api %REDUCED_VRAM_Q% --enable-insecure-extension-access
) ELSE IF /I "%restore%" == "2" (
    set COMMANDLINE_ARGS=--lowvram --no-half --api --xformers %REDUCED_VRAM_A% --enable-insecure-extension-access
) ELSE IF /I "%restore%" == "3" (
    set COMMANDLINE_ARGS=--medvram --no-half --api --xformers %REDUCED_VRAM_A% --enable-insecure-extension-access %GFPGAN% --precision full
) ELSE IF /I "%restore%" == "4" (
	set COMMANDLINE_ARGS=--api --xformers %REDUCED_VRAM_A% --enable-insecure-extension-access %GFPGAN% --precision full --listen --upcast-sampling --no-half-vae
) ELSE IF /I "%restore%" == "5" (
	set PYTORCH_CUDA_ALLOC_CONF=garbage_collection_threshold:0.9,max_split_size_mb:512
	set ATTN_PRECISION=fp16
	set SAFETENSORS_FAST_GPU=1
	set COMMANDLINE_ARGS=--no-half-vae --medvram --opt-sdp-attention --no-half --api --enable-insecure-extension-access
) ELSE (
    echo Invalid selection
    pause
    exit /b
)


git pull
call webui.bat

REM launch the WebUI with the --disable-safe-unpickle option or else it won't let you to use the depth models! 
REM git reset --hard 3856ada5cc9ac4124e20ff311ce7aa77330845d9