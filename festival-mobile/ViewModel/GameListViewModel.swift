//
//  DisplayGameListViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import Foundation

enum GameListState: CustomStringConvertible {
    
    case ready
    case loading(String)
    case loaded([Game])
    case loadingError(Error)
    case new([GameViewModel])

    var description: String{
        switch self {
        case .ready : return "ready"
        case .loading(let s) : return "loading: \(s)"
        case .loaded(let games) : return "loaded: \(games.count) games"
        case .loadingError(let error) : return "loadingError: Error loading -> \(error)"
        case .new(let games) : return "I have my games: \(games.count)"
        }
    }
}

class GameListViewModel: ObservableObject {
        
    private(set) var games = [GameViewModel]()
    
    @Published var gameListState: GameListState = .ready {
        didSet {
            switch gameListState {
            case let .loaded(data):
                
                for game in data {
                    self.games.append(GameViewModel(game))
                }
                
                self.gameListState = .new(self.games)
            case .loadingError:
                print("error")
            default:
                return
            }
        }
    }
}
