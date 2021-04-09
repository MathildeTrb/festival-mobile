//
//  FestivalPresentationView.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import SwiftUI

struct FestivalPresentationView: View {
    
    @ObservedObject var festival : FestivalViewModel

    init(_ festival : FestivalViewModel) {
        self.festival = festival
    }

    private var searchState : DisplayFestivalState{
        return self.festival.displayFestivalState
    }
    
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    festival.image?
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 7)
                            .offset(y: -130)
                            .padding(.bottom, -130)
                    Spacer().frame(height: 50)
                    Text("\(festival.description)").multilineTextAlignment(.center)
                }.padding()
                ErrorView(state: searchState)
            }
        }
    }
}