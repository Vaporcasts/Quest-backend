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
        router.post("upvoteComment", Int.parameter, use: upvoteComment)
        router.post("downvoteComment", Int.parameter, use: downvoteComment)
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
    
    func downvoteComment(_ request: Request) throws -> Future<HTTPStatus> {
        let postId = try request.parameters.next(Int.self)
        return Comment.find(postId, on: request).unwrap(or: Abort.init(.notFound)).flatMap(to: HTTPStatus.self) { comment in
            comment.voteCount = comment.voteCount - 1
            return comment.save(on: request).transform(to: HTTPStatus.ok)
        }
    }
    
    func upvoteComment(_ request: Request) throws -> Future<HTTPStatus> {
        let postId = try request.parameters.next(Int.self)
        return Comment.find(postId, on: request).unwrap(or: Abort.init(.notFound)).flatMap(to: HTTPStatus.self) { comment in
            comment.voteCount = comment.voteCount + 1
            return comment.save(on: request).transform(to: HTTPStatus.ok)
        }
    }
    
}

