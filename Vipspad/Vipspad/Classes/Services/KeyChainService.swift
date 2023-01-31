//
//  KeyChainService.swift
//  Vipspad
//
//  Created by Azure on 25/1/23.
//

import Foundation
import KeychainSwift

class KeyChainService {
    
    static let shared = KeyChainService()
    
    let keychain = KeychainSwift()
    
    let TOKEN = "TOKEN"
}

extension KeyChainService {
    
    func saveToken(_ token: String) {
        self.keychain.set(token, forKey: self.TOKEN)
    }
    func retrieveToken() -> String? {
        return self.keychain.get(self.TOKEN)
    }
    func checkApiToken() -> Bool {
        guard self.keychain.get(self.TOKEN) != nil else {
            return false
        }
        return true
    }
    func delteApiToken() {
        self.keychain.delete(self.TOKEN)
    }
}
