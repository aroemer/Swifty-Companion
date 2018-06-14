//
//  Token.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/12/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation

struct Token: Decodable {
    let token: String
    
    enum CodingKeys: CodingKey, String {
        case token = "access_token"
    }
}
