//
//  DisplayGameDetails.swift
//  festival-mobile
//
//  Created by user188238 on 3/25/21.
//
import SwiftUI

struct GameDetails: View {
    
    var game : GameViewModel
    
    init(game: GameViewModel) {
        self.game = game
    }
    
    var body: some View {
        VStack {
            game.image?
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.title)
                
                Divider()
                
                HStack {
                    Text("Nombre de joueurs")
                    Spacer()
                    Text(game.minNumberPlayer == game.maxNumberPlayer ? "\(game.minNumberPlayer)" : "\(game.minNumberPlayer) - \(game.maxNumberPlayer)")
                }
                
                HStack {
                    Text("Âge minimum")
                    Spacer()
                    Text("\(game.minYearPlayer) ans")
                }
                
                HStack {
                    Text("Durée")
                    Spacer()
                    Text("\(game.duration) min")
                }
                
                HStack {
                    Text("Type")
                    Spacer()
                    Text(game.type.label)
                }
                
                Spacer().frame(height:50)
                
                if let manual = game.manual {
                    HStack {
                        Spacer()
                        Link(destination: URL(string: manual)!) {
                            VStack{
                                Image(systemName: "eyes")
                                Text("Manuel")
                            }
                        }.foregroundColor(.black)
                        Spacer()
                    }
                }
                
                
                
                
            }.padding()
        }
    }
}
