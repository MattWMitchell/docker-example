FROM mcr.microsoft.com/dotnet/aspnet:6.0-bookworm-slim AS base

RUN sed -i 's/main/main contrib/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && \
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt-get install -y --no-install-recommends ttf-mscorefonts-installer fontconfig && \
    rm -rf /var/lib/apt/lists/*

# Install core libraries
RUN apt-get update && apt-get install -y \
    libgdiplus \
    libfontconfig1 \
    libfreetype6 \
    libexpat1 \
    libpng16-16 \
    libc6-dev \
    libharfbuzz0b \
    libssl3 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Microsoft Fonts
RUN apt-get update && apt-get install -y \
    ttf-mscorefonts-installer \ 
    fonts-liberation \
    fonts-dejavu \
    fonts-noto \
    fonts-freefont-ttf \
    fontconfig

# Copy custom fonts to the standard Linux font directory
COPY ./fonts /usr/share/fonts/truetype/custom/

# Refresh the system font cache
RUN fc-cache -f -v