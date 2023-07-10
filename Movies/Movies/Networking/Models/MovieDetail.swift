//
//  MovieDetail.swift
//  Movies
//
//  Created by Aleksandra on 08.12.2022.
//

import Foundation

struct MovieDetail: Codable {
    let rank: Int
    let title: String
    let thumbnail: String
    let rating, id: String
    let year: Int
    let image: String
    let welcomeDescription: String
    let trailer: String
    let genre, director, writers: [String]
    let imdbid: String

    enum CodingKeys: String, CodingKey {
        case rank, title, thumbnail, rating, id, year, image
        case welcomeDescription = "description"
        case trailer, genre, director, writers, imdbid
    }
}
