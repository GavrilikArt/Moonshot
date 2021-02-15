//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by apple on 2/13/21.
//

import Foundation

extension Bundle {
    func decode<ArrayOfAnyting: Codable>(_ file: String) ->  ArrayOfAnyting{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Fail")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("GG")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(ArrayOfAnyting.self, from: data) else {
            fatalError("Sry")
        }
        
        return loaded
    }
}
