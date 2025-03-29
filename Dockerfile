FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    awscli \
    azure-cli \
    google-cloud-sdk \
    terraform \
    kubectl \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install additional tools
RUN pip3 install --no-cache-dir \
    aws-sam-cli \
    azure-functions-core-tools \
    google-cloud-sdk

# Install Helm
RUN curl https://baltocdn.com/helm/signing.apt.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
    && apt-get update \
    && apt-get install -y helm \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Create a non-root user
RUN useradd -m -s /bin/bash clouddev \
    && usermod -aG sudo clouddev \
    && echo "clouddev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user
USER clouddev

# Set default shell
SHELL ["/bin/bash", "-c"]

# Add common aliases
RUN echo 'alias ll="ls -la"' >> ~/.bashrc \
    && echo 'alias k="kubectl"' >> ~/.bashrc \
    && echo 'alias tf="terraform"' >> ~/.bashrc \
    && echo 'alias gcloud="gcloud"' >> ~/.bashrc \
    && echo 'alias az="az"' >> ~/.bashrc \
    && echo 'alias aws="aws"' >> ~/.bashrc

# Set default command
CMD ["/bin/bash"] 