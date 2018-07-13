import Foundation 
import Vapor 
import FluentPostgreSQL

final class Comment: PostgreSQLModel {
    var id:Int?
    var postId: Post.ID
    var content:String 
    var avatarId:Avatar.ID

    init(postId: Post.ID,  id: Int,  content: String,  avatarId: Avatar.ID)  {
        self.postId = postId 
        self.id = id 
        self.content = content 
        self.avatarId = avatarId 
    }
}

extension Comment: Migration, Content {}
