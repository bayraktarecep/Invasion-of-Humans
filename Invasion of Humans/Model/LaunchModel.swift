//
//  LaunchModel.swift
//  Invasion of Humans
//
//  Created by Recep Bayraktar on 01.05.2021.
//

import Foundation

//MARK: - Launch
struct Launch: Codable {
    let flight_number: Int?
    let links: Links?
    let name: String?
    let details: String?
    let date_utc: String
    var success: Bool?
}

//MARK: - Links
struct Links: Codable {
    let patch: Patch?
    let webcast: String?
    let wikipedia: String?
}

//MARK: - Patch
struct Patch: Codable {
    let small: String?
    let large: String?
}
