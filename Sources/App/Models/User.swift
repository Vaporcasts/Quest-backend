import Foundation 
import Vapor 
import FluentPostgreSQL

final class User: PostgreSQLModel {
    var id:Int?
    var uniqueId:String
    var createdAt: Date?
    var updatedAt: Date?
    
    static var createdAtKey: TimestampKey? = \.createdAt
    static var updatedAtKey: TimestampKey? = \.updatedAt

    init(uniqueId: String)  {
        self.uniqueId = uniqueId 
    }
}

extension User: Migration, Content {}
