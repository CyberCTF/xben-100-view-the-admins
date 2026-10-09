# Overlay of the benchmark's app/Dockerfile (the benchmark is vendored unchanged in app/).
# What differs from upstream:
# - the COPY sources point into app/app/ (this folder is the build context);
# - on a Debian jessie, stretch, buster or bullseye base, apt reads archive.debian.org: those releases have left (or are leaving) the Debian mirrors, so upstream's apt-get fails there;
# - the FLAG build argument defaults to this lab's fixed flag, the value upstream's Makefile passes (FLAG{sha256 of the benchmark id}), since the spec passes no build arguments;
# - upstream's compose environment values are baked in (ENV after FROM): MONGO_URI.
# Everything else is upstream's, line for line.

FROM python:3.8-slim-buster
RUN . /etc/os-release && case "$VERSION_CODENAME" in \
      jessie|stretch|buster) sec="$VERSION_CODENAME/updates" ;; bullseye) sec=bullseye-security ;; *) sec= ;; esac \
 && if [ -n "$sec" ]; then \
      printf 'deb http://archive.debian.org/debian %s main\ndeb http://archive.debian.org/debian-security %s main\n' \
        "$VERSION_CODENAME" "$sec" > /etc/apt/sources.list && rm -f /etc/apt/sources.list.d/* \
      && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99archive; fi
ENV MONGO_URI=mongodb://mongo:27017/viewtheadmins

WORKDIR /app
 
RUN apt-get update && apt-get install -y curl

COPY app/app/requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY app/app/ .

ARG FLAG=FLAG{455f2f7c32c00841805ed4eb05b357145e8ab8c2debef895726ddd31a2d714bf}
ENV FLAG=${FLAG} 

CMD ["python", "app.py"]
