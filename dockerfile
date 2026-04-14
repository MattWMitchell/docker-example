FROM mcr.microsoft.com/dotnet/aspnet:6.0-jammy AS base

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