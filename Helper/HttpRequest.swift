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

    static func loadItemsFromAPI<T>(url surl: String, endofrequest: @escaping (Result<T,HttpRequestError>) -> Void) where T : Decodable {
        guard let url = URL(string: surl) else {
            endofrequest(.failure(.badURL(surl)))
            return
        }
        do {
            sleep(1)
        }
        self.loadItemsFromAPI(url: url, endofrequest: endofrequest)
    }
    
    static func loadItemsFromAPI<T>(url: URL, endofrequest: @escaping (Result<T,HttpRequestError>) -> Void) where T : Decodable {
        self.loadItemsFromJsonData(url: url, endofrequest: endofrequest)
    }
    
    private static func loadItemsFromJsonData<T>(url: URL, endofrequest: @escaping (Result<T,HttpRequestError>) -> Void) where T : Decodable {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                let decodedData : Decodable?
                
                decodedData = try? JSONDecoder().decode(T.self, from: data)
                
                guard let decodedResponse = decodedData else {
                    DispatchQueue.main.async { endofrequest(.failure(.JsonDecodingFailed)) }
                    return
                }
                var resultat : T
                resultat = (decodedResponse as! T)
                
                DispatchQueue.main.async {
                    endofrequest(.success(resultat))
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
    
    static func httpGetObject<T>(from surl: String, initFromData: @escaping (Data) -> T?, endofrequest: @escaping (Result<T,HttpRequestError>) -> Void){
            guard let url = URL(string: surl) else {
                endofrequest(.failure(.badURL(surl)))
                return
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        guard let result = initFromData(data) else {
                            endofrequest(.failure(.initDataFailed))
                            return
                        }
                        endofrequest(.success(result))
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
