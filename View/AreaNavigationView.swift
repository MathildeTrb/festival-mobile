//
//  DisplayFestivalView.swift
//  festival-mobile
//
//  Created by user188238 on 3/24/21.
//

import Foundation
import SwiftUI

//struct ActivityIndicator: UIViewRepresentable {
//    @Binding var animate: Bool
//
//    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView
//    {
//        return UIActivityIndicatorView(style: .large)
//    }
//
//    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>)
//    {
//        uiView.startAnimatig()
//    }
//
//}

struct AreaNavigationView: View {
    
    @ObservedObject var displayFestival: FestivalViewModel
    @State var textSearch = ""
    @State private var stateViewModel : String = ""
    
    private var searchState : DisplayFestivalState{
        return self.displayFestival.displayFestivalState
    }
    
    init(displayFestival: FestivalViewModel) {
        self.displayFestival = displayFestival
        let _ = self.displayFestival.$displayFestivalState.sink(receiveValue: stateChanged)
    }
    
    func stateChanged(state: DisplayFestivalState){
        switch state {
        case .loading:
            self.stateViewModel = "loading"
        case .new:
            self.stateViewModel = "données ok"
        default:
            return
        }
    }
    
    private func filterSearch(area : AreaViewModel) -> Bool {
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
                Text("Bienvenue : \(displayFestival.name)")
                Text("Voici les différentes zones du festival")
                Spacer().frame(height: 50)
                TextField("recherche d'une zone", text: $textSearch).font(.footnote).padding(10).background(Color.white)
                Spacer().frame(height:50)
                ZStack{
                    List{
                        ForEach(self.displayFestival.areas.filter(filterSearch)){area in
                            NavigationLink(
                                destination: AreaGamesList(area: area),
                                label: {
                                    Text("\(area.label)")
                                })
                        }
                    }
                    ErrorView(state: searchState)
                }
            }.navigationTitle("Information Zone")
        }.navigationViewStyle(StackNavigationViewStyle()).padding()
    }
}

struct ErrorView : View{
    let state : DisplayFestivalState
    var body: some View{
        VStack{
            Spacer()
            switch state{
            case .loading, .loaded:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(3)
            case .loadingError(let error):
                ErrorMessage(error: error)
            default:
                EmptyView()
            }
            if case .loaded = state{
                Text("festival found!")
            }
            Spacer()
        }
    }
}

struct ErrorMessage : View{
    let error :  Error
    var body: some View{
        VStack{
            Text("Error in search request")
            if let error = error  as? HttpRequestError {
                Text("\(error.description)")
            }
            else{
                Text("Unknown error")
            }
        }
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
