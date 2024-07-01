//
//  DataModel.swift
//  Networking
//
//  Created by E5000861 on 12/06/24.
//

import Foundation


struct Address: Codable {
    var city : String
}
struct Company: Codable {
    var name : String
}
struct Post: Codable {
    let id : Int
    let name : String
    let username: String
    let website: String
    var address : Address
    var company : Company
    
}

