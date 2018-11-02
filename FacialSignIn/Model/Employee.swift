//
//  Employee.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 2/11/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import Foundation

struct Employee: Codable {
    let name: String?
    let uuid: String?
    let mobile: String?
    let email: String?
    let facePhoto: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        uuid = try container.decode(String.self, forKey: .uuid)
        mobile = try container.decode(String.self, forKey: .mobile)
        email = try container.decode(String.self, forKey: .email)
        facePhoto = try container.decode(String.self, forKey: .facePhoto)
    }
    
}
