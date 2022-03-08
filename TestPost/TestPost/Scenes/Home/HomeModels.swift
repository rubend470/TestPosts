//
//  HomeModels.swift
//  TestPost
//
//  Created by Ruben Duarte on 7/3/22.
//

import Foundation

enum HomeModels {
    enum GetHome {
        struct Request: Codable {
        }

        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
                
            }
            
            let id          : Int?
            let body        : String?
            let title       : String?
            let userId      : Int?
            
            enum CodingKeys: String, CodingKey {
                case id
                case body
                case title
                case userId
            }
        }

        struct ViewModel {
            let HomeData : [HomeModels.GetHome.Response]
        }
    }

    enum Error {
        struct Request {
        }
        struct Response {
            var error: HomeError
        }
        struct ViewModel {
            var error: HomeError
        }
    }
}
