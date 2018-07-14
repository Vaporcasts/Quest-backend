//
//  Helpers.swift
//  App
//
//  Created by Stephen Bodnar on 7/14/18.
//

import Foundation
import Vapor
import FluentPostgreSQL

/*struct AddUserIdToComments: Migration {
    typealias Database = PostgreSQLDatabase
    
    static func revert(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return Future.map(on: conn) { }
    }
    
    static func prepare(on conn: PostgreSQLConnection) -> EventLoopFuture<Void> {
        return Database.update(Comment.self, on: conn, closure: { (updater) in
            updater.field(for: \Comment.userId, type: PostgreSQLDataType.text, GenericSQLColumnConstraint.)
        })
    }
    
}*/
