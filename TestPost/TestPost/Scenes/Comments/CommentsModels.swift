//
//  CommentsModels.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation

enum CommentsModels {
    enum GetComments {
        struct Request: Codable {
            let idPost : Int
        }

        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
                
            }
            
            let postsId      : Int?
            let id          : Int?
            let name        : String?
            let email       : String?
            let body        : String?
            
            
            enum CodingKeys: String, CodingKey {
                case postsId
                case id
                case name
                case email
                case body
            }
        }

        struct ViewModel {
            let commentsData : [CommentsModels.GetComments.Response]
        }
    }

    enum Error {
        struct Request {
        }
        struct Response {
            var error: CommentsError
        }
        struct ViewModel {
            var error: CommentsError
        }
    }
}
