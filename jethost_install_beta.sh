#Ros Prerequisites
sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
sudo apt-get update

#Ros kinetic Base
sudo apt-get -y install ros-kinetic-desktop-full

#Python Dependencies
sudo apt-get -y install python-rosdep python-dev python-pip python-rosinstall python-wstool

sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

#Ros packages
sudo apt-get -y install ros-kinetic-rosserial-arduino
sudo apt-get -y install ros-kinetic-rosserial
sudo apt-get -y install ros-kinetic-joy
sudo apt-get -y install ros-kinetic-teleop-twist-joy
sudo apt-get -y install ros-kinetic-teleop-twist-keyboard

# Configure Catkin Workspace
source /opt/ros/kinetic/setup.bash
cd ../../
catkin_init_workspace

#Build Arduino Ros libraries
cd src/jet_arduino/resources/lib
rm -rf ros_lib
rosrun rosserial_arduino make_libraries.py .

#Setup Platformio
pip install -U platformio
platformio platforms install atmelavr