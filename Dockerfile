# ------------------------------------------------------------------------------
# Pull base image
FROM fullaxx/ubuntu-desktop
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C

# ------------------------------------------------------------------------------
# Install openjdk-8 and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      tree \
      openjdk-8-jre-headless \
      libwebkitgtk-3.0-0 \
      libswt-gtk-3-jni \
      openvpn && \
    sed -e 's/^assistive_technologies/#assistive_technologies/' \
      -i /etc/java-8-openjdk/accessibility.properties && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install BiglyBT
RUN wget -q https://files.biglybt.com/installer/BiglyBT_Installer.sh \
      -O /app/BiglyBT_Installer.sh && chmod +x /app/BiglyBT_Installer.sh && \
    USER="root" /app/BiglyBT_Installer.sh -q && \
    echo >> /root/.config/openbox/autostart && \
    echo "/usr/local/biglybt/biglybt &" >> /root/.config/openbox/autostart && \
    rm /app/BiglyBT_Installer.sh

# ------------------------------------------------------------------------------
# Provide default BiglyBT config
COPY conf/biglybt.config /usr/share/biglybt/biglybt.config.default

# ------------------------------------------------------------------------------
# Install startup scripts
COPY app/*.sh /app/

# ------------------------------------------------------------------------------
# Identify Volumes
VOLUME /root/.biglybt
VOLUME /in
VOLUME /out

# ------------------------------------------------------------------------------
# Expose ports
EXPOSE 5901

# ------------------------------------------------------------------------------
# Define default command
CMD ["/app/tiger.sh"]
