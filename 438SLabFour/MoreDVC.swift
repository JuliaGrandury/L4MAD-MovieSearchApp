//
//  MoreDVC.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/31/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

import UIKit

class MoreDVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let moreInfoKey = "moreInfoKey"
    let defaults = UserDefaults.standard
    
    var movie_id: Int?
    var movie_title: String?
    var videoID: String?
    var recMovies: [Movie] = []
    var recMoviesImageCache: [UIImage] = []
    var castArray: [Cast] = []
    var castImageCache: [UIImage] = []
    
    @IBOutlet weak var castCollView: UICollectionView!
    @IBOutlet weak var similarCollView: UICollectionView!
    @IBOutlet weak var castCVLabel: UILabel!
    @IBOutlet weak var simCVLabel: UILabel!
    @IBOutlet weak var activityIndicatorTwo: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie_title
        similarCollView.dataSource = self
        similarCollView.delegate = self
        castCollView.dataSource = self
        castCollView.delegate = self
        activityIndicatorTwo.isHidden = false
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.getRecMovies()
            self.getRecMoviesImages()
            self.getCast()
            self.getCastImages()
            self.getVideoID()
            DispatchQueue.main.async {
                self.activityIndicatorTwo.isHidden = true
                self.castCollView.reloadData()
                self.similarCollView.reloadData()
                self.castCVLabel.text = "Cast From " + self.movie_title!
                self.simCVLabel.text = "Similar Movies to " + self.movie_title!
            }
        }
    }
    
    func getRecMovies(){
        guard let movieID = movie_id else { return }
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/recommendations?api_key=ec7d44afc5b2a5989fea04b50763c36f&language=en-US&page=1"
        let myData = try! Data(contentsOf: URL(string: url)!)
        let movieResults = try! JSONDecoder().decode(MovieOutcomes.self, from: myData)
        if movieResults.results.count >= 10 {
            recMovies = Array(movieResults.results[0 ..< 10])
        }
        else {
            recMovies = movieResults.results
        }
    }
    func getRecMoviesImages(){
        recMoviesImageCache.removeAll()
        for movie in recMovies {
            guard let poster_path = movie.poster_path else {
                print("no poster for this movie")
                let image = UIImage(named: "defaultposter")
                recMoviesImageCache.append(image!)
                continue
            }
            let url = URL(string: LinkShortcut.lowQImage + poster_path)
            let myData = try? Data(contentsOf: url!)
            let image = UIImage(data:myData!)
            recMoviesImageCache.append(image!)
        }
    }
   
    
    
    func getCast() {
        guard let movieID = movie_id else { return }
        let url = "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=ec7d44afc5b2a5989fea04b50763c36f"
        let data = try! Data(contentsOf: URL(string: url)!)
        let castResults = try! JSONDecoder().decode(CastResults.self, from: data)
        if castResults.cast.count >= 20 {
            castArray = Array(castResults.cast[0 ..< 20])
        }
        else {
            castArray = castResults.cast
        }
    }
    func getCastImages(){
        castImageCache.removeAll()
        for cast in castArray {
            guard let poster_path = cast.profile_path else {
                print("no image for this cast member")
                let image = UIImage(named: "defaultposter")
                castImageCache.append(image!)
                continue
            }
            let url = URL(string: LinkShortcut.lowQImage + poster_path)
            let myData = try? Data(contentsOf: url!)
            let image = UIImage(data:myData!)
            castImageCache.append(image!)
        }
    }
    
    func getVideoID(){
        guard let movieID = movie_id else { return }
        let url = "https://api.themoviedb.org/3/movie/420809/videos?api_key=ec7d44afc5b2a5989fea04b50763c36f&language=en-US".replacingOccurrences(of: "{movie_id}", with: String(movieID))
        let data = try! Data(contentsOf: URL(string: url)!)
        let trailerResults = try! JSONDecoder().decode(TrailerResults.self, from: data)
        if !trailerResults.results.isEmpty {
            videoID = trailerResults.results[0].key
        }
        print("VideoID is: " + videoID!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == castCollView){
            return castArray.count
        }
        else if collectionView == similarCollView {
            return recMovies.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == castCollView {
            castCollView.layer.borderColor = UIColor.black.cgColor
            castCollView.layer.borderWidth = 5
            let cell = castCollView.dequeueReusableCell(withReuseIdentifier: "castPoster", for: indexPath)
            let posterImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100.0, height: 150.0))
            posterImageView.image = castImageCache[indexPath.row]
            cell.backgroundView = posterImageView
            let nameView = UILabel(frame: CGRect(x: 0, y: 110.0, width: 100.0, height: 40.0))
            nameView.textColor = .white
            nameView.backgroundColor = .black
            nameView.textAlignment = .center
            nameView.alpha = 0.8
            nameView.numberOfLines = 3
            nameView.text = (castArray[indexPath.row].name ?? "Unknown") + " as " + (castArray[indexPath.row].character ?? "Unknown")
            nameView.font = .systemFont(ofSize: 10.0)
            cell.contentView.addSubview(nameView)
            return cell
        }
        else {
            similarCollView.layer.borderColor = UIColor.black.cgColor
            similarCollView.layer.borderWidth = 5
            let cell = similarCollView.dequeueReusableCell(withReuseIdentifier: "similarPoster", for: indexPath)
            let posterImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100.0, height: 150.0))
            posterImageView.image = recMoviesImageCache[indexPath.row]
            cell.backgroundView = posterImageView
            let titleView = UILabel(frame: CGRect(x: 0, y: 110.0, width: 100.0, height: 40.0))
            titleView.text = recMovies[indexPath.row].title
            titleView.textColor = .white
            titleView.backgroundColor = .black
            titleView.textAlignment = .center
            titleView.font = .systemFont(ofSize: 10.0)
            cell.contentView.addSubview(titleView)
            return cell
        }
    }
    
    
    

    
//    @IBAction func youtubeButton(_ sender: Any) {
//
//        let trailerViewController: TrailerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "trailerViewController") as! TrailerViewController
//        trailerViewController.videoID = videoID
//        navigationController?.pushViewController(trailerViewController, animated: true)
//    }
    
}
