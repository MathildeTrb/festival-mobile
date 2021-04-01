//
//  DisplayAreaDetails.swift
//  festival-mobile
//
//  Created by user188238 on 3/24/21.
//

import SwiftUI

struct AreaGamesList: View {
    
    var area : AreaViewModel
    
    init(area: AreaViewModel) {
        self.area = area
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            Text("Vous recherchez les jeux de la zone \(area.label)").padding()
            Spacer().frame(height: 50)
            List{
                ForEach(self.area.games){game in
                    NavigationLink(
                            destination: GameDetails(game: game),
                            label: {
                                Text("\(game.name)")
                    })
                }
            }
            			
        }.navigationTitle("\(area.label)")
    }
}

//struct DisplayAreaDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayAreaDetails(area: Area(id: 2, label: "je suis un super espace", games: []))
//    }
//}
