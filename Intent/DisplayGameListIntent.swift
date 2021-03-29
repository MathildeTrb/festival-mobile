//
//  DisplayGameListIntent.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import Foundation
import SwiftUI

class DisplayGameListIntent {
    
    @ObservedObject var games: DisplayGameListViewModel
    
    init(games: DisplayGameListViewModel) {
        self.games = games
    }
    
    func loadGames(url: String) {
        print("je suis dans l'intent et je fais ma requête : \(url)")
        games.displayGameListState = .loading(url)
        HttpRequest.loadItemsFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
    func httpJsonLoaded(result: Result<[Game], HttpRequestError>) {
        
        switch result {
        case let .success(data):
            print("success \(data)")
            games.displayGameListState = .loaded(data)
        case let.failure(error):
            games.displayGameListState = .loadingError(error)
        }
    }
    
}
