//
//  Storage.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/29/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

//import Foundation
//
//class Storage{
//    let shared = Storage()
//    let faveKey = "FavoriteMovies"
//
//    func favoriteMovie(movieID: Int, movieTitle: String) {
//        UserDefaults.standard.set(movieTitle, forKey: String(movieID))
//        var favorites = UserDefaults.standard.object(forKey: faveKey) as? [Int] ?? [Int]()
//        favorites.append(movieID)
//        UserDefaults.standard.set(favorites, forKey: faveKey)
//    }
//
//    func deleteMovie(movieID: Int, index: Int){
//        UserDefaults.standard.removeObject(forKey: String(movieID))
//        var favorites = UserDefaults.standard.object(forKey: faveKey) as? [Int] ?? [Int]()
//        favorites.remove(at: index)
//        UserDefaults.standard.set(favorites, forKey: faveKey)
//    }

    // GET FUNCTIONS
//    func getNumberOfFavorites() -> Int{
//        let arrayOfIds: [Int] = UserDefaults.standard.value(forKey: faveKey) as? [Int] ?? [Int]()
//        return arrayOfIds.count
//    }
//    func getFavoritesIds() -> [Int] {
//        let arrayOfIds: [Int] = UserDefaults.standard.value(forKey: faveKey)as? [Int] ?? [Int]()
//        return arrayOfIds
//    }
//    func getFavoritesTitles() -> [String] {
//        var arrayOfTitles: [String] = []
//        let arrayOfIds: [Int] = UserDefaults.standard.value(forKey: faveKey) as? [Int] ?? [Int]()
//        for id in arrayOfIds{
//            guard let title = UserDefaults.standard.string(forKey: String(id)) else { continue }
//            arrayOfTitles.append(title)
//        }
//        return arrayOfTitles
//    }
//}
