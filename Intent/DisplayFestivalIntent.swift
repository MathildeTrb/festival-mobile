//
//  DisplayFestivalIntent.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import SwiftUI

class DisplayFestivalIntent {
    
    @ObservedObject var festival : DisplayFestivalViewModel
    
    init(festival: DisplayFestivalViewModel) {
        self.festival = festival
    }
    
    func loadFestival(url : String){
        print("Je suis l'intente et je fais ma requête : \(url)")
        festival.displayFestivalState = .loading(url)
        HttpRequest.loadFestivalFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
    func httpJsonLoaded(result: Result<Festival, HttpRequestError>){
        switch result{
        case let .success(data):
            print("success : \(data)")
            festival.displayFestivalState = .loaded(data)
        case let .failure(error):
            festival.displayFestivalState = .loadingError(error)
        }
    }
}

