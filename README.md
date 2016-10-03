# Semi-Markov Decision Process Learning Agent

# Top –level organization
* common - individual executables, many of which load drivers (contained in ../libs)
* fnapprox – function approximation code
* learning – main folder for reinforcement learning code
* MDP – Markov decision process utilities

# Overview
This code base makes heavy use of abstract base classes and multiple inheritance. The base classes and derived classes are as follows:
* Learner qlearner, sarsalearner
* Agent simpleagent (lives on a line), gridagent (lives on a grid)
* Approximator linearapproximator

You can instantiate a learning problem with any combination of agent, learner, and approximator.  The main runfile is …/learning/mainthread.m. The bulk of the algorithms are contained in the agent subclasses and learner subclasses.
The MDP and common directories have utilities for conversions, plotting, and other periphery functions.


