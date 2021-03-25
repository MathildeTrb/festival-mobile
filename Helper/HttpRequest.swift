//
//  HttpRequest.swift
//  festival_jeux
//
//  Created by etud on 23/03/2021.
//

import Foundation

enum HttpRequestError : Error, CustomStringConvertible{
    case fileNotFound(String)
    case badURL(String)
    case failingURL(URLError)
    case requestFailed
    case outputFailed
    case JsonDecodingFailed
    case JsonEncodingFailed
    case initDataFailed
    case unknown
    
    var description : String {
        switch self {
        case .badURL(let url): return "Bad URL : \(url)"
        case .failingURL(let error): return "URL error : \(error.failureURLString ?? "")\n \(error.localizedDescription)"
        case .requestFailed: return "Request Failed"
        case .outputFailed: return "Output data Failed"
        case .JsonDecodingFailed: return "JSON decoding failed"
        case .JsonEncodingFailed: return "JSON encoding failed"
        case .initDataFailed: return "Bad data format: initialization of data failed"
        case .unknown: return "unknown error"
        case .fileNotFound(let filename): return "File \(filename) not found"
        }
    }
}

struct GameData: Codable{
    
}

struct HttpRequest {

    static func loadFestivalFromAPI(url surl: String, endofrequest: @escaping (Result<Festival,HttpRequestError>) -> Void){
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        self.loadFestivalFromAPI(url: url, endofrequest: endofrequest)
    }
    
    static func loadFestivalFromAPI(url: URL, endofrequest: @escaping (Result<Festival,HttpRequestError>) -> Void){
        self.loadFestivalFromJsonData(url: url, endofrequest: endofrequest)
    }
    
    private static func loadFestivalFromJsonData(url: URL, endofrequest: @escaping (Result<Festival,HttpRequestError>) -> Void){
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                print("Je suis httpRequest et j'ai récupéré des données : ")
                print(data)
                
                let decodedData : Decodable?
                
                decodedData = try? JSONDecoder().decode(Festival.self, from: data)
                
                guard let decodedResponse = decodedData else {
                    print("Je suis httpRequest et je n'ai pas réussi à décoder mes données")
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                var festival : Festival
                festival = (decodedResponse as! Festival)
                
                print("Je suis httpRequest et j'ai récupéré un festival : ")
                print(festival)
                
                DispatchQueue.main.async {
                    endofrequest(.success(festival))
                }
            }
            else{
                DispatchQueue.main.async {
                    if let error = error {
                        guard let error = error as? URLError else {
                            endofrequest(.failure(.unknown))
                            return
                        }
                        endofrequest(.failure(.failingURL(error)))
                    }
                    else{
                        guard let response = response as? HTTPURLResponse else{
                            endofrequest(.failure(.unknown))
                            return
                        }
                        guard response.statusCode == 200 else {
                            endofrequest(.failure(.requestFailed))
                            return
                        }
                        endofrequest(.failure(.unknown))
                    }
                }
            }
        }.resume()
    }
    
}
