FROM ruby:3.2.2

# for nodejs and yarn
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y build-essential nodejs yarn vim zlib1g-dev liblzma-dev patch \
    && rm -rf /var/lib/apt/lists/*

RUN node -v
RUN yarn -v

RUN gem uninstall bundler
RUN gem install bundler -v 2.4.5

RUN mkdir /MATSURI_SERVICE
WORKDIR /MATSURI_SERVICE
COPY Gemfile /MATSURI_SERVICE/Gemfile
COPY Gemfile.lock /MATSURI_SERVICE/Gemfile.lock
RUN bundle install
COPY . /MATSURI_SERVICE

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
