## Test logstash docker kafka

```bash
# on docker side
$ docker build -t logstash-kafka-test .
$ docker run -u 0 -it  logstash-kafka-test /bin/bash
root@4fad465cd089:/# logstash -f /usr/share/logstash/pipeline/
...
[2017-10-28T00:34:09,157][INFO ][org.apache.kafka.common.utils.AppInfoParser] Kafka version : 0.10.0.1
[2017-10-28T00:34:09,157][INFO ][org.apache.kafka.common.utils.AppInfoParser] Kafka commitId : a7a17cdec9eaa6c5
[2017-10-28T00:34:09,445][WARN ][org.apache.kafka.clients.NetworkClient] Error while fetching metadata with correlation id 1 : {mytopic2=LEADER_NOT_AVAILABLE}
[2017-10-28T00:34:09,447][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] Discovered coordinator kafka-158856208-1-171923103.stg.Kafka.organization.dal4.prod.company.com:9092 (id: 2147483546 rack: null) for group mygroup2.
[2017-10-28T00:34:09,452][INFO ][org.apache.kafka.clients.consumer.internals.ConsumerCoordinator] Revoking previously assigned partitions [] for group mygroup2
[2017-10-28T00:34:09,453][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] (Re-)joining group mygroup2
[2017-10-28T00:34:09,767][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] Successfully joined group mygroup2 with generation 1
[2017-10-28T00:34:09,768][INFO ][org.apache.kafka.clients.consumer.internals.ConsumerCoordinator] Setting newly assigned partitions [] for group mygroup2

# running 2nd time, the error is gone
root@4fad465cd089:/# logstash -f /usr/share/logstash/pipeline/
...
[2017-10-28T00:35:24,696][INFO ][org.apache.kafka.common.utils.AppInfoParser] Kafka version : 0.10.0.1
[2017-10-28T00:35:24,696][INFO ][org.apache.kafka.common.utils.AppInfoParser] Kafka commitId : a7a17cdec9eaa6c5
[2017-10-28T00:35:24,910][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] Discovered coordinator kafka-158856208-1-171923103.stg.Kafka.organization.dal4.prod.company.com:9092 (id: 2147483546 rack: null) for group mygroup2.
[2017-10-28T00:35:24,915][INFO ][org.apache.kafka.clients.consumer.internals.ConsumerCoordinator] Revoking previously assigned partitions [] for group mygroup2
[2017-10-28T00:35:24,915][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] (Re-)joining group mygroup2
[2017-10-28T00:35:25,089][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] Successfully joined group mygroup2 with generation 3
[2017-10-28T00:35:25,091][INFO ][org.apache.kafka.clients.consumer.internals.ConsumerCoordinator] Setting newly assigned partitions [mytopic2-0, mytopic2-3, mytopic2-2, mytopic2-1] for group mygroup2

# run directely
$ docker run -it  logstash-kafka-test
[2017-10-28T00:39:22,032][INFO ][org.apache.kafka.common.utils.AppInfoParser] Kafka version : 0.10.0.1
[2017-10-28T00:39:22,033][INFO ][org.apache.kafka.common.utils.AppInfoParser] Kafka commitId : a7a17cdec9eaa6c5
[2017-10-28T00:39:22,242][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] Discovered coordinator kafka-158856208-1-171923103.stg.Kafka.organization.dal4.prod.company.com:9092 (id: 2147483546 rack: null) for group mygroup2.
[2017-10-28T00:39:22,247][INFO ][org.apache.kafka.clients.consumer.internals.ConsumerCoordinator] Revoking previously assigned partitions [] for group mygroup2
[2017-10-28T00:39:22,248][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] (Re-)joining group mygroup2
[2017-10-28T00:39:22,424][INFO ][org.apache.kafka.clients.consumer.internals.AbstractCoordinator] Successfully joined group mygroup2 with generation 7
[2017-10-28T00:39:22,426][INFO ][org.apache.kafka.clients.consumer.internals.ConsumerCoordinator] Setting newly assigned partitions [mytopic2-0, mytopic2-3, mytopic2-2, mytopic2-1] for group mygroup2

# on kafka host
$ kafka-console-producer --broker-list localhost:9092 --topic mytopic
Hello World! <Enter>

# on docker side, one will see
{
    "@timestamp" => 2017-03-29T23:27:30.648Z,
      "@version" => "1",
       "message" => "Hello World!",
          "tags" => [
        [0] "mytag",
        [1] "kafka"
    ]
}
```

## Deploy to Kubernetes

After tested, deploy to k8s.

```bash
# build the image
docker build -t docker.example.com/organization/logstash-kafka-test .
# push to registry
docker push docker.example.com/organization/logstash-kafka-test
# deploy to k8s
kubectl -s http://kubernetes.organization.example.com:8080 apply -f logstash-k8s-deployment.yaml
```


