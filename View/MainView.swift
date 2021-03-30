//
//  MainView.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import SwiftUI

struct MainView: View {
    
    @State private var tabSelected = 0
    @ObservedObject var displayFestival: FestivalViewModel
    
    var intent : FestivalIntent
    
    private var url : String = "https://festival-jeu.herokuapp.com/api/festivals/current/games"
    
    init(displayFestival: FestivalViewModel) {
        self.displayFestival = displayFestival
        self.intent = FestivalIntent(festival: displayFestival)
        let _ = self.displayFestival.$displayFestivalState.sink(receiveValue: stateChanged)
        endOfInit()
    }
    
    func endOfInit(){
        self.intent.loadFestival(url: url)
    }
    
    func stateChanged(state: DisplayFestivalState){
        switch state {
        case let .loading(url):
            print("is loading with url : \(url)")
        case .new:
            print("festival data arrived")
            // faire dernier appel à l'intent
        default:
            return
        }
    }
    
    var body: some View {
        TabView(selection: $tabSelected){
            FestivalPresentationView()
                .tabItem{
                    Label("Accueil", systemImage: "rectangle.and.text.magnifyingglass")
                    
                }.tag(0)
            DisplayFestivalView(displayFestival: displayFestival)
                .tabItem{
                    Label("Zones", systemImage: "rectangle.dashed.badge.record")
                    
                }.tag(1)
            GameListView(gameList: GameListViewModel(gameList: GameList()))
                .tabItem{
                    Label("Jeux", systemImage: "gamecontroller")
                }.tag(2)
            EditorListView()
                .tabItem {
                    Label("Editeurs", systemImage: "figure.wave")
                }
                .tag(3)
            
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
