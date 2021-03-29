//
//  DisplayFestivalView.swift
//  festival-mobile
//
//  Created by user188238 on 3/24/21.
//

import SwiftUI

struct DisplayFestivalView: View {
    
    @ObservedObject var displayFestival: DisplayFestivalViewModel
    @State var textSearch = ""
    
    init(displayFestival: DisplayFestivalViewModel) {
        self.displayFestival = displayFestival
        UITableView.appearance().backgroundColor = .clear
    }
    
    private func filterSearch(area : Area) -> Bool {
        var ret = true
        if !textSearch.isEmpty {
            ret = area.label.contains(textSearch)
        }
        return ret
    }
    
    var body: some View {
        return NavigationView{
            VStack{
                Spacer().frame(height: 50)
                Text("Bienvenue : \(displayFestival.model.name)")
                Text("Voici les différentes zones du festival")
                Spacer().frame(height: 50)
                TextField("recherche d'une zone", text: $textSearch).font(.footnote).padding(10).background(Color.white)
                Spacer().frame(height:50)
                ZStack{
                    List{
                        ForEach(self.displayFestival.model.areas.filter(filterSearch)){area in
                            NavigationLink(
                                destination: DisplayAreaDetails(area: area),
                                label: {
                                    Text("\(area.label)")
                                })
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
            }.navigationTitle("Information Zone").background(Color.pink.opacity(0.1))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct DisplayFestivalView_Previews: PreviewProvider {
//
//    static var areas : [Area] = [
//        Area(id: 10, label: "Zone adule", games: [
//            Game(id: 2, name: "Cluedo", minNumberPlayer: 4, maxNumberPlayer: 7, minYearPlayer: 16, duration: 56, isPrototype: true, manualGame: "", imageUrl: "", type: GameType(id: 2, label: "réflexion"), editor: Editor(id: 1, name: "luc"))
//        ]),
//        Area(id: 11, label: "Zone enfant", games: [])
//    ]
//
//    static var previews: some View {
//        DisplayFestivalView(
//            displayFestival: DisplayFestivalViewModel(Festival(id: 2, name: "super Festival", imageUrl: " ", areas: areas) ))
//    }
//}
