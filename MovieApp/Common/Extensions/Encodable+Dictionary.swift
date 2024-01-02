//
//  Encodable+Dictionary.swift
//  MovieApp
//
//  Created by FEKRANE on 26/12/2023.
//

import Foundation


extension Encodable {
    func asDictionary(_ encoder: JSONEncoder = JSONEncoder()) -> [String: String]? {
        guard
            let data = try? encoder.encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else {
            return nil
        }
        return dictionary.compactMapValues { String(describing: $0) }
    }
}

