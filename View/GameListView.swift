//
//  DisplayGameListView.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import SwiftUI

struct GameListView: View {
    
    @ObservedObject var gameList: GameListViewModel
    
    var intent: GameListIntent
    
    private var url: String = "https://festival-jeu.herokuapp.com/api/games/current"
    
    init(gameList: GameListViewModel) {
        self.gameList = gameList
        self.intent = GameListIntent(gameList: gameList)
        let _ = self.gameList.$gameListState.sink(receiveValue: stateChanged)
        endOfInit()
    }
    
    func endOfInit() {
        self.intent.loadGames(url: url)
    }
    
    func stateChanged(state: GameListState) {
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
        return NavigationView {
            VStack {
                Spacer().frame(height: 50)
                Text("Liste de jeux du festival")
                
                ZStack {
                    List {
                        ForEach(self.gameList.games) { game in
                            NavigationLink(
                                
                                destination: AreaListView(game: game, areaList: AreaListViewModel()),
                                label: {
                                    Text("\(game.name)")
                                }
                            )
                        }
                    }
                }
            }.navigationTitle("Liste des jeux").background(Color.blue.opacity(0.1))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct DisplayGameListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayGameListView()
//    }
//}
