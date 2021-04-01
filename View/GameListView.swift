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
    
    @State var textSearch: String = ""
    
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
    
    private func filterSearch(game: GameViewModel) -> Bool {
        var res: Bool = true
        
        if !textSearch.isEmpty {
            res = game.name.contains(textSearch)
        }
        
        return res
    }
    
    var body: some View {
        return NavigationView {
            VStack {
                Spacer().frame(height: 50)
                Text("Liste de jeux du festival")
                Spacer().frame(height: 50)
                TextField("Recherche d'un jeu", text: $textSearch).font(.footnote).padding(10).background(Color.white)
                Spacer().frame(height: 50)
                ZStack {
                    List {
                        ForEach(self.gameList.games.filter(filterSearch)) { game in
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
