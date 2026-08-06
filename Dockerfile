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
FROM python:3.14-alpine

RUN addgroup -S nonroot \
  && adduser -S nonroot -G nonroot

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

USER nonroot

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
