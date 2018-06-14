//
//  ProjectsUser.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/16/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation

struct Project: Decodable {
    let name: String
    let slug: String
    let parent_id: Int?
}

struct ProjectsUser: Decodable {
    let final_mark: Int?
    let status: String
    let validated: Bool?
    let project: Project
    let cursus_ids : [Int]
    
    enum CodingKeys: CodingKey, String {
        case final_mark
        case status
        case validated = "validated?"
        case project
        case cursus_ids
    }
}
