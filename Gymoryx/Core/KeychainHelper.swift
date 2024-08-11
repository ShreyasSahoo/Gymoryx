//
//  KeychainHelper.swift
//  Gymoryx
//
//  Created by Shreyas Sahoo on 08/08/24.
//
import Foundation
import Security

class KeychainHelper {
    
    class func saveToken(token: String) -> Bool {
        let data = token.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userToken",
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary) // Delete any existing item
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    class func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userToken",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
}

