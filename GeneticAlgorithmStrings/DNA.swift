//
//  DNA.swift
//  GeneticAlgorithmStrings
//
//  Created by Rick Busarow on 1/20/17.
//  Copyright © 2017 Rick Busarow. All rights reserved.
//

import Cocoa

class DNA {

    var chars: [Character]
    var fitness: Int
    var fitnessPercentage: Int
    var id: Int

    init(id: Int) {
        self.id = id
        chars = [Character]()
        fitness = 0
        fitnessPercentage = 0
        breed()
        calculateFitness()
    }

    init(one: DNA, two: DNA, id: Int) {
        self.id = id
        chars = [Character]()
        fitness = 0
        fitnessPercentage = 0
        crossOver(one: one, two: two)
        calculateFitness()
    }

    func breed() {
        for _ in 0 ..< Settings.objectiveStringCharacterCount {
            chars.append(randomChar())
        }
    }

    func crossOver(one: DNA, two: DNA) {
        let ran = random(bound: Settings.objectiveStringCharacterCount)
        copyOrMutateChars(lowerBound: 0, upperBound: ran, parentChars: one.chars)
        copyOrMutateChars(lowerBound: ran, upperBound: Settings.objectiveStringCharacterCount, parentChars: two.chars)
    }

    func copyOrMutateChars(lowerBound: Int, upperBound: Int, parentChars: [Character]) {
        for i in lowerBound ..< upperBound {
            if shouldMutate() {
                self.chars.append(randomChar())
            } else {
                self.chars.append(parentChars[i])
            }
        }
    }

    func shouldMutate() -> Bool {
        return random(bound: Settings.mutationChanceBound) < Settings.mutationChance
    }

    func randomChar() -> Character {
        return Settings.possibleStringCharacters[random(bound: Settings.possibleStringCharacterCount)]
    }

    func calculateFitness() {
        var sum = 0

        for i in 0 ..< chars.count {
            if chars[i] == Settings.objectiveStringCharacters[i] {
                sum += 1
            }
        }

        fitnessPercentage = Int(Float(sum) / (Float(Settings.objectiveStringCharacterCount) * 0.01))

        fitness = fitnessPercentage * fitnessPercentage
    }

    func random(bound: Int) -> Int {
//        print("bound --> ", bound)
        return Int(arc4random_uniform(UInt32(bound)))
    }

    func stringValue() -> String {
        return ("\(chars.map({ String(describing: $0) }).joined())")
    }

}
