FROM ubuntu:20.04

LABEL maintainers="Anton Zhelonkin <https://github.com/tony-zhelonkin>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    wget \
    vim \
    tar \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user with same UID/GID as your host user
RUN groupadd -g 1001 cellranger && \
    useradd -m -u 1001 -g cellranger cellranger

WORKDIR /opt

RUN wget -O cellranger-atac-2.1.0.tar.gz "https://cf.10xgenomics.com/releases/cell-atac/cellranger-atac-2.1.0.tar.gz?Expires=1730882011&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1hdGFjL2NlbGxyYW5nZXItYXRhYy0yLjEuMC50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE3MzA4ODIwMTF9fX1dfQ__&Signature=fzLrb4LvkyBeaY12JJsf7rd~HBxcSFpP63QPCokx0yMZmGxWqctL5O5gInODjfimyyNtnY~DqLIc~G2jLo6cxgKD8sVGf60j5a5ajDMunpHmCSj2AzZ9WkJlDMztzKWVZh0UDdq30JHf2A4vNym~3aDT-vJ8nI~32od3p80z92-P1ebu~hz6oJv9ZGKoDlGsxqHlRbzwFWhwS5FLzvQTgH1U70Xp-Ugm6P-6GNxQaJUkkZnikfe1ejxM1YZS5OvkKJAGjoW6Vn37taqo5spq3hLwMMcLETA~XzaFF3-4yRu0pGgYmgNDY7PxRHFXkALP3db835ZJuoxah5Ahd-zkaQ__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA" \
    && tar -xzf cellranger-atac-2.1.0.tar.gz \
    && rm cellranger-atac-2.1.0.tar.gz

ENV PATH=/opt/cellranger-atac-2.1.0:$PATH

# Change ownership of installation
RUN chown -R cellranger:cellranger /opt/cellranger-atac-2.1.0

# Switch to non-root user
USER cellranger

WORKDIR /data