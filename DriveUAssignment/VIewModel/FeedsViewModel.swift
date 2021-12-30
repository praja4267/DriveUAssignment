//
//  ViewModel.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 30/12/21.
//

import Foundation
class FeedsViewModel {
    var feedsLoaded: ((FeedsModel?, Bool) -> Void)?
    var feedsList: FeedsModel?
    init() {
        callService()
    }
    func callService() {
        APIManager.shared.getFeedsList { [weak self] response in
            self?.feedsList = response
            self?.handleResponse(response: response, success: true)
        } fail: { [weak self] _ in
            self?.handleResponse(response: nil, success: false)
        }
    }

    private func handleResponse(response: FeedsModel?, success: Bool) {
        if let feedsLoaded = self.feedsLoaded {
            feedsLoaded(response, success)
        }
    }

    func numberOrRows(section: Int) -> Int {
        if section == 2 {
            return feedsList?.OffersModel?.offers.count ?? 0
        }
        return 1
    }

    func getCarModel() -> CarDataModel? {
        return self.feedsList?.carModel?.car
    }
    
    func getSocialMediaDataModel() -> SocialMediaScreenDataModel? {
        return self.feedsList?.socialMediaModel
    }
    
    func getOffersModel(index: Int) -> OffersDataModel? {
        return self.feedsList?.OffersModel?.offers[index]
    }
    func getHeaderTitleForSection(section: Int) -> String {
        if section == 1 {
            return "Social Media"
        } else if section == 2 {
            return "Offers"
        }
        return ""
    }
}
