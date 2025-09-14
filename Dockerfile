# or lastest
FROM vastai/comfy:cuda-12.8-auto 

WORKDIR /opt/workspace-internal/ComfyUI
ENV VIRTUAL_ENV=/venv/main
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV COMFY_PATH="/opt/workspace-internal/ComfyUI"

### SageAttention
# RUN git clone https://github.com/thu-ml/SageAttention.git && \
# COPY SageAttention/ $COMFY_PATH/SageAttention/
RUN git clone -b specify_additional_architecture https://github.com/thibaultsoubeste/SageAttention.git && \
    cd SageAttention && \
    export EXT_PARALLEL=1 NVCC_APPEND_FLAGS="--threads 4" MAX_JOBS=1 && \
    # TORCH_CUDA_ARCH_LIST="8.9;8.6;8.0;9.0+PTX" FORCE_CUDA=1 python setup.py install  
    TORCH_CUDA_ARCH_LIST="8.9;12.0" FORCE_CUDA=1 python setup.py install  

# docker build -t comfy-local:dev .
# docker run -it --rm --gpus all -p 8188:8188 comfy-local:dev
# docker login
# docker tag comfy-local:dev thibaultsoubeste/comfy-wan22-i2v:dev
# docker push thibaultsoubeste/comfy-wan22-i2v:dev