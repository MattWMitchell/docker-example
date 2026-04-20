FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base

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

# Install LibreOffice and minimal dependencies
# We include 'libreoffice-calc' specifically for spreadsheet conversions
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     libreoffice-calc \
#     libreoffice-java-common \
#     default-jre-headless \
#     fonts-liberation \
#     && apt-get clean && rm -rf /var/lib/apt/lists/*

# Full libre suite - NOTE REQUIRES MORE RAM
RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    libreoffice-java-common \
    default-jre-headless \
    fonts-liberation \
    libxml2-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the HOME environment variable
# LibreOffice needs a writable directory to store user profile data
ENV HOME=/tmp