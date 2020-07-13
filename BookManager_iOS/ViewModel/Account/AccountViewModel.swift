//
//  AccountViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/07.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class AccountViewModel {
    
    func logout(successAction: @escaping () -> Void, errorAction: @escaping (String) -> Void) {
        APIClient.sendRequest(type: .logout, entity: AccountResponse.self) { (result) in
            switch result {
            case .success:
                KeychainManager.remove()
                successAction()
                
            case .failure:
                errorAction(R.string.localizable.failToLogout())
            }
        }
    }
}
