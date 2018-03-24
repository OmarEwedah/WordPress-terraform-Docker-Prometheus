FROM prom/prometheus

ADD env.sh  /etc/prometheus/
ADD prometheus.yml /etc/prometheus/

CMD [ "-config.file=/etc/prometheus/prometheus.yml", \
      "-storage.local.path=/prometheus", \
      "-web.console.libraries=/etc/prometheus/console_libraries", \
      "-web.console.templates=/etc/prometheus/consoles", \
      "/bin/sh","/etc/prometheus/env.sh"]
