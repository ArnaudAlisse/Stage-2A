Hello !

This repository is pretty easy to understand. First there is the matlab files (toy.m, toy1.m, toy2.m), these files are just the network that will be used in the simulation. Every network can be used as a basis for
TNEP problems (there is potentials lines), and there is also AC and DC lines in every network. I hope in the future there will also be superconducting cables.

toy.m is a network where there is no link between the offshore wind power plant and the onshore demand, toy2 is the same but with a 4th generator that is pretty expensive the land, toy1 is a network that can work
without solving a TNEP and then updating it, it is the network that is used for every comparison.


Then, there is the two julia files "Toy, TNEP& OPF" and "some functions". The first one is the file running the simulation, a loop start in the simulation, at each iteration it loads the matpower files, the modify the initial situation
(load on a specific bus for example), solve TNEP & OPF problems, stock the result. Once it's out of the loop it plots the results.

"Some functions" is as its name says a file where I wrote useful functions the simulation.


The goal of this simulation is to know which structure of network is optimal, which cable should be used between which buses.. I tried to make it easy to understand with a lot of comments in order to also make it a door to learn some features of PowerModels or PowerModelsACDC.

Feel free to modify anything you want, I'm sure these files can be improved a lot but I lack the knowledge to do so.

Best regards,
Arnaud
