//
//  LinkShortcut.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/25/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

import Foundation

enum LinkShortcut {
    
    //lifetime of these constants is the entire run of the program
    static let queryURL = "https://api.themoviedb.org/3/search/movie?api_key=ec7d44afc5b2a5989fea04b50763c36f&language=en-US&query=sun&page=1&include_adult=false"
    
    //image links for movie posters
    static let lowQImage = "https://image.tmdb.org/t/p/w500"
    static let highQImage = "https://image.tmdb.org/t/p/original"
    
    //links for creative features
    static let topRatedURL = "https://api.themoviedb.org/3/movie/top_rated?api_key=ec7d44afc5b2a5989fea04b50763c36f&language=en-US&page=1"
    static let recommendationsURL = "https://api.themoviedb.org/3/movie/420809/recommendations?api_key=ec7d44afc5b2a5989fea04b50763c36f&language=en-US&page=1"
    static let castInfoURL = "https://api.themoviedb.org/3/movie/420809/credits?api_key=ec7d44afc5b2a5989fea04b50763c36f"
}
