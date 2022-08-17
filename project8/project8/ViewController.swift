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
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var score = 0
    var level = 1
    
    let submit = UIButton(type: .system)
    let clear = UIButton(type: .system)
    let buttonsView = UIView()
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()

        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()

                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]

                    clueString += "\(index + 1). \(clue)\n"

                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)

                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

        letterBits.shuffle()

        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        loadLevel()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        
    }

    @objc func submitTapped(_ sender: UIButton) {
        
    }

    @objc func clearTapped(_ sender: UIButton) {
        
    }
}

extension ViewController {
    func style() {
        
        // Labels
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
//        cluesLabel.backgroundColor = .red // so pra ver melhor
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
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
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        
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
                // cria um novo botão e dá a ele um tamanho de fonte grande
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                // dá ao botão algum texto temporário para que possamos vê-lo na tela
                letterButton.setTitle("ABC", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                // calcula o "frame" deste botão usando sua coluna e linha
                let frame = CGRect(x: col * 152, y: row * 82, width: 141, height: 71)
                letterButton.frame = frame
                letterButton.layer.borderWidth = 1
                letterButton.layer.cornerRadius = 15
                letterButton.backgroundColor = .systemGray6
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
    }
}
