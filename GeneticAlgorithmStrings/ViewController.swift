//
//  ViewController.swift
//  GeneticAlgorithmStrings
//
//  Created by Rick Busarow on 1/20/17.
//  Copyright © 2017 Rick Busarow. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var RunButton: NSButtonCell!
    
    var manager : PopulationManager = PopulationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        manager = PopulationManager()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func runButtonClicked(_ sender: NSButtonCell) {
        manager.run()
    }
}

