# FROM gitpod/workspace-full
FROM gitpod/workspace-postgres

# # Install additional OS packages.
# RUN sudo apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && sudo apt-get -y install --no-install-recommends postgresql-client \
#     && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG RUBY_VERSION="3.0.3"
# Install exact Ruby version and set it as default
RUN echo "rvm_gems_path=/home/gitpod/.rvm" > ~/.rvmrc
RUN bash -lc "rvm install ruby-${RUBY_VERSION} && rvm use ruby-${RUBY_VERSION} --default"
RUN echo "rvm_gems_path=/workspace/.rvm" > ~/.rvmrc
# Install additional gems.
RUN bash -lc "gem install bundler:2.3.4"
