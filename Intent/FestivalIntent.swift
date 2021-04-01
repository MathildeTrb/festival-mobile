//
//  DisplayFestivalIntent.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import SwiftUI

class FestivalIntent {
    
    @ObservedObject var festival : FestivalViewModel

    
    init(festival: FestivalViewModel) {
        self.festival = festival
    }
    
    func loadFestival(url : String){
        festival.displayFestivalState = .loading(url)
        HttpRequest.loadItemsFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
    func httpJsonLoaded(result: Result<Festival, HttpRequestError>){
        switch result{
        case let .success(data):
            festival.displayFestivalState = .loaded(data)
        case let .failure(error):
            festival.displayFestivalState = .loadingError(error)
        }
    }
}

