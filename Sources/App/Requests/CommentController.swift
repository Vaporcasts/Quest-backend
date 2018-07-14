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
        router.post("createComment", use: createComment)
    }
}

class CommentController {
    func createComment(_ request: Request) throws -> Future<Comment> {
        return try request.content.decode(CreateCommentRequest.self).flatMap(to: Comment.self, { commentRequest in
            return Comment.avatarId(forAuthor: commentRequest.authorId, forPost: commentRequest.postId, on: request).flatMap(to: Comment.self) { idForAvatar in
                let comment = Comment(postId:  commentRequest.postId, content: commentRequest.content, avatarId: idForAvatar, userId: commentRequest.authorId, voteCount: 0)
                return comment.save(on: request)
            }
        })
    }
    
}

