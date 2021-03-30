//
//  festival_mobileApp.swift
//  festival-mobile
//
//  Created by user188238 on 3/24/21.
//

import SwiftUI

@main
struct festival_mobileApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainView(displayFestival: FestivalViewModel(
                        Festival(id: 0, name: "", imageUrl: "", areas: []))
            )
//            DisplayFestivalView(
//                displayFestival: DisplayFestivalViewModel(
//                    Festival(id: 0, name: "", imageUrl: "", areas: [])
//                )
//            )
        }
    }
}

