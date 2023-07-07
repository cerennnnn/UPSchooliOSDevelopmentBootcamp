//
//  GameState.swift
//  RockPaperScissorsGame
//
//  Created by Ceren Güneş on 7.07.2023.
//

import Foundation

enum GameState {
    case win, lose, scoreless
    
    var gameState: String {
        switch self {
        case .win:
            return "You win! 🥳"
        case .lose:
            return "You lost 😕"
        case .scoreless:
            return "It's a draw. 😶"
        }
    }
}
