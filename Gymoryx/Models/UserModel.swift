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

struct UserResponse: Codable {
    let status: String
    let email: String
    let name: String
    let token: String
    let newUser: Bool
    let userPic: String
    let userCover: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case email
        case name
        case token
        case newUser = "newuser"
        case userPic
        case userCover
    }
}


class UserPreferencesData: ObservableObject {
    var id : Int = 0
    @Published var goal: String = ""
    @Published var selectedGender: String = ""
    @Published var selectedDate: Date = Date()
    @Published var weight: CGFloat = 60
    @Published var height: CGFloat = 160
    @Published var bodyFat: String = ""
    @Published var bodyMuscleType: String = ""
}

