# ------------------------------------------------------------------------------
# Pull base image
FROM fullaxx/ubuntu-desktop
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C

# ------------------------------------------------------------------------------
# Install prerequisites (openjdk,openvpn) and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openjdk-11-jre-headless \
      openvpn \
      tree \
      webkit2gtk-driver && \
    sed -e 's/^assistive_technologies/#assistive_technologies/' \
      -i /etc/java-11-openjdk/accessibility.properties && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install BiglyBT
RUN wget -q https://files.biglybt.com/installer/BiglyBT_Installer.sh \
      -O /app/BiglyBT_Installer.sh && chmod +x /app/BiglyBT_Installer.sh && \
    USER="root" app_java_home="/usr/lib/jvm/java-11-openjdk-amd64/" /app/BiglyBT_Installer.sh -q && \
    rm /app/BiglyBT_Installer.sh

# ------------------------------------------------------------------------------
# Provide default BiglyBT config
COPY conf/biglybt.config /usr/share/biglybt/biglybt.config.default

# ------------------------------------------------------------------------------
# Install startup scripts
COPY app/*.sh /app/

# ------------------------------------------------------------------------------
# Identify Volumes
VOLUME /in
VOLUME /out

# ------------------------------------------------------------------------------
# Expose ports
EXPOSE 5901

# ------------------------------------------------------------------------------
# Define default command
CMD ["/app/app.sh"]
