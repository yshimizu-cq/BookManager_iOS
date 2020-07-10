//
//  AccountViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/07.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation
import KeychainAccess

final class AccountViewModel {
    
    var keychain: Keychain {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String else { return Keychain(service: "") }
        return Keychain(service: identifier)
    }
    
    func account(successAction: @escaping () -> Void, errorAction: @escaping (Error) -> Void) {
        APIClient.sendRequest(type: .account, entity: AccountResponse.self) { (result) in
            switch result {
            case .success:
                try? self.keychain.remove("token")
                successAction()
                
            case .failure(let error):
                errorAction(error)
            }
        }
    }
}
