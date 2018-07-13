//
//  CreateCommentRequest.swift
//  App
//
//  Created by Stephen Bodnar on 7/13/18.
//

import Vapor
import FluentPostgreSQL

struct CreateCommentRequest: Content {
    var postId: Post.ID
    var content: String
    var avatarId: Avatar.ID
}
