FROM us-central1-docker.pkg.dev/ucb-datahub-2018/base-images-repo/base-r-image:c25cdff

USER ${NB_USER}
WORKDIR /home/${NB_USER}

COPY install.R /tmp/install.R
RUN r /tmp/install.R

COPY --chown=${NB_USER}:${NB_USER} bio1b-packages.bash /tmp/
COPY --chown=${NB_USER}:${NB_USER} ib134-packages.bash /tmp/
COPY --chown=${NB_USER}:${NB_USER} ccb293-packages.bash /tmp/

RUN bash /tmp/bio1b-packages.bash && rm /tmp/bio1b-packages.bash
RUN bash /tmp/ib134-packages.bash && rm /tmp/ib134-packages.bash
RUN bash /tmp/ccb293-packages.bash && rm /tmp/ccb293-packages.bash

ENV REPO_DIR=/srv/repo
COPY --chown=${NB_USER}:${NB_USER} image-tests ${REPO_DIR}/image-tests

RUN rm -rf /tmp/downloaded_packages/ /tmp/*.rds

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
