//
//  Settings.swift
//  GeneticAlgorithmStrings
//
//  Created by Rick Busarow on 1/20/17.
//  Copyright © 2017 Rick Busarow. All rights reserved.
//

import Foundation

struct Settings {

//    static var objectiveString = "to be, or not to be - that is the question:"
    static var objectiveString = "to be, or not to be"
    static var objectiveStringCharacters = [Character](objectiveString.characters)
    static var objectiveStringCharacterCount = objectiveStringCharacters.count

    static var possibleString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\" -':;,.?!"
//    static var possibleString = "abcdefghijklmnopqrstuvwxyz -':;,.?!"
    static var possibleStringCharacters = [Character](possibleString.characters)
    static var possibleStringCharacterCount = possibleStringCharacters.count

    static var mutationChance = 5
    static var mutationChanceBound = 1000

    static var populationSize = 500
}
