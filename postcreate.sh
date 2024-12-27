
sudo chown -R ${UID}:${GID} ${HOME} /workspaces

uv venv --prompt .venv
uv sync
