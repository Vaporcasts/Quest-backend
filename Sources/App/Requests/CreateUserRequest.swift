//
//  CreateUserRequest.swift
//  App
//
//  Created by Stephen Bodnar on 7/13/18.
//

import Vapor
import FluentPostgreSQL

struct CreateUserRequest: Content {
    var uniqueId: String
    
 
}
