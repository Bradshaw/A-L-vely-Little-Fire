Diplodocus
==========

Diplodocus is a set of utilities for Löve2D and/or Lua   
It's unfinished   
Not because I'm not done making it yet, but because it is in an eternal state of flux, abandonment and iterative "just add a thing to do the thing"   


## Shade

A little shader utility to make little shader stacks to easily apply screen effects   

## Event

A little eventing/messaging system   
It's not done yet, it'll be done when I need it   

## Query

A LINQ-style thing, for Lua  
It's not even started, nothing to see here

## Thing

I always do the same thing for game objects in Löve2D, so here's a quick way to get to that as quickly as possible   
The magic here is the ```obj.map``` metatable function generator   
Call ```MyThing.map.draw()``` to call the method ```draw``` on each ```MyThing``` instance

## Useful

A bunch of useful helper functions   
Cool shit includes:

* ```useful.upairs```, which is an alternative to Lua's ``ìpairs``` which removes elements from the table as needed
* ```useful.sign``` and ```useful.lerp``` which should have been in ```math``` all along
* ```useful.copy``` for a dumb deep copy of tables
* ```useful.nrandom``` for a normally-distributed random number generator
* And more!

## Vector

A little 2D Vector thing, I should probably use it more often, but I keep forgetting I made it
Therefore it is untested, and incomplete