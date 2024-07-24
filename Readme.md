
## First install:

# You need a valid bitbucket account with acces to ORTHOPUS repositories

create src folder and pull git 
```
(HOST)
./setup_devenv.sh
```

```
./docker-build-iron.sh
```
## Usage:
run container:
```
(HOST)
docker-run-iron.sh
```
TODO: choose from iron or explorer-iron
TODO: step by step readme

after first build, use:

```
docker-run-explorer-iron.sh
```

run rosdep install and colcon build:
```
(CONT)
./build.sh
```

(OPTIONAL) save the docker image for later:
```
(HOST) - new terminal
docker commit ros-iron-explorer ros-iron-explorer:prebuilt
```

run explorer example
```
./run_explorer
```

run prebuilt container:

```
docker-run-explorer-iron-prebuilt.sh
```
