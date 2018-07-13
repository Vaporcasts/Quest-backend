import Foundation 
import Vapor 
import FluentPostgreSQL

final class Post: PostgreSQLModel {
    var id:Int?
    var content:String 
    var voteCount:Int 
    var userId: User.ID

    init(id: Int,  content: String,  voteCount: Int,  userId: User.ID)  {
        self.id = id 
        self.content = content 
        self.voteCount = voteCount 
        self.userId = userId 
    }
}

extension Post: Migration, Content {}
