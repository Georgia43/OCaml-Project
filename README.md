# Ford Fulkerson Algorithm Project

## Goal : implement an algorithm computing the max-flow of a flow graph, using the Ford–Fulkerson algorithm.

# Setup and Compilation

- Fork github project : https://github.com/arbimo/ocaml-maxflow-project
- Copy on INSA repository

This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml Platform* extension in VSCode.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).


# Useful commands

 - `make build` to compile. This creates an `ftest.exe` executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

After running the ford fulkerson algorithm, use commands :

- `dot -Tsvg outfile > some-output-file.svg`  

 -> takes the graph described in outfile (which is the output of your Ford-Fulkerson algorithm) and generates an SVG representation of the graph, saving it to some-output-file.svg.

- `firefox some-output-file.svg`

->  opens the SVG file in the Firefox web browser. 



# Project Structure

- src/           : contains the main OCaml files, including the implementation of the Ford-Fulkerson algorithm
- graphs/        : directory for storing input graph files
- Makefile       : configuration file for build tasks
- .vscode/       : VSCode configuration files


# Trouble with VSCode extention 

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).


# ford_fulkerson

The algorithm operates by augmenting the flow along paths from the source to the sink until no more augmenting paths can be found. It returns the maximum flow computed as well as the final deviation graph.

## Steps
- find augmenting path
- augment the flow using the minimum capacity of the edges
- update capacities on graph
- repeat until termination

## Termination
The algorithm ends when there are no more paths between source and destination so when findPath source destination is empty. 



# Host Matching Project 

## Goal : implement an algorithm enabling to match hackers to hosts while respecting one (or more) constaints

# creation of graph

In order to create the graph, we first start by creating the nodes representing the hosts and the hackers (as well as a source and a sink). Then, to add the arcs, we check the constraint : if the hacker is allergic to cats, he cannot go to a host who has a cat. 

# host mathing using ford_fulkerson

We use ford_fulkerson on the created graph in order to match a hacker to the first host available (while respecting the constraint). 

