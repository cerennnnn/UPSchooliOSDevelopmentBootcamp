//
//  main.swift
//  RockPaperScissorsHW1
//
//  Created by Ceren Güneş on 18.06.2023.
//

import Foundation

enum Choices: String {
    case rock = "🪨"
    case paper = "📃"
    case scissors = "✂️"
}

//MARK: - Computer's choice
func systemsChoice() -> String {
    let choices: [Choices] = [.rock, .paper, .scissors]
    let randomNumber = Int.random(in: 0...2)
    
    return choices[randomNumber].rawValue
}

func startGame(user: String, system: Choices) {
    var result = ""
    
    switch user {
    case "rock":
        result = system == .rock ? "Try again." : (system == .paper ? "You lost." : "You win.")
    case "paper":
        result = system == .paper ? "Try again." : (system == .scissors ? "You lost." : "You win.")
    case "scissors":
        result = system == .scissors ? "Try again." : (system == .rock ? "You lost." : "You win.")
    default:
        print("Plese enter a valid answer.")
    }
    
    print(result)
}

let system = systemsChoice()
chooseYourWeapon()

//MARK: - User's choice
func chooseYourWeapon() {
    print("🪨 - 📃 - ✂️ shoot!")
    let user = readLine()
    
    if let safeUserAnswer = user {
        startGame(user: safeUserAnswer, system: Choices(rawValue: system)!)
        print("User: \(safeUserAnswer) - system: \(system)")
    }
    
}


