//
//  Users.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/11/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let login: String
    let displayname: String
    let email: String
    let phone: String?
    var imageUrl: String
    let location: String?
    let correctionPoints: Int
    let wallet: Int
    let cursusUser: [CursusUser]
    let projectsUser: [ProjectsUser]
    
    enum CodingKeys: CodingKey, String {
        case id
        case login
        case displayname
        case email
        case phone
        case imageUrl = "image_url"
        case location
        case correctionPoints = "correction_point"
        case wallet
        case cursusUser = "cursus_users"
        case projectsUser = "projects_users"
    }
}
