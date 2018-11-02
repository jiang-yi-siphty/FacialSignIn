//
//  NewVisitor.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 2/11/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import Foundation

struct NewVisitor: Codable {

    let visitor: Visitor?
    let uuid: String?
    let facePhotos: [String]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        visitor = try container.decode(Visitor.self, forKey: .visitor)
        uuid = try container.decode(String.self, forKey: .uuid)
        facePhotos = try container.decode([String].self, forKey: .facePhotos)
    }
}
