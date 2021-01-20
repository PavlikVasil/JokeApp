//
//  StoreItem.swift
//  JokeApp
//
//  Created by Павел on 19.01.2021.
//

import Foundation


struct StoreItems: Decodable{
    var type: String
    let value: [StoreItem?]

    enum CodingKeys: String, CodingKey{
        case type
        case value
    }
}


struct StoreItem: Decodable{
    
    var id: Int
    var joke: String
    var categories: [String?]
    
    enum CodingKeys: String, CodingKey{
        case id
        case joke
        case categories
    }
    
}
