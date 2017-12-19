//
//  CompositionInfo.swift
//  Flow
//
//  Created by Kevin Chan on 05/12/2017.
//  Copyright © 2017 MusicG. All rights reserved.
//

import Foundation

struct CompositionInfo: Codable {
    var name: String
    var lastEdited: Date
    var id: String
    
    init(name: String = "Untitled", lastEdited: Date = Date(), id: String = UUID().uuidString) {
        self.name = name
        self.lastEdited = lastEdited
        self.id = id
    }
}
