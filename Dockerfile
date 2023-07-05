FROM python:3.11-slim
ARG uid=1000
ARG gid=100
ARG catalog=/recordings
ARG plugin_path=/home/user/.local/share/streamlink/plugins
ARG plugin_url=https://raw.githubusercontent.com/nonvegan/streamlink-plugin-kick/master/kick.py
ARG plugin_file_path=$plugin_path/kick.py
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install streamlink cloudscraper \
    && streamlink --version

RUN getent group $gid > /dev/null \
    || groupadd --gid $gid usergroup
RUN useradd --uid $uid --gid $gid --shell /bin/bash --create-home user

USER user
WORKDIR $catalog

RUN mkdir -p "$plugin_path" \ 
    && wget -O "$plugin_file_path" "$plugin_url"

VOLUME [ "$catalog" ]

ENTRYPOINT [ "streamlink" ]
CMD [ "--help" ]