//
//  GameList.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import Foundation

class GameList {
    
    private(set) var games = [Game]()
    
    func new(games: [Game]) {
        self.games = games
    }
}
