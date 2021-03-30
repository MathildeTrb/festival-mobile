//
//  DisplayFestivalViewModel.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation
import Combine
import SwiftUI

enum DisplayFestivalState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded(Festival)
    case loadingError(Error)
    case new(Festival)

    var description: String{
        switch self {
        case .ready : return "ready"
        case .loading(let s) : return "loading: \(s)"
        case .loaded(let festival) : return "loaded: \(festival.name)"
        case .loadingError(let error) : return "loadingError: Error loading -> \(error)"
        case .new(let festival) : return "I have my festival: \(festival)"
        }
    }
}

class FestivalViewModel: ObservableObject{
    
    private(set) var model : Festival
    
    var id : Int {
        return model.id
    }
    
    var name : String {
        return model.name
    }
    
    var imageUrl : String? {
        return model.imageUrl
    }
    
    var areas : [AreaViewModel]{
        var res = [AreaViewModel]()
        for area in model.areas {
            res.append(AreaViewModel(area))
        }
        return res
    }
        
    @Published var displayFestivalState : DisplayFestivalState = .ready{
        didSet{
            switch self.displayFestivalState {
            case let .loaded(data):
                print(data)
                model.new(festival: data)
                displayFestivalState = .new(model)
            case .loadingError:
                print("error")
                // faire un truc
            default:
                return
            }
        }
    }
    
    init(_ festival : Festival) {
        self.model = festival
    }
    
}
