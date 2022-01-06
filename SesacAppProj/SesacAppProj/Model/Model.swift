//
//  UserModel.swift
//  SesacAppProj
//
//  Created by 이경후 on 2022/01/04.
//



import Foundation

/* USER */

// MARK: - User
struct User : Codable{
    let jwt: String
    let user: UserInfo
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let id: Int
    let username, email : String
    let confirmed: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, confirmed
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

/* Post */
// MARK: - Post
typealias Post = [PostElement]

struct PostElement: Codable {
    let id: Int
    let text: String
    let user: UserInfo
    let createdAt, updatedAt: String
    let comments: [Comment?]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

/* COMMENT */

// MARK: - Comment

struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
