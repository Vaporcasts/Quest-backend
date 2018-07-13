import Foundation 
import Vapor 
import FluentPostgreSQL

final class Post: PostgreSQLModel {
    var id:Int?
    var content:String 
    var voteCount:Int 
    var userId: User.ID
    
    var createdAt: Date?
    var updatedAt: Date?
    
    static var createdAtKey: TimestampKey? = \.createdAt
    static var updatedAtKey: TimestampKey? = \.updatedAt

    init(id: Int,  content: String,  voteCount: Int,  userId: User.ID)  {
        self.id = id 
        self.content = content 
        self.voteCount = voteCount 
        self.userId = userId 
    }
}

extension Post: Migration, Content {}
