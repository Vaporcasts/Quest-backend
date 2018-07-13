import Foundation 
import Vapor 
import FluentPostgreSQL

final class User: PostgreSQLModel {
    var id:Int?
    var uniqueId:String 

    init(uniqueId: String)  {
        self.uniqueId = uniqueId 
    }
}

extension User: Migration, Content {}
