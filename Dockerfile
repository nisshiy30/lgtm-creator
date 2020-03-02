FROM ruby:2.6.2
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y nodejs \
                       vim \
                       postgresql-client \
                       --no-install-recommends &&\
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install
RUN yarn install

ENV APP_ROOT /lgtm-creator
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

EXPOSE 3000
CMD ["yarn", "start"]
