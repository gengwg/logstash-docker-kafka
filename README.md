## Test logstash docker kafka

```bash
# on docker side
$ docker build -t logstash-kafka-test .
$ docker run -u 0 -it  logstash-kafka-test /bin/bash
root@4fad465cd089:/# logstash -f /usr/share/logstash/pipeline/

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

```
# build the image
docker build -t docker.example.com/organization/logstash-kafka-test .
# push to registry
docker push docker.example.com/organization/logstash-kafka-test
# deploy to k8s
kubectl -s http://kubernetes.organization.example.com:8080 apply -f logstash-k8s-deployment.yaml
```


