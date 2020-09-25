#  Game of Life Notes

In the Game of Life, these rules examine each cell of the grid. For each cell, it counts that cell's eight neighbors (up, down, left, right, and diagonals), and then act on that result.
* If the cell is alive and has 2 or 3 neighbors, then it remains alive. Else it dies.
* If the cell is dead and has exactly 3 neighbors, then it comes to life. Else if remains dead.
From those two rules, many types of "creatures" can be created that move around the "landscape".
Note: cells that are off the edge of the grid are typically assumed to be dead. (In other cases, people sometimes code it up to wrap around to the far side.)

For a space that is 'populated':
Each cell with one or no neighbors dies, as if by solitude.
Each cell with four or more neighbors dies, as if by overpopulation.
Each cell with two or three neighbors survives.
For a space that is 'empty' or 'unpopulated'
Each cell with three neighbors becomes populated.

***Cellular Automata***
A cellular automaton (plural: cellular automata, abbreviated CA) is a program that operates on data typically stored in a 2D grid. (1D, 3D and n-D cellular automata run on lines, cubes, etc.)
A simple set of rules describes how the value in a cell on the grid changes over time, often as the result of the states of that cell's neighbors.
Sometimes neighbors includes the 4 orthogonally adjacent cells; sometimes it includes all 8 surrounding cells including diagonals.
Each round of the simulation examines the current state of the grid, and then produces an entirely new grid consisting of the old state. (Remember the discussion about double buffers earlier--we don't want to modify the same grid we're examining, lest we munge future results.)
This new grid becomes the "current" state of the simulation, and the process repeats. Each new grid is referred to as a generation.
The beautiful thing about cellular automata is that sometimes very complex behavior can emerge from very simple rules.
Practically speaking, CAs have been used in biological and chemical simulations and other areas of research, such as CA-based computer processors, and other numeric techniques.

***Turing Completeness***
We say a computing system is Turing Complete if it is capable of performing arbitrary, general purpose computation.
Using a construct in The Game of Life called a glider gun, it's possible to build a rudimentary NAND gate in the Game of Life. While a NAND gate by itself isn't enough to be Turing Complete, the "infinite" grid of The Game of Life allows you to use them (or any other functionally complete operator) to build any other type of logical "circuitry" and memory, as well.
Anything computable can be computed in The Game of Life given a large enough grid and enough time. Most people, however, find JavaScript to be a far easier development medium.

***Double Buffering***
There's a technique that's commonly used in graphics programming called double buffering. This is when we display one buffer to the user, but do work on one that's hidden from sight. In this way, the user doesn't see the buffer being generated, they only see the one that was previously completed.
When we're done doing work on the hidden buffer, we page flip and show the hidden buffer to the user. Then the previously-displayed buffer becomes the new hidden buffer, and work begins again.
There are multiple benefits to this approach.
One is that the user doesn't see the work being progressively completed. From their perspective, the work is suddenly done as soon as the page flips.
Another is that the program can use the previous buffer (i.e. the one that is currently being displayed) as a source for material to perform calculations to produce the next buffer. This is particularly beneficial where you need to produce a completely new output based on the complete previous output. If you were to only use a single buffer, you'd have to overwrite the pixels as you went, and this might affect the outcome of the subsequent pixels in an undesirable way.
And this is very useful when implementing a cellular automaton.
There will be two arrays of data for the automaton. One of them holds the data that the user currently sees on the canvas. The other one is where the next frame to be shown is being actively constructed.
After the new frame is constructed, the next from becomes the current frame, and the current frame becomes the next frame. And the process repeats.
Also note that this approach is vaguely reminiscent of the Model and View in the MVC pattern where the Model is manipulated then displayed by the View.

***Building Your App***

Visualizing the "Game of Life"

The main entry point of your application should house the visualization of this cellular automaton. Include necessary components, such as:

Grid to display cells.
Cell objects or components that, at a minimum, should have:
Properties
current state: (alive, dead), (black, white)
Clickable/Tappable:
can be clicked to allow user to setup initial cell configuration
should NOT be clickable while simulation is running
Behaviors
Toggle state functionality: switch between alive & dead either because user manually toggled cell before starting simulation or simulation is running and rules of life caused cell to change state
An appropriate data structure to hold a grid of cells that is at least 25x25. Go as big as you want.
Text to display current generation # being displayed
Utilize a timeout function to build the next generation of cells & update the display at the chosen time interval
Button(s) that start & stop the animation
Button to clear the grid
Write an algorithm that:

Implements the following basic steps:
For each cell in the current generation's grid:
Examine state of all eight neighbors (it's up to you whether you want cells to wrap around the grid and consider cells on the other side or not)
Apply rules of life to determine if this cell will change states
When main loop completes:
Swap current and next grids
Repeat until simulation stopped
Breaks down above steps into appropriate sub-tasks implemented with helper functions to improve readability
Uses double buffering to update grid with next generation.
Does something well-documented with the edge of the grid. (e.g. wrap around to the far side--most fun!--or assumes all edge cells are permanently dead.)
Custom Features

Implement at least 3 of the following features:

Create a few sample cell configurations that users can load and run
Add an option that creates a random cell configuration that users can run
Add additional cell properties, like color or size, and incorporate them into your visualization
Allow users to specify the speed of the simulation
Provide functionality to manually step through the simulation one generation at a time, as opposed to animating automatically
Allow users to change the dimension of the grid being displayed
Given a specific generation, calculate the configuration of cells at that point in time, and jump to that state, bypassing animation (i.e. skip ahead n generations).
If you have an idea for a custom feature on this list, run it by your TL or instructor
About

On the main entry point of the application, include a separate section or link to another page or popup that describes the two main rules (birth & death) of Conway’s Game of Life
