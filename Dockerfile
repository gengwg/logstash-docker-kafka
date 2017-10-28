# Note we use logstash 5.1.2
# because it seems 5.2.2 doesn't work with our Kafka Version?
# FROM docker.elastic.co/logstash/logstash:5.2.2
FROM docker.elastic.co/logstash/logstash:5.1.2
MAINTAINER https://github.com/gengwg
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/
USER root
RUN chown logstash:logstash -R /usr/share/logstash/
USER logstash
