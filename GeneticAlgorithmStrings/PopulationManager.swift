//
//  PopulationManager.swift
//  GeneticAlgorithmStrings
//
//  Created by Rick Busarow on 1/20/17.
//  Copyright © 2017 Rick Busarow. All rights reserved.
//

import Cocoa

class PopulationManager {
    
    var generationNumber : Int
    var population : Population
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    init() {
        generationNumber = 0
        population = Population()
    }
    
    func run() {
        population.createInitialPopulation()
        generationNumber += 1
        reportGenerationStatistics()

        while population.bestFitnessPercentage < 100 {
            generationNumber += 1
            population.createNextGeneration()
            reportGenerationStatistics()
        }
    }
    
    func reportGenerationStatistics() {
        print("==========================================================")
        print("Generation ------------------> ", generationNumber)
        print("average fitness percentage --> ", Int(population.averageFitnessPercentage))
        print("best fitness percentage -----> ", population.bestFitnessPercentage)
        print("best string --> ", population.bestString)
    }
    

}
