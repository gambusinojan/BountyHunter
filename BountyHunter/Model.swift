//
//  Model.swift
//  BountyHunter
//
//  Created by Ángel González on 11/11/23.
//


import Foundation

// MARK: - Fugitive
struct Fugitive: Codable {
    let gender: Gender
    let bounty, fugitiveid: Int
    let name: String
    let age: Int
    let desc: String

    enum CodingKeys: String, CodingKey {
        case gender = "GENDER"
        case bounty = "BOUNTY"
        case fugitiveid = "FUGITIVEID"
        case name = "NAME"
        case age = "AGE"
        case desc = "DESC"
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}

typealias Fugitives = [Fugitive]
