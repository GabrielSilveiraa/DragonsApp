# DragonsApp 
[![Build Status](https://travis-ci.com/GabrielSilveiraa/DragonsApp.svg?branch=develop)](https://travis-ci.com/GabrielSilveiraa/DragonsApp) [![codecov](https://codecov.io/gh/GabrielSilveiraa/DragonsApp/branch/develop/graph/badge.svg)](https://codecov.io/gh/GabrielSilveiraa/DragonsApp)

## Installation

### Installing Carthage
If you already have carthage intalled, you can jump to next step.

If you don't, run on terminal to install Homebrew:
```
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
```

Ant then, run on terminal to install carthage:
```
$ brew install carthage
```

### Installing project's dependencies
Navigate to the root directory of this project in Terminal (the directory that contains the .xcodeproj file).

Run on terminal:
```
$ carthage update --platform iOS
```

### Running the project
Open the .xcodeproj file and run


## Architecture

The project's architecture is MVVM-C. The MVVM presentation pattern using Coordinators to route the app.

The app is built in Features, composed by a Coordinator and Scenes.
The Coordinator is responsible for a specific flow or story, so it may be responsible for one or more Scenes.

Every Scene is developed using the MVVM presentation architecture, along with a viewcoded layer and a service class for any network request.


## Dependencies

* [SnapKit](https://github.com/SnapKit/SnapKit)
* [Kingfisher](https://github.com/onevcat/Kingfisher)

