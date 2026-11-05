# Environment for IndicF5 narration on a rented GPU. Software only:
# no model weights (the model is gated on Hugging Face) and no voice or scripts.
# Versions match the recipe used on the original machine. Change one and the voice may change.
FROM python:3.12-slim-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
      git ffmpeg libsndfile1 openssh-server openssh-sftp-server rsync tmux ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir uv==0.9.5 \
 && uv venv /opt/venv --python /usr/local/bin/python \
 && VIRTUAL_ENV=/opt/venv uv pip install --no-cache \
      --index-strategy unsafe-best-match \
      --extra-index-url https://download.pytorch.org/whl/cu124 \
      "torch==2.5.1" "torchaudio==2.5.1" "transformers==4.44.2" \
      soundfile numpy "pyarrow==25.0.1" "datasets==2.21.0" safetensors python-dotenv \
      "huggingface_hub<0.26" \
      "git+https://github.com/ai4bharat/IndicF5.git@13f7c4d627cc10111aea8fe9c0039462cacacdc7" \
 && VIRTUAL_ENV=/opt/venv uv pip freeze > /opt/freeze.txt \
 && /opt/venv/bin/python -c "import torch, torchaudio, transformers, soundfile, f5_tts.model, f5_tts.infer.utils_infer; print('torch', torch.__version__, 'cuda', torch.version.cuda, 'transformers', transformers.__version__)"

RUN touch /root/.no_auto_tmux
ENV TOKENIZERS_PARALLELISM=false PYTHONUTF8=1 PYTHONIOENCODING=utf-8
WORKDIR /workspace
CMD ["bash"]
