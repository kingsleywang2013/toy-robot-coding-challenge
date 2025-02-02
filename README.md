# Toy Robot Coding Puzzle

This is a command line Ruby application that simulates a robot
on a specifiable grid

## Table of contents:

* [Description](./README.md#description)
  * [Constraints](./README.md#constraints)
  * [Example Input and Output](./README.md#example-input-and-output)
* [Setup](./README.md#setup)
* [Running the app](./README.md#running-the-app)
* [Running the tests](./README.md#running-the-tests)

## Description

- The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement
  that would result in the robot falling from the table must be prevented, however further valid movement commands must still
  be allowed.

- Create an application that can read in commands of the following form:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is currently facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.

- A robot that is not on the table can choose the ignore the MOVE, LEFT, RIGHT and REPORT commands.
  . Input can be from a file, or from standard input, as the developer chooses.
  . Provide test data to exercise the application.

## Constraints:

> The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
> Any move that would cause the robot to fall must be ignored.

### Example Input and Output:

a)

```
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH
```

b)

```
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST
```

c)

```
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```

## Setup

1. Install the [bundler gem](http://bundler.io/) by running:

    ```gem install bundler```

2. Clone this repo:

    ```git clone git@github.com:kingsleywang2013/toy_robot_coding_challenge.git```

3. Change to the app directory:

    ```cd toy_robot_coding_challenge```

4. Install dependencies:

    ```bundle install```

And you're ready to go!

### Running the app

#### Running the app by CLI:
```ruby toy_robot.rb```

#### Running the app by file
```ruby toy_robot.rb -f robot_success.txt```
or
```ruby toy_robot.rb --file robot_success.txt```

```ruby toy_robot.rb -f robot_hit_edge.txt```
or
```ruby toy_robot.rb --file robot_hit_edge.txt```

### Running the tests:
```bundle exec rspec```
