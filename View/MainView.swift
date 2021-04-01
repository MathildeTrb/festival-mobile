//
//  MainView.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import SwiftUI

struct MainView: View {
    
    @State private var tabSelected = 1
    @ObservedObject var displayFestival: FestivalViewModel
    
    var intent : FestivalIntent
    
    private var url : String = "https://festival-jeu.herokuapp.com/api/festivals/current/games"
    
    init(displayFestival: FestivalViewModel) {
        self.displayFestival = displayFestival
        self.intent = FestivalIntent(festival: displayFestival)
        endOfInit()
    }
    
    func endOfInit(){
        self.intent.loadFestival(url: url)
    }
    
    var body: some View {
        TabView(selection: $tabSelected){
            FestivalPresentationView(displayFestival)
                .tabItem{
                    Label("Accueil", systemImage: "rectangle.and.text.magnifyingglass")
                    
                }.tag(0)
            AreaNavigationView(displayFestival: displayFestival)
                .tabItem{
                    Label("Zones", systemImage: "rectangle.dashed.badge.record")
                    
                }.tag(1)
            GameListView(gameList: GameListViewModel())
                .tabItem{
                    Label("Jeux", systemImage: "gamecontroller")
                }.tag(2)
            EditorListView(editorList: EditorListViewModel())
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
