//
//  ViewController.swift
//  Apple Pie
//
//  Created by Иван Гребенюк on 20.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["apple", "bug", "mount", "pineapple",
                       "green", "skateboarding", "circle", "plant", "sky", "moonshine", "mount", "hand", "star", "baloon"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            totalPoints += 5
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var totalPoints = 0

    
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, IncorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(enable: true)
            updateUI()
        } else {
            enableLetterButtons(enable: false)
        }
    }
    
    func updateUI() {
        let letters = currentGame.formattedWord.map {String($0)}
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses), Score: \(totalPoints)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.IncorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.IncorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        updateUI()
    }
    
    func enableLetterButtons(enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        let guessCorrect = currentGame.playerGuessed(letter: letter)
        if guessCorrect {
            totalPoints += 1
        }
        updateGameState()
    }
    
}

