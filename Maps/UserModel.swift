//
//  userModel.swift
//  MapsExample
//
//  Created by PT. ARION INDONESIA on 28/10/22.
//

import Foundation

// MARK: - Welcome
struct UserModel: Codable {
    let subject: String
    let multiLocation: [MultiLocation]

    enum CodingKeys: String, CodingKey {
        case subject
        case multiLocation = "multi-location"
    }
}

// MARK: - MultiLocation
struct MultiLocation: Codable {
    let id: Int
    let title, address, latitude, longitude: String
    let miniInfo: String
    let url: URLEnum

    enum CodingKeys: String, CodingKey {
        case id, title, address, latitude, longitude
        case miniInfo = "mini-info"
        case url
    }
}

enum URLEnum: String, Codable {
    case empty = "-"
}
