//
//  ViewController.swift
//  GeneticAlgorithmStrings
//
//  Created by Rick Busarow on 1/20/17.
//  Copyright © 2017 Rick Busarow. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var generationNumber: Int = 0
    var population: Population = Population()
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)

    @IBOutlet weak var RunButton: NSButtonCell!

    var manager: PopulationManager!

    @IBOutlet weak var objectiveStringTextField: NSTextField!
    @IBOutlet weak var bestFitnessLabel: NSTextField!
    @IBOutlet weak var averageFitnessLabel: NSTextField!
    @IBOutlet weak var bestStringLabel: NSTextField!
    @IBOutlet weak var generationLabel: NSTextField!

    @IBOutlet weak var populationSizeTextField: NSTextField!
    @IBOutlet weak var mutationRateTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        objectiveStringTextField.stringValue = Settings.objectiveString
        populationSizeTextField.stringValue = String(Settings.populationSize)
        mutationRateTextField.stringValue = String(Settings.mutationChance)
    }

    override var representedObject: Any? {
        didSet {
        }
    }

    @IBAction func runButtonClicked(_ sender: NSButtonCell) {
        Settings.objectiveString = objectiveStringTextField.stringValue
        if let popSize = Int(populationSizeTextField.stringValue) {
            Settings.populationSize = popSize
        }
        if let mutationRate = Int(mutationRateTextField.stringValue) {
            Settings.mutationChance = mutationRate
        }
        queue.async {
            self.run()
        }
    }

    @IBAction func objectiveStringFieldUpdated(_ sender: NSTextField) {
        Settings.objectiveString = sender.stringValue
    }

    func run() {
        generationNumber = 0
        population = Population()
        population.createInitialPopulation()
        generationNumber += 1
        updateGenerationStatistics()

        while population.bestFitnessPercentage < 100 {
            generationNumber += 1
            population.createNextGeneration()
            updateGenerationStatistics()
        }
    }

    func updateGenerationStatistics () {
        let generationNumber = String(self.generationNumber)
        let averageFitness = String(Int(self.population.averageFitnessPercentage))
        let bestFitness = String(self.population.bestFitnessPercentage)
        let bestString = self.population.bestString

        DispatchQueue.main.async {
            self.updateGenerationStatistics(generationNumber: generationNumber,
                    averageFitness: averageFitness,
                    bestFitness: bestFitness,
                    bestString: bestString)
        }
    }

    func updateGenerationStatistics(generationNumber : String,
                                    averageFitness : String,
                                    bestFitness : String,
                                    bestString : String) {

        generationLabel.stringValue = generationNumber
        averageFitnessLabel.stringValue = averageFitness
        bestFitnessLabel.stringValue = bestFitness
        bestStringLabel.stringValue = bestString
    }
}

