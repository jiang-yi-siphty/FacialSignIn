//
//  PotentialVisitor.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 2/11/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import Foundation

struct PotentialVisitors: Codable {
    let potentialVisitors: [Visitor]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        potentialVisitors = try container.decode([Visitor].self, forKey: .potentialVisitors)
    }
    
}
