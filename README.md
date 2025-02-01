# cev-godot-sim

Contains the godot project for the CEV simulator

## Instructions

For a using the release build, simply download then:
```
cd /path/to/download
source /opt/ros/humble/setup.bash
./racing-tests.sh
``` 

Instructions for building from source:

### Installation

```
git clone git@github.com:cornellev/cev-godot-sim.git
```

### Dependencies

Depends on [godot-ros-bridge](https://github.com/cornellev/godot-ros-bridge/tree/main):
* Build the project project yourself, or 
* find compiled releases (may not exist yet) and move them into `cev-godot-sim/bin`


### Running

Godot needs to be running in an environment where ROS2 exists:
```
source /opt/ros/humble/setup.bash   # make sure ROS2 is sourced properly
godot                               # run Godot from terminal
```

Then, you should be able to import & edit and this project (find `/path/to/cev-godot-sim/project.godot` from Godot).

To enable basic ROS features, copy `default_config.ini` into the project's app data. This can be found by editing the project with Godot and finding `Project > Open User Data Folder`.

## Next steps

Provide compiled releases

Make config file way easier to use (use default if none present in app data) / Provide tutorial on how to use config file

Fix bugs, add features, etc.

