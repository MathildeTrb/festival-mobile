//
//  DisplayGameListIntent.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import Foundation
import SwiftUI

class GameListIntent {
    
    @ObservedObject var gameList: GameListViewModel
    
    init(gameList: GameListViewModel) {
        self.gameList = gameList
    }
    
    func loadGames(url: String) {
        print("je suis dans l'intent et je fais ma requête : \(url)")
        gameList.gameListState = .loading(url)
        HttpRequest.loadItemsFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
    func httpJsonLoaded(result: Result<[Game], HttpRequestError>) {
        
        switch result {
        case let .success(data):
            print("success \(data)")
            gameList.gameListState = .loaded(data)
        case let .failure(error):
            gameList.gameListState = .loadingError(error)
        }
    }
    
}
