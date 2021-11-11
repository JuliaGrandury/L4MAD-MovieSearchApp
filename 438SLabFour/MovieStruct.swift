//
//  MovieStruct.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/27/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

import Foundation

struct Movie : Decodable {
    var id: Int?
    var poster_path: String?
    var title: String?
    var vote_average: Float?
    var vote_count: Int?
    var genre_ids: [Int]?
    var release_date: String?
    var overview: String?
}

struct MovieOutcomes:Decodable {
//    let page: Int
//    let total_results: Int
//    let total_pages: Int
    let results: [Movie]
}
