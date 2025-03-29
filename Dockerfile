FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Version definitions
ENV TERRAFORM_VERSION=1.5.7
ENV KUBECTL_VERSION=1.28.3
ENV HELM_VERSION=3.12.3
ENV NODE_VERSION=18.17.1
ENV JAVA_VERSION=17
ENV PYTHON_VERSION=3.11

# Install essential packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-pip \
    awscli \
    azure-cli \
    google-cloud-sdk \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Install additional tools
RUN pip${PYTHON_VERSION} install --no-cache-dir \
    aws-sam-cli \
    azure-functions-core-tools \
    google-cloud-sdk

# Install Helm
RUN curl https://baltocdn.com/helm/signing.apt.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list \
    && apt-get update \
    && apt-get install -y helm=${HELM_VERSION} \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Install Java
RUN apt-get update && apt-get install -y \
    openjdk-${JAVA_VERSION}-jdk \
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
    && echo 'alias aws="aws"' >> ~/.bashrc \
    && echo 'alias node="node"' >> ~/.bashrc \
    && echo 'alias npm="npm"' >> ~/.bashrc \
    && echo 'alias java="java"' >> ~/.bashrc

# Set default command
CMD ["/bin/bash"] 