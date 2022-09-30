FROM ruby:3.1-alpine3.15

ENV TZ=Asia/Tokyo
RUN apk --no-cache upgrade
RUN apk add --no-cache tzdata libc6-compat build-base bash

WORKDIR /opt/app
COPY . .
RUN bundle install

RUN adduser -D ruby && chown -R ruby.ruby /opt/app
USER ruby
ENTRYPOINT ["bash"]
CMD []
