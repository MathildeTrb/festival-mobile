//
//  DisplayAreaDetails.swift
//  festival-mobile
//
//  Created by user188238 on 3/24/21.
//

import SwiftUI

struct DisplayAreaDetails: View {
    
    var area : Area
    
    init(area: Area) {
        self.area = area
    }
    
    var body: some View {
        VStack {
            Text("Vous recherchez les jeux de la zone \(area.label)")
            List{
                ForEach(self.area.games){game in
                    NavigationLink(
                            destination: DisplayGameDetails(game: game),
                            label: {
                                Text("\(game.name)")
                    })
                }
            }
            			
        }
    }
}

struct DisplayAreaDetails_Previews: PreviewProvider {
    static var previews: some View {
        DisplayAreaDetails(area: Area(id: 2, label: "je suis un super espace", games: []))
    }
}
