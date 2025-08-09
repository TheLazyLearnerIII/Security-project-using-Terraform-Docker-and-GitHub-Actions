FROM ubuntu:22.04

LABEL maintainer="Edward A. Polanco Murillo" \
      description="Ubuntu-based Docker image with Lynis for security scanning"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    wget \
    ca-certificates \
    gnupg \
    lsb-release \
    git && \
    rm -rf /var/lib/apt/lists/*

# Clone Lynis directly into container
RUN git clone https://github.com/CISOfy/lynis /opt/lynis

# Copy the scan script into container and give execute permissions
COPY lynis-scan.sh /usr/local/bin/lynis-scan.sh
RUN chmod +x /usr/local/bin/lynis-scan.sh

# Run the scan script by default
CMD ["bash", "/usr/local/bin/lynis-scan.sh"]



