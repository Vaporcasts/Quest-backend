import Foundation 
import Vapor 
import FluentPostgreSQL

final class Comment: PostgreSQLModel {
    var id:Int?
    var postId: Post.ID
    var content:String 
    var avatarId:Avatar.ID
    var userId: String
    var voteCount: Int
    
    var createdAt: Date?
    var updatedAt: Date?
    
    static var createdAtKey: TimestampKey? = \.createdAt
    static var updatedAtKey: TimestampKey? = \.updatedAt

    init(postId: Post.ID, content: String,  avatarId: Avatar.ID, userId: String, voteCount: Int)  {
        self.postId = postId 
        self.content = content 
        self.avatarId = avatarId
        self.userId = userId
        self.voteCount = voteCount
    }
}

extension Comment: Migration, Content {}
