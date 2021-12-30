//
//  DataModel.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 28/12/21.
//

import Foundation

struct FeedsModel: Decodable {
    var status: String
    var greetingMessage: String
    var carModel: carScreenDataModel?
    var socialMediaModel:  SocialMediaScreenDataModel?
    var OffersModel:  OffersScreenDataModel?
    
    enum CodingKeys: String, CodingKey {
            case status
            case feeds
            case greetingMessage
        }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        greetingMessage = try container.decode(String.self, forKey: .greetingMessage)
        var feeds = try? container.nestedUnkeyedContainer(forKey: .feeds)
        if let carModel = try feeds?.decodeIfPresent(carScreenDataModel.self) {
            self.carModel = carModel
        }
        if let socialMediaModel = try feeds?.decodeIfPresent(SocialMediaScreenDataModel.self) {
            self.socialMediaModel = socialMediaModel
        }
        if let OffersModel = try feeds?.decodeIfPresent(OffersScreenDataModel.self) {
            self.OffersModel = OffersModel
        }
    }
}

struct carScreenDataModel: Codable {
    var car: CarDataModel
    var screen: String
}

struct CarDataModel: Codable {
    var image : String
    var regNo : String
    var fuelType : String
    var transmission : String
    var model : String
    var car_id : Int
    var make : String
}

struct SocialMediaScreenDataModel: Codable {
    var features: [SocialMediaDataModel]
    var screen: String
}

struct SocialMediaDataModel: Codable {
    var imageUrl : String
    var screenName : String
    var redirectUrl : String
}

struct OffersScreenDataModel: Codable {
    var offers: [OffersDataModel]
    var screen: String
}

struct OffersDataModel: Codable {
    var image : String
    var screen_name : String
    var name : String
}
