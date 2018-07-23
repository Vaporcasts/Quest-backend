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
}

extension Post: Migration, Content {}

struct PostWithComments: Content {
    var id:Int?
    var content:String
    var voteCount:Int
    var uniqueUserId: String
    
    var replies: [Comment]
    
}
