//
//  UserModel.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//

import Foundation

struct User: Codable, Identifiable {
    var id : Int
    var name: String
    var email: String
    var token: String
    var userPic: String
}
