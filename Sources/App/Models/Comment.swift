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
    
    static func avatarId(forAuthor commentAuthor: String, forPost postId: Post.ID, on request: Request) -> Future<Int> {
        print("trying to retriev by postId: \(postId)")
        return Comment.query(on: request).filter(\Comment.postId == postId).all().map(to: Int.self) { comments in
            for comment in comments {
                if comment.userId == commentAuthor {
                    print("already commented")
                    print("returning \(comment.avatarId)")
                    return comment.avatarId
                }
            }
            let takenIds = comments.map { $0.avatarId }
            let allAvatarIds = [1, 2, 3]
            for id in allAvatarIds {
                if !takenIds.contains(id) {
                    print("returning \(id)")
                    return id
                }
            }
            return 555
        }
        //
    }
}

extension Comment: Migration, Content {}
