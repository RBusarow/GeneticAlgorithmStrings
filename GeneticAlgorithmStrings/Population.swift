//
//  Population.swift
//  GeneticAlgorithmStrings
//
//  Created by Rick Busarow on 1/20/17.
//  Copyright © 2017 Rick Busarow. All rights reserved.
//

import Cocoa

class Population {

    var population : [DNA]            // fixed size, unique

    var totalWeightLastGeneration : Int64
    var totalWeightThisGeneration : Int64
    var averageFitnessPercentage : Double
    var bestFitnessPercentage : Int
    var bestString : String
    
    init() {
        population = [DNA]()
        totalWeightLastGeneration = 0
        totalWeightThisGeneration = 0
        averageFitnessPercentage = 0
        bestFitnessPercentage = 0
        bestString = ""
    }
    
    func createInitialPopulation() {
        var dna : DNA
        for i in 0...Settings.populationSize {
            dna = DNA(id: i)
            population.append(dna)
            updateGenerationStatistics(dna: dna, id: i)
        }
    }

    func createNextGeneration() {
        resetGenerationStatistics()
        var dna : DNA
        var one : DNA
        var two : DNA
        for i in 0..<population.count {
            one = getWeightedRandomDNA()
            two = getWeightedRandomDNA()
            while (two.id == one.id) {
//                print("doing this inner loop for ",i)
                two = getWeightedRandomDNA()
            }
            dna = DNA(one: one, two: two, id: i)
            population[i] = dna
            updateGenerationStatistics(dna: dna, id: i)
        }
    }
    
    func resetGenerationStatistics() {
        totalWeightLastGeneration = totalWeightThisGeneration
        totalWeightThisGeneration = 0
        averageFitnessPercentage = 0
        bestFitnessPercentage = 0
        bestString = ""
    }
    
    func updateGenerationStatistics(dna : DNA, id : Int) {
        averageFitnessPercentage += Double(dna.fitnessPercentage) / Double(Settings.populationSize)
        totalWeightThisGeneration += dna.fitness
        if dna.fitnessPercentage > bestFitnessPercentage {
            bestFitnessPercentage = dna.fitnessPercentage
            bestString = dna.stringValue()
        }
    }
    
    func getWeightedRandomDNA() -> DNA {
        let random = Int(arc4random_uniform(UInt32(totalWeightLastGeneration)))
        var sum = 0
        for dna in population {
            sum += dna.fitness
            if random < sum {
                return dna
            }
        }
        return DNA(id: 0)      // unreachable
    }
    
        
}
