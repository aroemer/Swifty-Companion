//
//  Coalitions.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/14/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import Foundation

struct Coalition: Decodable {
    let name:String
    let slug:String
    let image_url:String
    let color:String
    
    
    enum CodingKeys: CodingKey, String {
        case name, slug, image_url, color
    }
}

