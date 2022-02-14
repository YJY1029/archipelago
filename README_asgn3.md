# EE6227 Assignment 3

Hi, 

I am quite new to ML and this algorithm design does not take in various cool techniques, but focus on basic GA processes. I tried my best to optimize its code size, performance and readability, cut down as many loops as possible, and I really hope this little piece of code does come in handy with helping you analyzing its principle! 

## To Run These Scripts

1. Simply open MATLAB and go to the root directory, i.e, Assignment3/. 
2. Type *make* in the command line. Or open *make.m* file and click run/press F5. 

Note that for your convenience, if you would just like to check final results, it is strongly recommended to comment all codes in *main.m* from line 59 to line 79. This omits generation data printing and saves up to 95% percent of running time. 

## Basic Code Structure 
make.m 

  -main.m 

    -fitnsort.m 

    -crossover.m 

    -printppl.m

    -chessbd.m 

## Code Introduction 

This introduction goes by code hierarchy and block order. 

### make.m 

*make.m* takes the idea of reconfiguration. Here you can tweaking these parameterized configurations including number of queens, population size, number of generations, mutation probability, and proportion of population you would like to replace for mating pool generation. 

At the end of *make.m*, it calls out *main.m* script named in a process-orientated language style. For fundamental GA case study, process-orientated coding is what I believe easier to understand. 

### main.m 

*main.m* is the main body of the whole genetic algorithm. 

#### initial population 

*Generation Data.txt* stores data for all generations, while *Results.txt* stores only the final population when termination condition is fulfilled. *delete()* helps clear previous data for a new run. 

#### Sort parents by fitness 

***fitnsort()*** is a custom function developed by me, which returns sorted matrix as well as its fitness value in an ascending order. 

This is a necessary step for mating pool generation. 

#### Mating pool generation 

Still not so much to explain about. Simple replace the worst 20% with the best 20%. 

Note that by saying “20%”, actually I mean it’s a reconfigurable coefficient in *make.m*. 

#### Pairing by random token 

In this design, we adopt classical random pairing. 

By generating a non-repetitive sequence from 1 to population size, a random token for pairing is acquired. Element pairs in the token become the serial numbers of elements in the mating pool, assuring completely random pairing. 

After this stage, elements are now in pairs and are ready for crossover. 

#### Crossover with random sites

Similar to random pairing, a token is generated via *rand()* for random crossover site selection. 

***crossover()*** is developed as the operator. Basically, it's just an order 1 crossover operation, where after cut and paste, repetitive queen positions are swapped by other positions. 
After crossover, preliminary offspring are generated. 

#### Mutation of swapping

In *make.m*, a parameter of mutation probability is set. And in this part, for every permutation number, an independent test for mutation is carried out. 

If mutation happens in this bit, another random number will be selected and swapped with this number. 

#### Survivors 

After crossover and mutation, we now have orginal parents and offspring. In the survivor selection part, all these units are sorted in ascending fitness value order. After that, only the population size number of units are kept. 

These survivors are the parents of the next generation. 

#### Results printing 

There are two txt files for results checking. 

To check data by generation, please find them in Generation Data.txt. But there are apparently too many to read, so: 

It's recommended to check Results.txt for final generation results. The algorithm automatically stops when all units reaches minimum fitness value(i.e. maximum fitness), or it reaches maximum generation number. 

***chessbd()*** is a small tool for converting patterns into chessboard expressions.

A 8-queen solution with a population size of 1000 is stored in ./case_study/ folder.  
 
