//
//  AreaListIntent.swift
//  festival-mobile
//
//  Created by user188238 on 3/30/21.
//

import Foundation
import SwiftUI

class AreaListIntent {
    
    @ObservedObject var areaList: AreaListViewModel
    
    init(areaList: AreaListViewModel) {
        self.areaList = areaList
    }
    
    func loadAreas(url: String) {
        areaList.areaListState = .loading(url)
        HttpRequest.loadItemsFromAPI(url: url, endofrequest: httpJsonLoaded)
    }

    func areaLoaded(){
        areaList.areaListState = .ready
    }
    
    func httpJsonLoaded(result: Result<[Area], HttpRequestError>) {
        
        switch result {
        case let .success(data):
            areaList.areaListState = .loaded(data)
        case let .failure(error):
            areaList.areaListState = .loadingError(error)
        }
    }
}
