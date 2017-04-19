# aws_mosquitto_broker
Docker Image for AWS IOT connected Mosquitto broker

![url: https://s3.amazonaws.com/aws-iot-blog-assets/how-to-bridge-mosquitto-mqtt-broker-to-aws-iot/1-overview.png]({{site.baseurl}}/img/aws_broker.png)


### BASIC USAGE:

#### Configuring Persietence:

sudo mkdir -p ./service/mqtt/config
sudo mkdir -p ./service/mqtt/data
sudo mkdir -p ./service/mqtt/log

The Volumes in docker machine:

/mqtt/config
/mqtt/data
/mqtt/log

#### setup permissions for local testing
sudo chmod -R 777 ./service/mqtt/*

#### setup config files
1.- place your mosquitto config file inside ./service/mqtt/config
2.- replace mosquitto_xxxx.conf to mosquitto.conf
3.- copy conf.d directory to ./service/mqtt/config
cp -R ./config/conf.d ./service/mqtt/config


#### build
docker build -t aws_mqtt_broker .

#### run broker
```
docker run -ti -p 1883:1883 -p 9001:9001 \
-v /service/mqtt/config:/mqtt/config:ro \
-v /service/mqtt/log:/mqtt/log:rw \
-v /service/mqtt/data/:/mqtt/data/ \
--name mqtt aws_mqtt_broker
```