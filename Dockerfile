# ##########################################################################
# File: Dockerfile
# Author: Vatsal Gupta (gvatsal60)
# Description: Dockerfile for a Streamlit application.
# ##########################################################################

# ##########################################################################
# License
# ##########################################################################
# This Dockerfile is licensed under the Apache 2.0 License.
# License information should be updated as necessary.
# ##########################################################################

# ##########################################################################
# Base Image
# ##########################################################################
FROM ghcr.io/astral-sh/uv:python3.12-trixie-slim

# Add non-root user
RUN addgroup --system nonroot \
  && adduser --system --ingroup nonroot nonroot \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Switch to non-root user
USER nonroot

# ##########################################################################
# Maintainer
# ##########################################################################
LABEL maintainer="Vatsal Gupta (gvatsal60)"

# ##########################################################################
# Set Working Directory
# ##########################################################################
WORKDIR /app

# ##########################################################################
# Copy Files
# ##########################################################################
# Copy dependency files first for better caching
COPY pyproject.toml ./

# Install dependencies into a local folder
RUN uv sync --no-cache

COPY src/ ./

# ##########################################################################
# Expose Port
# ##########################################################################
EXPOSE 8501

# ##########################################################################
# Command to Run
# ##########################################################################

# For standard Python applications
ENTRYPOINT [ "uv", "run", "app.py" ]

# For `streamlit` applications
# ENTRYPOINT ["streamlit", "run", "src/app.py", "--server.port=8501", "--server.address=0.0.0.0", "--browser.gatherUsageStats=false"]
