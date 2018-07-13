//
//  File.swift
//  App
//
//  Created by Stephen Bodnar on 7/13/18.
//

import Foundation
import Vapor
import FluentPostgreSQL

struct CreatePostRequest: Content {
    var content: String
    var userId: String
}
