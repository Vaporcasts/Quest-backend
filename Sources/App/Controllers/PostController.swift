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
        router.get("getPosts", Int.parameter, use: getPagedPosts)
        router.post("createPost", use: createPost)
        router.get("getPost", Int.parameter, use: getPost)
        router.post("downvotePost", Int.parameter, use: downvotePost)
        router.post("upvotePost", Int.parameter, use: upvotePost)
        router.post("flagPost", Int.parameter, use: flagPost)
    }
}

class PostController {
    let limit = 6
    
    func getPost(_ request: Request) throws -> Future<PostWithComments> {
        let postId = try request.parameters.next(Int.self)
        return Post.find(postId, on: request).unwrap(or: Abort.init(HTTPResponseStatus.notFound)).flatMap(to: PostWithComments.self, { post  in
            return try Comment.query(on: request).filter(\Comment.postId == post.requireID()).all().map(to: PostWithComments.self) { comments in
                let postWithComments = PostWithComments(id: post.id, content: post.content, voteCount: post.voteCount, uniqueUserId: post.uniqueUserId, replies: comments)
                return postWithComments
            }
        })
    }
    
    func getPagedPosts(_ request: Request) throws -> Future<[FrontPagePosts]> {
        let pageNumber = try request.parameters.next(Int.self)
        let lower = pageNumber == 1 ? 0 : ((pageNumber - 1) * limit) + 1
        return Post.query(on: request).range(lower: lower, upper: lower + limit).sort(\Post.createdAt, PostgreSQLDirection._descending).all().flatMap(to: [FrontPagePosts].self) { (posts) in
            return try posts.convertToFrontPagePosts(with: request).flatten(on: request)
        }
    }
    
    func createPost(_ request: Request) throws -> Future<Post> {
        return try request.content.decode(CreatePostRequest.self).flatMap(to: Post.self, { createUserRequest in
            let newPost = Post(content: createUserRequest.content, voteCount: 0, uniqueUserId: createUserRequest.uniqueUserId, imageUrl: createUserRequest.imageUrl)
            return newPost.save(on: request)
        })
    }
    
    func upvotePost(_ request: Request) throws -> Future<HTTPStatus> {
        let postId = try request.parameters.next(Int.self)
        return Post.find(postId, on: request).unwrap(or: Abort.init(.notFound)).flatMap(to: HTTPStatus.self) { post in
            post.voteCount = post.voteCount + 1
            return post.save(on: request).transform(to: HTTPStatus.ok)
        }
    }
    
    func downvotePost(_ request: Request) throws -> Future<HTTPStatus> {
        let postId = try request.parameters.next(Int.self)
        return Post.find(postId, on: request).unwrap(or: Abort.init(.notFound)).flatMap(to: HTTPStatus.self) { post in
            post.voteCount = post.voteCount - 1
            return post.save(on: request).transform(to: HTTPStatus.ok)
        }
    }
    
    func flagPost(_ request: Request) throws -> Future<HTTPStatus> {
        let postId = try request.parameters.next(Int.self)
        return Post.find(postId, on: request).unwrap(or: Abort.init(.notFound)).flatMap(to: HTTPStatus.self) { post in
            post.isFlagged = true
            return post.save(on: request).transform(to: HTTPStatus.ok)
        }
    }
    
}
