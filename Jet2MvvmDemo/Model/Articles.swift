//
//  Articles.swift
//  Jet2MvvmDemo
//
//  Created by Ankush on 03/07/20.
//  Copyright © 2020 Ankush. All rights reserved.
//

import Foundation

import Foundation

struct Articles: Decodable {
    let id : String
    let createdAt : String
    let content: String
    let comments : Int
    let likes : Int
    let user : [User]
    let media : [Media]
}
struct User : Decodable {
    let id : String
    let blogId : String
    let createdAt : String
    let name : String
    let avatar : String
    let lastname : String
    let city : String
    let designation : String
    let about : String
    
}
struct Media : Decodable {
    let id : String
    let blogId : String
    let createdAt : String
    let image : String
    let title : String
    let url : String
    
}
