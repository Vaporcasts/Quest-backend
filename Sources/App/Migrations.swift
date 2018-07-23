//
//  Helpers.swift
//  App
//
//  Created by Stephen Bodnar on 7/14/18.
//

import Foundation
import Vapor
import FluentPostgreSQL

struct AddImageUrlToPosts: Migration {
    static func revert(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return Future.map(on: conn) { }
    }
    
    typealias Database = PostgreSQLDatabase
    
    static func prepare(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return Database.update(Post.self, on: conn, closure: { (updater) in
            updater.field(for: \Post.imageUrl, type: .text, .default(0))
        })
    }
    
}
