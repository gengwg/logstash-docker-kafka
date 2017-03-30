## Test logstash docker kafka

```bash
# on docker side
$ docker run -u 0 -it  logstash /bin/bash
root@4fad465cd089:/# logstash -f /usr/share/logstash/pipeline/

# on kafka host
$ kafka-console-producer --broker-list localhost:9092 --topic oneopspublisher
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
