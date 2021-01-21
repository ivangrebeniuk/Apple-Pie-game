//
//  Game.swift
//  Apple Pie
//
//  Created by Иван Гребенюк on 20.01.2021.
//

import Foundation

struct Game {
    var word: String
    var IncorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += String(letter)
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) -> Bool {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            IncorrectMovesRemaining -= 1
            return false
        } else {
            return true
        }
    }
}
