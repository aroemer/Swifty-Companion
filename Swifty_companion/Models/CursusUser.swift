//
//  CursusUser.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/12/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation

struct Cursus: Decodable {
    let name:String
    let slug:String
    let id: Int
}

struct Skills: Decodable {
    let name: String
    let level: Float
}

struct CursusUser: Decodable {
    let level: Float
    let grade: String?
    let cursus: Cursus
    let skills: [Skills]
}



