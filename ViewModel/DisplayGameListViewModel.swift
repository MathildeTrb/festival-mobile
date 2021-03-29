//
//  DisplayGameListViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/29/21.
//

import Foundation

enum DisplayGameListState: CustomStringConvertible {
    
    case ready
    case loading(String)
    case loaded([Game])
    case loadingError(Error)
    case new([Game])

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

class DisplayGameListViewModel: ObservableObject {
    
    private(set) var model = [Game]()
    
    @Published var displayGameListState: DisplayGameListState = .ready {
        didSet {
            switch displayGameListState {
            case let .loaded(data):
                print(data)
                model.append(contentsOf: data)
                displayGameListState = .new(model)
            case .loadingError:
                print("error")
            default:
                return
            }
        }
    }
    
    init(_ games: [Game]) {
        self.model = games
    }
}
