//
//  HTTPError.swift
//  DriveUAssignment
//
//  Created by Rajasekhar on 30/12/21.
//

import Foundation
enum HTTPError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
}
