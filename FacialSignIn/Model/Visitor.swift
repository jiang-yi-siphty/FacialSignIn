//
//  Visitor.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 2/11/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import Foundation

struct Visitor: Codable {
    let name: String?
    let uuid: String?
    let company: String?
    let mobile: String?
    let email: String?
    let visiting: String?
    let facePhoto: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        uuid = try container.decode(String.self, forKey: .uuid)
        company = try container.decode(String.self, forKey: .company)
        mobile = try container.decode(String.self, forKey: .mobile)
        email = try container.decode(String.self, forKey: .email)
        visiting = try container.decode(String.self, forKey: .visiting)
        facePhoto = try container.decode(String.self, forKey: .facePhoto)
    }
    
}
