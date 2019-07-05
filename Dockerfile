FROM pataquets/ubuntu:bionic

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      curl \
      gpg \
  && \
  curl --fail --silent --show-error --location \
    https://doozer.io/keys/tvheadend/tvheadend/pgp \
    | apt-key add - \
  && \
  echo "deb https://apt.tvheadend.org/stable bionic main" \
    | tee -a /etc/apt/sources.list.d/tvheadend.list \
  && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get purge --auto-remove -y \
      curl \
      gpg \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      tvheadend \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

ENTRYPOINT [ "tvheadend" ]
