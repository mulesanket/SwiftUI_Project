//
//  LoginModel.swift
//  IOSProject_MVVM
//
//  Created by Vishal Bhapkar on 25/08/23.
//

import Foundation

struct LoginResponse: Codable {
    let userList: [User]
}

struct User: Codable, Identifiable{
   enum CodingKeys: CodingKey {
       case email
       case password
    }

    var id = UUID()
    var email: String
    var password: String
}

