//
//  JSONService.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/11/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation

class JSONService {
    static let shared = JSONService()
    
    func get<T: Decodable>(request: URLRequest, for type: T.Type, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            DispatchQueue.main.async { completion(result) }
            }.resume()
    }
}
