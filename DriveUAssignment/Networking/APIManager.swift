//
//  APIManager.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 30/12/21.
//

import Foundation
class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func getFeedsList(success: @escaping ((FeedsModel) -> Void), fail: @escaping ((HTTPError) -> Void)) {
        ServiceManager.shared.callService(urlString: Constants.baseURL+URLEndPoint.homeScreenList, method: .get) { (response: FeedsModel) in
            success(response)
        } fail: { error in
            fail(error)
        }
    }
    
}
