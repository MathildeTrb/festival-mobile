//
//  AreaListView.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//

import SwiftUI

struct AreaListView: View {
    
    @ObservedObject var areaList: AreaListViewModel
    
    var intent: AreaListIntent
    
    private(set) var game: GameViewModel
    
    private var url: String
    
    init(game: GameViewModel, areaList: AreaListViewModel) {
        self.game = game
        self.areaList = areaList
        self.url = "https://festival-jeu.herokuapp.com/api/areas/current/\(game.id)"
        self.intent = AreaListIntent(areaList: areaList)
        let _ = self.areaList.$areaListState.sink(receiveValue: stateChanged)
        endOfInit()
    }
    
    func endOfInit() {
        self.intent.loadAreas(url: url)
    }
    
    func stateChanged(state: AreaListState) {
        switch state {
        case .new:
            intent.areaLoaded()
        default:
            return
        }
    }
    
    var body: some View {
        VStack {
            
            game.image
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
                //.offset(y: -130)
                //.padding(.bottom, -130)
            
            Text("\(game.name)")
            
            Spacer()
            
            Text("Liste des zones")
                .font(.title)
            
            List {
                ForEach(self.areaList.areas) { area in
                    Text("\(area.label)")
                }
            }
        }
    }
}

//struct AreaListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AreaListView()
//    }
//}
