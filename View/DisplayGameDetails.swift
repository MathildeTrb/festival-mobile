//
//  DisplayGameDetails.swift
//  festival-mobile
//
//  Created by user188238 on 3/25/21.
//

import SwiftUI

struct DisplayGameDetails: View {
    
    var game : Game
    
    init(game: Game) {
        self.game = game
    }
    
    var body: some View {
        VStack {
            Text("Présentation du jeu : \(game.name)")
            Text("Se joue de \(game.minNumberPlayer) à \(game.maxNumberPlayer) joueurs pour une durée de \(game.duration) minutes")
        }
    }
}

struct DisplayGameDetails_Previews: PreviewProvider {
    static var previews: some View {
        DisplayGameDetails(game: Game(id: 2, name: "assassin's creed", minNumberPlayer: 2, maxNumberPlayer: 4, minYearPlayer: 17, duration: 156, isPrototype: true, manualGame: " ", imageUrl: " ", type: GameType(id: 2, label: "jeux d'avanture"), editor: Editor(id: 3, name: "DUFOUR and co")))
    }
}
