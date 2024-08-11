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

