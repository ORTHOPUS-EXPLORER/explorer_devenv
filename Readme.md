
## First install:

# You need a valid bitbucket account with acces to ORTHOPUS repositories


pull all the git repositories and submodules with:
```
(HOST)
./setup_devenv.sh
```

build the docker image that will contain the ros2 stack. You don't need to install ros or anything special on your system - everything is inside the container.

(however, you can install the ROS2 stack directly on your computer, withour docker)
```
(HOST)
./docker-build-jazzy.sh
```

run container:
```
(HOST)
docker-run-explorer-jazzy.sh
```
you will en up in a shell inside your contaier (CONT), showing something like:

```
root@thomas-Precision-3560:/src#
```

If you need another terminal inside the container, you can use:

```
(CONT)
./docker-exec-jazzy.sh
```

From the container, build the code. this script will install all required dependancies with rosdep:

```
(CONT)
./build.sh
```
after a first build, ./build_clean.sh cleans workspace and rebuilds from scratch


(OPTIONAL) in order to save time next time you want to work on the project, save the docker image for later:

**hint**: once you close the docker container, it will forget everything that happened in it (except modified files in the current folder). If you needed to install something that was not in the dockerfile neither handled by rosdep, the good practice it either to add this package to the dockerfile if it is not directly required to build the code or inside the matching poackage.xml file if it is required by your packages.
It is recommanded to commit your docker only once, after the first build and rosdep installed all the required dependancies. You should not use docker commit as a daily backup tool.

```
(HOST) - new terminal
./docker-commit-explorer-jazzy.sh
```

If you saved your container for later, you can start it using:

```
(HOST)
docker-run-explorer-jazzy-prebuilt.sh
```

## Usage:

After you ran your docker container and built the code, you can source the environment:

```
(CONT)
source source.sh
```

you can now launch a standard ROS2 package to check the installation:

```
ros2 run rviz2 rviz2
```
If everything is OK, the rviz windows should open.

Now, you are ready to work on the explorer project.

## Setting up CAN interface:

The docker run script (docker-run-explorer-jazzy.sh) uses docker run with arguments to share hardware graphical and the base folder between (HOST) and (CONT). Any interface (ttyUSBx, CAN, etc) that is available on the (HOST) should be available inside the container (CONT).

Enable the USB-CAN interface at 1Mbs from the host:

```
(HOST)
./setcan0_1M.sh
```
Now, you can run the packages that actually communicates with hardware, not only simulation.