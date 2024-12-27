FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

LABEL maintainer="Supphachoke Suntiwichaya <mrchoke@gmail.com>"

ENV TZ=Asia/Bangkok

RUN apt update \
  && apt install -y \
  curl \
  git \
  less \
  libpango-1.0-0 \
  libpangoft2-1.0-0 \
  locales \
  sudo \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN sed --in-place '/en_US.UTF-8/s/^#//' /etc/locale.gen  \
  &&  sed --in-place '/th_TH.UTF-8/s/^#//' /etc/locale.gen \
  && locale-gen

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


ARG USERNAME=fastapi
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME}

USER ${USERNAME}

ENV VIRTUAL_ENV /workspaces/matplotlib/.venv
ENV UV_LINK_MODE copy

ENV ZSH_CUSTOM=/home/${USERNAME}/.oh-my-zsh/custom

ENV PATH="${VIRTUAL_ENV}/bin:$HOME/.local/share/uv/tools:$PATH"


WORKDIR /workspaces/matplotlib

ENV PYTHONPATH=/workspaces/matplotlib

EXPOSE 8000
