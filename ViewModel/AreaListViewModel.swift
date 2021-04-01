//
//  AreaListViewModel.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//
import Foundation

enum AreaListState: CustomStringConvertible {
    
    case ready
    case loading(String)
    case loaded([Area])
    case loadingError(Error)
    case new([AreaViewModel])
    
    var description: String {
        switch self {
        case .ready: return "ready"
        case .loading(let s): return "loading: \(s)"
        case .loaded(let areas): return "loaded: \(areas.count) areas"
        case .loadingError(let error): return "loadingError: Error loading -> \(error)"
        case .new(let areas): return "I have my areas: \(areas.count)"
        }
    }
}

class AreaListViewModel: ObservableObject {
    
    private(set) var areas = [AreaViewModel]()
    
    @Published var areaListState: AreaListState = .ready {
        didSet {
            switch areaListState {
            case let .loaded(data):
        
                for area in data {
                    areas.append(AreaViewModel(area))
                }
                
                self.areaListState = .new(self.areas)
            case .loadingError:
                print("error")
            default:
                return
            }
        }
    }
}
