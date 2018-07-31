import Foundation 
import Vapor 
import FluentPostgreSQL

final class Post: PostgreSQLModel {
    var id:Int?
    var content:String 
    var voteCount:Int 
    var uniqueUserId: String
    var isFlagged: Bool
    var imageUrl: String?
    
    var createdAt: Date?
    var updatedAt: Date?
    
    static var createdAtKey: TimestampKey? = \.createdAt
    static var updatedAtKey: TimestampKey? = \.updatedAt

    init(content: String,  voteCount: Int,  uniqueUserId: String, imageUrl: String?)  {
        self.content = content 
        self.voteCount = voteCount 
        self.uniqueUserId = uniqueUserId
        self.isFlagged = false
        self.imageUrl = imageUrl
    }
    
    var comments: Children<Post, Comment>  {
        return children(\.postId)
    }
}

extension Post: Migration, Content {}

struct FrontPagePosts: Content {
    var id:Int?
    var content:String
    var voteCount:Int
    var uniqueUserId: String
    var isFlagged: Bool
    var imageUrl: String?
    
    var createdAt: Date?
    var updatedAt: Date?
    
    var commentCount: Int
}

struct PostWithComments: Content {
    var id:Int?
    var content:String
    var voteCount:Int
    var uniqueUserId: String
    
    var replies: [Comment]
}

extension Array where Element: Post {
    func convertToFrontPagePosts(with request: Request) throws -> [Future<FrontPagePosts>] {
        return try self.map({ (post) -> Future<FrontPagePosts> in
            return try post.comments.query(on: request).count().map(to: FrontPagePosts.self) { finalCount in
                return FrontPagePosts(id: post.id, content: post.content, voteCount: post.voteCount, uniqueUserId: post.uniqueUserId, isFlagged: post.isFlagged, imageUrl: post.imageUrl, createdAt: post.createdAt, updatedAt: post.updatedAt, commentCount: finalCount)
            }
        })
    }
}
