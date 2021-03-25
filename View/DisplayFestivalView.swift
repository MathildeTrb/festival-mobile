//
//  DisplayFestivalView.swift
//  festival-mobile
//
//  Created by user188238 on 3/24/21.
//

import SwiftUI

struct DisplayFestivalView: View {
    
    @ObservedObject var displayFestival: DisplayFestivalViewModel
    var intent : DisplayFestivalIntent
    private var url : String = "https://festivaljeu.herokuapp.com/api/festivals/current/games"
    
    init(displayFestival: DisplayFestivalViewModel) {
        print("Je suis la vue et je m'initialise")
        self.displayFestival = displayFestival
        self.intent = DisplayFestivalIntent(festival: displayFestival)
        let _ = self.displayFestival.$displayFestivalState.sink(receiveValue: stateChanged)
        endOfInit()
    }
    
    func endOfInit(){
        print("Je suis la vue et je démarre la récupération des données")
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
        return NavigationView{
            VStack{
                ZStack{
                    VStack{
                        Text("Bienvenue : \(displayFestival.model.name)")
                        Text("Voici les différentes zones du festival")
                        Spacer()
                        List{
                            ForEach(self.displayFestival.model.areas){area in
                                NavigationLink(
                                    destination: DisplayAreaDetails(area: area),
                                    label: {
                                        Text("\(area.label)")
                                    })
                            }
                        }
                    }
                    if self.displayFestival.model.areas.count == 0 {
                        VStack{
                            Spacer()
                            Text("pas de festival")
                            Spacer()
                        }
                    }
                }
            }
        }.navigationTitle("présentation festival")
    }
}

struct DisplayFestivalView_Previews: PreviewProvider {
    
    static var areas : [Area] = [
        Area(id: 10, label: "Zone adule", games: [
            Game(id: 2, name: "Cluedo", minNumberPlayer: 4, maxNumberPlayer: 7, minYearPlayer: 16, duration: 56, isPrototype: true, manualGame: "", imageUrl: "", type: GameType(id: 2, label: "réflexion"), editor: Editor(id: 1, name: "luc"))
        ]),
        Area(id: 11, label: "Zone enfant", games: [])
    ]
    
    static var previews: some View {
        DisplayFestivalView(
            displayFestival: DisplayFestivalViewModel(Festival(id: 2, name: "super Festival", imageUrl: " ", areas: areas) ))
    }
}
