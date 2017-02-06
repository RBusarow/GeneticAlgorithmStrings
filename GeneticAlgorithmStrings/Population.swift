//
//  Population.swift
//  GeneticAlgorithmStrings
//
//  Created by Rick Busarow on 1/20/17.
//  Copyright © 2017 Rick Busarow. All rights reserved.
//

import Cocoa

class Population {

    var population : [Individual]            // fixed size, unique

    var totalWeightLastGeneration : Int64
    var totalWeightThisGeneration : Int64
    var averageFitnessPercentage : Double
    var bestFitnessPercentage : Int
    var bestString : String
    
    init() {
        population = [Individual]()
        totalWeightLastGeneration = 0
        totalWeightThisGeneration = 0
        averageFitnessPercentage = 0
        bestFitnessPercentage = 0
        bestString = ""
    }
    
    func createInitialPopulation() {
        var individual: Individual
        for i in 0...Settings.populationSize {
            individual = Individual(id: i)
            population.append(individual)
            updateGenerationStatistics(individual: individual, id: i)
        }
    }

    func createNextGeneration() {
        resetGenerationStatistics()
        var individual: Individual
        var one : Individual
        var two : Individual
        for i in 0..<population.count {
            one = getWeightedRandomIndividual()
            two = getWeightedRandomIndividual()
            while (two.id == one.id) {
//                print("doing this inner loop for ",i)
                two = getWeightedRandomIndividual()
            }
            individual = Individual(one: one, two: two, id: i)
            population[i] = individual
            updateGenerationStatistics(individual: individual, id: i)
        }
    }
    
    func resetGenerationStatistics() {
        totalWeightLastGeneration = totalWeightThisGeneration
        totalWeightThisGeneration = 0
        averageFitnessPercentage = 0
        bestFitnessPercentage = 0
        bestString = ""
    }
    
    func updateGenerationStatistics(individual : Individual, id : Int) {
        averageFitnessPercentage += Double(individual.fitnessPercentage) / Double(Settings.populationSize)
        totalWeightThisGeneration += individual.fitness
        if individual.fitnessPercentage > bestFitnessPercentage {
            bestFitnessPercentage = individual.fitnessPercentage
            bestString = individual.stringValue()
        }
    }
    
    func getWeightedRandomIndividual() -> Individual {
        let random = Int(arc4random_uniform(UInt32(totalWeightLastGeneration)))
        var sum = 0
        for individual in population {
            sum += individual.fitness
            if random < sum {
                return individual
            }
        }
        return Individual(id: 0)      // unreachable
    }
    
        
}
