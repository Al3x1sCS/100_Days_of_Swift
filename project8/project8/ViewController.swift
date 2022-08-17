//
//  ViewController.swift
//  project8
//
//  Created by user on 17/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    let submit = UIButton(type: .system)
    let clear = UIButton(type: .system)
    let buttonsView = UIView()
    let stackView = UIStackView()
    
    let width = 150
    let height = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
}

extension ViewController {
    func style() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // Labels
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Pontuação: 0"
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "PISTAS"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
//        cluesLabel.backgroundColor = .red // so pra ver melhor
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "RESPOSTAS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
//        answersLabel.backgroundColor = .blue // so pra ver melhor
        
        // Text Fields
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
//        currentAnswer.backgroundColor = .green // so pra ver melhor
        
        // Buttons
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        
        // Buttons View
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.cornerRadius = 15
        
        
    }
    
    func layout() {
        
        view.addSubview(scoreLabel)
        view.addSubview(cluesLabel)
        view.addSubview(answersLabel)
        view.addSubview(currentAnswer)
        view.addSubview(submit)
        view.addSubview(clear)
        view.addSubview(buttonsView)
        
        // SCORE
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
        
        // CLUES
        NSLayoutConstraint.activate([
            // fixa a parte superior do "cluesLabel" na parte inferior do "scoreLabel"
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            // fixa a borda inicial do "cluesLabel" na borda inicial de nossas margens do layout, adicionando 100 para dar espaço
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            // faz o "cluesLabel" 60% da largura de nossas margens de layout, menos 100
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100)
        ])
        
        // ANSWERS
        NSLayoutConstraint.activate([
            // fixa a parte superior do "answersLabel" na parte inferior do "scoreLabel"
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            // Faz com que o "answersLabel" fique na borda de nossas margens de layout, menos 100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            // faz o "answersLabel" 40% da largura de nossas margens de layout, menos 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            // faz com que o "answersLabel" corresponda à altura do "cluesLabel"
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor)
        ])
        
        // CURRENT ANSWER
        NSLayoutConstraint.activate([
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20)
        ])
        
        // SUBMIT BUTTON
        NSLayoutConstraint.activate([
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // CLEAR BUTTON
        NSLayoutConstraint.activate([
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // BUTTON VIEW
        NSLayoutConstraint.activate([
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        // KEYBOARD BUTTONS
        for row in 0..<4 {
            for col in 0..<5 {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                // give the button some temporary text so we can see it on-screen
                letterButton.setTitle("ABC", for: .normal)
                
                // calculate the frame of this button using its column and row
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                letterButton.layer.borderWidth = 1
                letterButton.layer.cornerRadius = 15
                letterButton.backgroundColor = .systemGray6
                
                // add it to the buttons view
                buttonsView.addSubview(letterButton)
                
                // and also to our letterButtons array
                letterButtons.append(letterButton)
            }
        }
        
    }
}
