//
//  DisplayGameListView.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import SwiftUI

struct DisplayGameListView: View {
    
    @ObservedObject var displayGames: DisplayGameListViewModel
    
    var intent: DisplayGameListIntent
    
    private var url: String = "https://festival-jeu.herokuapp.com/api/games/current"
    
    init(displayGames: DisplayGameListViewModel) {
        self.displayGames = displayGames
        self.intent = DisplayGameListIntent(games: displayGames)
        let _ = self.displayGames.$displayGameListState.sink(receiveValue: stateChanged)
        endOfInit()
    }
    
    func endOfInit() {
        self.intent.loadGames(url: url)
    }
    
    func stateChanged(state: DisplayGameListState) {
        switch state {
        case let .loading(url):
            print("is loading url : \(url)")
        case .new:
            print("games data arrived")
        default:
            return
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(self.displayGames.model) { game in
                    Text("\(game.name)")
                }
            }
        }
    }
}

//struct DisplayGameListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayGameListView()
//    }
//}
