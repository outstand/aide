FROM 786715713882.dkr.ecr.us-east-1.amazonaws.com/fixuid as fixuid

FROM 786715713882.dkr.ecr.us-east-1.amazonaws.com/ruby-test:3.1.2
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

COPY --from=fixuid /usr/local/bin/fixuid /usr/local/bin/fixuid
COPY --from=fixuid /etc/fixuid/config.yml /etc/fixuid/config.yml
RUN chmod 4755 /usr/local/bin/fixuid

RUN groupadd -g 1000 deploy && \
      useradd -u 1000 -g deploy -ms /bin/bash deploy

COPY --chown=deploy:deploy docker/irbrc /home/deploy/.irbrc

COPY docker/tools-entrypoint.sh /tools-entrypoint.sh
COPY docker/entrypoint.sh /docker-entrypoint.sh

EXPOSE 3000
EXPOSE 7787
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
