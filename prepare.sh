#!bin/bash

if ! command -v wget &> /dev/null
then
    echo "wget could not be found"
    exit 99
fi

if ! command -v docker &> /dev/null
then
    echo "docker could not be found"
    exit 99
fi

if ! command -v unzip &> /dev/null
then
    echo "unzip could not be found"
    exit 99
fi

wget -c https://github.com/raynerweb/telemetry/archive/refs/heads/master.zip
mv master.zip telemetry-master.zip
unzip telemetry-master.zip
docker run -it -v "$HOME/.m2":/root/.m2 -v "$(pwd)/telemetry-master":/usr/src/mymaven -w /usr/src/mymaven maven:3.9.0 mvn -Pdev clean install
docker build -t telemetry telemetry-master/

wget -c https://github.com/raynerweb/tracking/archive/refs/heads/master.zip
mv master.zip tracking-master.zip
unzip tracking-master.zip
docker run -it -v "$HOME/.m2":/root/.m2 -v "$(pwd)/tracking-master":/usr/src/mymaven -w /usr/src/mymaven maven:3.9.0 mvn -Pdev clean install
docker build -t tracking tracking-master/

wget -c https://github.com/raynerweb/vehicle-python/archive/refs/heads/master.zip
mv master.zip vehicle-python-master.zip
unzip vehicle-python-master.zip
docker build -t vehicle vehicle-python-master/VehiclesMS/

wget -c https://github.com/raynerweb/people/archive/refs/heads/master.zip
mv master.zip people-master.zip
unzip people-master.zip
docker build -t people people-master/