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
        case let .loading(url):
            print("is loading url : \(url)")
        case .new:
            print("areas data arrived")
        default:
            return
        }
    }
    
    var body: some View {
        VStack {
            
            Text("\(game.name)")
            
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
