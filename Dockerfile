# Use an official Python image as the base image
FROM python:3.9-slim

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    gcc \
    krb5-user \
    libffi-dev \
    libkrb5-dev \
    libssl-dev \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Install Ansible and dependencies
RUN pip install ansible
RUN pip install "pywinrm>=0.4.1"

# Set the working directory
WORKDIR /ansible

# Copy your Ansible playbooks and inventory file into the container
COPY playbook.yaml .
COPY inventory.ini .

RUN echo "[defaults]\n\
transport = winrm" > ansible.cfg

# Command to run Ansible playbook
CMD ["ansible-playbook", "-i", "inventory.ini", "playbook.yaml"]
