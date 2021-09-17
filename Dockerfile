FROM ruby:2.7.1

# Register Yarn package source.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install packages.
RUN apt update -qq
RUN apt install -y postgresql-client nodejs yarn

WORKDIR $RAILS_ROOT
COPY .$RAILS_ROOT $RAILS_ROOT
RUN gem install bundler
RUN bundle install

# ARG USER_ID
# ARG GROUP_ID

# RUN addgroup --gid $GROUP_ID user
# RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# ENV INSTALL_PATH /opt/app
# RUN mkdir -p $INSTALL_PATH

# RUN gem install rails bundler
# RUN chown -R user:user $INSTALL_PATH
# WORKDIR $INSTALL_PATH

# USER $USER_ID
# CMD ["/bin/sh"]