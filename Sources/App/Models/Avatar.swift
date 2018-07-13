//
//  Avatar.swift
//  App
//
//  Created by Stephen Bodnar on 7/13/18.
//

import Vapor
import FluentPostgreSQL

final class Avatar: PostgreSQLModel {
    var id: Int?
    var url: String
    
    init(url: String) {
        self.url = url
    }
}

extension Avatar: Migration, Content { }
