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
    var correctAnswer = 0
    var currentQuestion = 0
    
    let maxQuestion = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 12
        button2.layer.borderWidth = 12
        button3.layer.borderWidth = 12
        
        button1.layer.borderColor = UIColor.systemPurple.cgColor
        button2.layer.borderColor = UIColor.systemPurple.cgColor
        button3.layer.borderColor = UIColor.systemPurple.cgColor
        
        askQuestion()
        
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        currentQuestion += 1
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        
        if currentQuestion > maxQuestion {
            showResult()
            return
        }
        
        updateTitle()
    }
    
    func updateTitle() {
        title = "\(countries[correctAnswer].uppercased()) | Pontos: \(score) | \(currentQuestion) de \(maxQuestion)"
    }
    
    func showResult() {
        let ac = UIAlertController(title: "Fim do jogo", message: "Questões: \(maxQuestion)\nPontuação Final: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Jogar de novo", style: .default, handler: askQuestion))

        score = 0
        correctAnswer = 0
        currentQuestion = 0

        present(ac, animated: true)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String

        if sender.tag == correctAnswer {
            title = "Correto"
            score += 1
            message = "Pontuação: \(score)."
        }
        else {
            title = "Errado"
            score -= 1
            
            message = """
                Sua escolha: \(countries[sender.tag].uppercased())
                A bandeira da \(countries[correctAnswer].uppercased()) é a: #\(correctAnswer + 1)
                Pontuação: \(score)
                """
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continuar", style: .default, handler: askQuestion))
        
        
        updateTitle()
        
        present(ac, animated: true)
    }
    
}

