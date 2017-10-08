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
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-eigen-conversions
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-tf2-geometry-msgs
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-angles
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-web-video-server
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-rosbridge-suite
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-rospy-tutorials
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-roslint
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-controller-manager
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-camera-calibration-parsers
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-xacro
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-robot-state-publisher
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-diff-drive-controller
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-usb-cam
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-ros-control
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-dynamic-reconfigure
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-fake-localization
sudo apt-get --yes --force-yes --allow-unauthenticated install ros-kinetic-image-view

#Install other files that may be nessessary
sudo apt-get install --yes --force-yes --allow-unauthenticated build-essential cmake git pkg-config
sudo apt-get install --yes --force-yes --allow-unauthenticated libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --yes --force-yes --allow-unauthenticated libatlas-base-dev 
sudo apt-get install --yes --force-yes --allow-unauthenticated --no-install-recommends libboost-all-dev
sudo apt-get install --yes --force-yes --allow-unauthenticated libgflags-dev libgoogle-glog-dev liblmdb-dev
sudo apt-get install --yes --force-yes --allow-unauthenticated python-pip
sudo apt-get install --yes --force-yes --allow-unauthenticated python-dev
sudo apt-get install --yes --force-yes --allow-unauthenticated python-numpy python-scipy
sudo apt-get install --yes --force-yes --allow-unauthenticated libopencv-dev

# Configure Catkin Workspace
source /opt/ros/kinetic/setup.bash
cd ~/catkin_ws/src
catkin_init_workspace

#Build Arduino Ros libraries
cd src/jet_arduino/resources/lib
rm -rf ros_lib
rosrun rosserial_arduino make_libraries.py .

#Setup Platformio
pip install -U platformio
platformio platforms install atmelavr

#Install Ros Opencv bindings from source
cd ~/catkin_ws
wstool init src
wstool merge -t src src/rosjet/rosjet.rosinstall
wstool update -t src
catkin_make

#Install Caffe (https://gist.github.com/jetsonhacks/acf63b993b44e1fb9528)
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install --yes --force-yes --allow-unauthenticated libprotobuf-dev protobuf-compiler gfortran \
libboost-dev cmake libleveldb-dev libsnappy-dev \
libboost-thread-dev libboost-system-dev \
libatlas-base-dev libhdf5-serial-dev libgflags-dev \
libgoogle-glog-dev liblmdb-dev -y
sudo usermod -a -G video $USER
cd ~/
git clone https://github.com/BVLC/caffe.git
cd caffe && git checkout master
cp Makefile.config.example Makefile.config   #custom file needed
make -j 4 all

## System Optimizations
#gsettings set org.gnome.settings-daemon.plugins.power button-power shutdown
#gsettings set org.gnome.desktop.screensaver lock-enabled false
#sudo apt-get -y install compizconfig-settings-manager
#gsettings set org.gnome.desktop.interface enable-animations false
#gsettings set com.canonical.Unity.Lenses remote-content-search none
#echo '[SeatDefaults]\nautologin-user=ubuntu' > login_file; sudo mv login_file /etc/lightdm/lightdm.conf
#gsettings set org.gnome.Vino enabled true
#gsettings set org.gnome.Vino disable-background true
#gsettings set org.gnome.Vino prompt-enabled false
#gsettings set org.gnome.Vino require-encryption false

echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

sudo apt-get install --yes --force-yes --allow-unauthenticated libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install --yes --force-yes --allow-unauthenticated libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
