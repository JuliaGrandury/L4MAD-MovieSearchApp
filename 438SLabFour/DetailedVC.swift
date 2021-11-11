//
//  DetailedVC.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/28/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

import UIKit
import Foundation

class DetailedVC: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var addToFaveLabel: UILabel!
    
    var newMovie: Movie!
    var movie_id: Int!
    var poster_path: String?
    var posterImage: UIImage?
    var movie_title: String?
    var vote_average: Float?
    var vote_count: Int?
    var genre_ids: [Int]?
    var release_date: String?
    var overview: String?
    var videoID: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie_title
        getHigherQualityMoviePoster()
        poster.image = posterImage
        voteAverageLabel.text = "Average Score: " + String(vote_average ?? 0) + "/10"
        voteCountLabel.text = "Number of Votes: " + String(vote_count!)
        genreLabel.text = "Genres: " + getGenres()
        releaseDateLabel.text = "Release Date: " + String(release_date!)
        overviewLabel.text = "Overview: " + String(overview!)
        overviewLabel.sizeToFit()
    }
    
    func getHigherQualityMoviePoster() {
        guard let thisposterpath = poster_path else {
            print("no poster path")
            posterImage = UIImage(named: "defaultposter")
            return
        }
        let url = URL(string: LinkShortcut.highQImage + thisposterpath)
        let data = try? Data(contentsOf: url!)
        posterImage = UIImage(data:data!)
    }
    
    
    func getGenres() -> String {
        var genres: String = ""
        var numberOfGenres = 0
        for genre in genre_ids ?? [] {
            if numberOfGenres >= 3 {
                continue
            }
            switch genre {
            case 12:
                genres.append("Adventure, ")
            case 14:
                genres.append("Fantasy, ")
            case 16:
                genres.append("Animation, ")
            case 18:
                genres.append("Drama, ")
            case 27:
                genres.append("Horror, ")
            case 28:
                genres.append("Action, ")
            case 35:
                genres.append("Comedy, ")
            case 36:
                genres.append("History, ")
            case 53:
                genres.append("Thriller, ")
            case 80:
                genres.append("Crime, ")
            case 99:
                genres.append("Documentary, ")
            case 878:
                genres.append("Science Fiction, ")
            case 9648:
                genres.append("Mystery, ")
            case 10402:
                genres.append("Music, ")
            case 10749:
                genres.append("Romance, ")
            case 10751:
                genres.append("Family, ")
            default:
                continue
            }
            numberOfGenres += 1
        }
        if genres.count >= 2 {
            genres.removeLast()
            genres.removeLast()
        }
        return genres
    }
    
    
    //FUNCTION FOR WHEN YOU CLICK ADD TO FAVORITES BUTTON
    @IBAction func clickFave(_ sender: Any) {
        var favoritesNameArray = UserDefaults.standard.stringArray(forKey: "favoritesNameArray")!
        if (favoritesNameArray.contains(movie_title!)){
            print("movie has already been added")
        }
        else{
            favoritesNameArray.append(movie_title!)
            UserDefaults.standard.set(favoritesNameArray, forKey: "favoritesNameArray")
        }
    }
    
    @IBAction func clickMore(_ sender: Any) {
        let moreInfoMovieID = UserDefaults.standard.integer(forKey: "moreInfoKey")
        print(moreInfoMovieID)
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let MoreDVC = storyboard.instantiateViewController(withIdentifier: "MoreDVC") as? MoreDVC
        MoreDVC?.movie_id = movie_id
        MoreDVC?.movie_title = movie_title
        MoreDVC?.videoID = videoID
        navigationController?.pushViewController(MoreDVC!, animated: true)
        
    }
}
