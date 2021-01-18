# CapsuleWars
> A 3D multiplayer FPS (First Person Shooter) made in Godot, using GDScript.

A small project developed to allow up to 6 players play a short and fun FPS match online. The game has many features present in the majority games of the genre and shows the capabilities of Godot engine.

![](https://i.ibb.co/2kkhrkp/Capsule-Wars-Screen.jpg)

## Installation

Windows:

1. Download the CapsuleWars.rar file from [releases](https://github.com/lucassene/CapsuleWars/releases).
2. Install it in your disk. You need *both* the .exe and .pck files.

## Hosting a game

1. Give your external IP to any of your friends that you want to play with.
2. If you want, you can change the default port (23571) to any other. Just type it in the *Port* Field in the lobby inside the game.
3. If you connect to the internet through a router or modem you will need to port forward the desired port in your device's configuration. If you need any help, try this [website](https://www.noip.com/support/knowledgebase/general-port-forwarding-guide/).
4. With the above steps taken care, just hit the *Host* button.

## Joining a game

1. Have the external IP of the person which will be hosting
2. Type the IP in the *IP* field in the lobby inside the game.
3. If the host changed the default port, type it in the *Port field*, ortherwise, leave it blank.
3. Hit the *Join* button.

## Features

This games presents features, such as:
- A multiplayer game that uses P2P (Peer-to-peer) connection.
- A lobby screen where players can host/join a game, with a chatlog providing feedback on the connection statuses.
- A player Finite State Machine.
- Heavy usage of signals (callbacks).
- Player position interpolation to minimize lag effect.
- Inherited scenes.
- Exported variables that can alter different weapon's behaviour inside the editor, without the need of any coding.
- Usage of particles in blood and bullets.
- A scalable UI.
- Simple animations made with the bult-in Godot's Animation Player.
- Usage of singletons (autoloads).
- The level was prototyped with CSG primitives. Some of them were changed afterward to regular meshes to improve performance.
- Designed with scalability in mind.


## Release History

* 1.0.0-beta
    * First beta version release

## Meta

Lucas Sene Grandchamp – lsgrandchamp@gmail.com

[https://github.com/lucassene](https://github.com/lucassene)
