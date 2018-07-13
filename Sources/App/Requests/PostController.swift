//
//  PostController.swift
//  App
//
//  Created by Stephen Bodnar on 7/13/18.
//

import Foundation
import Vapor
import FluentPostgreSQL

extension PostController: RouteCollection {
    func boot(router: Router) throws {
        router.post("/createPost", use: createPost)
    }
}

class PostController {
    func createPost(_ request: Request) throws -> Future<HTTPStatus> {
        return try request.content.decode(CreatePostRequest.self).flatMap(to: HTTPStatus.self, { createUserRequest in
            let newPost = Post(content: createUserRequest.content, voteCount: 0, uniqueUserId: createUserRequest.uniqueUserId)
            return newPost.save(on: request).transform(to: HTTPStatus.created)
        })
    }
}
