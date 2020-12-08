FROM clickable/arm64-16.04-arm64:16.04.3

# Upgrade Qt to 5.12
RUN echo "deb http://repo.ubports.com xenial_-_qt-5-12 main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    # Cleanup
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
