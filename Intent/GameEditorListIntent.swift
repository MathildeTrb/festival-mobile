//
//  GameEditorListIntent.swift
//  festival-mobile
//
//  Created by user188238 on 4/1/21.
//

import Foundation
import SwiftUI

class GameEditorListIntent {
    
    @ObservedObject var gameEditorList: GameEditorListViewModel
    
    init(gameEditorList: GameEditorListViewModel) {
        self.gameEditorList = gameEditorList
    }
    
    func loadGames(url: String) {
        gameEditorList.gameEditorListState = .loading(url)
        HttpRequest.loadItemsFromAPI(url: url, endofrequest: httpJsonLoaded)
    }
    
    func httpJsonLoaded(result: Result<[Game], HttpRequestError>) {
        
        switch result {
        case let .success(data):
            gameEditorList.gameEditorListState = .loaded(data)
        case let .failure(error):
            gameEditorList.gameEditorListState = .loadingError(error)
        }
    }
}
