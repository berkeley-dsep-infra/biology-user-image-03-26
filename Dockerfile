FROM us-central1-docker.pkg.dev/ucb-datahub-2018/base-images-repo/base-r-image:0d6b5ea

USER root

# ------------------------------------------------------------
# System packages
# ------------------------------------------------------------
# Copy your new apt.txt
COPY apt.txt /tmp/apt.txt

RUN apt-get update -qq && \
    apt-get install -y tini && \
    apt-get install -y --no-install-recommends $(grep -v '^#' /tmp/apt.txt) && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY install.R /tmp/install.R
RUN Rscript /tmp/install.R

# ------------------------------------------------------------
# Conda / Python packages
# ------------------------------------------------------------
# Copy environment.yml for additional packages
USER ${NB_USER}
COPY --chown=${NB_USER}:${NB_USER} environment.yml /tmp/environment.yml


# Update existing /srv/conda/notebook environment with new packages
RUN conda env update -n notebook -f /tmp/environment.yml && \
    conda clean -afy && rm -rf /tmp/environment.yml


USER root
RUN rm -rf /tmp/*

ENV REPO_DIR=/srv/repo
COPY --chown=${NB_USER}:${NB_USER} image-tests ${REPO_DIR}/image-tests

USER ${NB_USER}
WORKDIR /home/${NB_USER}


COPY --chown=${NB_USER}:${NB_USER} ccb293-packages.bash /tmp/
RUN bash /tmp/ccb293-packages.bash && rm /tmp/ccb293-packages.bash

RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds

EXPOSE 8888
ENTRYPOINT ["tini", "--"]

