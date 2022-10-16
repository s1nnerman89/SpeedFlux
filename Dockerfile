FROM python:3.8-slim-buster
LABEL maintainer="s1nnerman89" \
    description="Original by Aiden Gilmartin. Modified by Breadlysm. Further modifications by s1nnerman89. Maintained by s1nnerman89"

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update 
RUN apt-get -q -y install --no-install-recommends apt-utils gnupg1 apt-transport-https dirmngr curl

# Install Speedtest
RUN curl -s https://install.speedtest.net/app/cli/install.deb.sh --output /opt/install.deb.sh
RUN bash /opt/install.deb.sh
RUN apt-get update && apt-get -q -y install speedtest
RUN rm /opt/install.deb.sh

# Clean up
RUN apt-get -q -y autoremove && apt-get -q -y clean 
RUN rm -rf /var/lib/apt/lists/*

# Copy and final setup
ADD . /app
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt 
COPY . .

# Excetution
CMD ["python", "main.py"]
