//
//  MovieModel.swift
//  Movies
//
//  Created by Aleksandra on 14.11.2022.
//

import UIKit

struct Movie: Codable, Hashable {
    let image: String
    let rank: Int
    let title, rating, id: String
    let year: Int
    let thumbnail: String
}
