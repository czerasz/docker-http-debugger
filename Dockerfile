FROM node:25.2.1-slim

# Set the reset cache variable
ENV REFRESHED_AT=2025-12-08 DEBIAN_FRONTEND=noninteractive

# Update packages list
# Install useful packages
RUN apt-get update &&\
    apt-get install -y strace \
                       procps \
                       tree \
                       vim \
                       git \
                       curl \
                       wget &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin/app/

# Add a file which describes application dependencies
ADD ./app/package.json /usr/local/bin/app/package.json

# Install required libraries
RUN npm install

# Add the application code to the container
ADD ./app /usr/local/bin/app

# Cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DEBIAN_FRONTEND=newt

ENTRYPOINT ["npm"]
CMD ["start"]
