FROM ubuntu:18.04 as base
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#VOLUME /data

RUN apt-get update -y && apt-get dist-upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils curl ca-certificates ccache python3 rsync git procps
RUN apt-get install -y nsis g++-mingw-w64-x86-64 wine-binfmt wine64 file
RUN apt-get install -y g++-multilib p7zip mc cmake nano vim

RUN update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix

#SHELL ["/bin/bash", "-c"]
ARG DATA_DIR=/data

ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=1
#WORKDIR ${DATA_DIR}

ARG UID
ARG GID
ARG UNAME
RUN groupadd -g ${GID} -o ${UNAME}
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}

COPY coinua-build.sh .

ENTRYPOINT ./coinua-build.sh


