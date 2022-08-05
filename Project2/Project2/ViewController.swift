//
//  ViewController.swift
//  project2
//
//  Created by user on 04/08/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", ]
        
        countries.append()
        countries.append()
        countries.append()
        countries.append()
        countries.append()
        countries.append()
        countries.append()
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")

    }


}

