//
//  CommentController.swift
//  App
//
//  Created by Stephen Bodnar on 7/13/18.
//

import Foundation
import Vapor
import FluentPostgreSQL

extension CommentController: RouteCollection {
    func boot(router: Router) throws {
        router.post("/createComment", use: createComment)
    }
}

class CommentController {
    func createComment(_ request: Request) throws -> Future<HTTPStatus> {
        return try request.content.decode(CreateUserRequest.self).flatMap(to: HTTPStatus.self, { createUserRequest in
            let newUser = User(uniqueId: createUserRequest.uniqueId)
            return newUser.save(on: request).transform(to: HTTPStatus.created)
        })
    }
}
