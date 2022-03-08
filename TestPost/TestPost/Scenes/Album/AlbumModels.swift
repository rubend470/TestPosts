//
//  AlbumModels.swift
//  TestPost
//
//  Created by Ruben Duarte on 8/3/22.
//

import Foundation

enum AlbumModels {
    enum GetAlbum {
        struct Request: Codable {
            let idPost : Int
        }

        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
                
            }
            
            let albumId         : Int?
            let id              : Int?
            let title           : String?
            let url             : String?
            let thumbnailUrl    : String?
            
            
            enum CodingKeys: String, CodingKey {
                case albumId
                case id
                case title
                case url
                case thumbnailUrl
            }
        }

        struct ViewModel {
            let albumData : [AlbumModels.GetAlbum.Response]
        }
    }

    enum Error {
        struct Request {
        }
        struct Response {
            var error: AlbumError
        }
        struct ViewModel {
            var error: AlbumError
        }
    }
}
