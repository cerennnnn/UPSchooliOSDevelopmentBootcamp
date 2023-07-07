//
//  Enums.swift
//  RockPaperScissorsGame
//
//  Created by Ceren Güneş on 7.07.2023.
//

import Foundation

enum GameElement: String {
    case rock, paper, scissors
    
    static var allCases: [GameElement] {
        return [.rock, .paper, .scissors]
    }
    
    var gameElement: String {
        switch self {
        case .rock:
            return "🪨"
        case .paper:
            return "📃"
        case .scissors:
            return "✂️"
        }
    }
}
