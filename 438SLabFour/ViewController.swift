//
//  ViewController.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/24/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var movieCollView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    //array of movies
    var movies: [Movie] = []
    var theImageCache : [UIImage] = []
    var query: String = ""
    var myIndex: Int?
    var movieResults:MovieOutcomes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MOVIES"
        self.activityIndicator.startAnimating()
        movieCollView.dataSource = self
        movieCollView.delegate = self
        mySearchBar.delegate = self
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.getHomeMovies()
            self.cacheImages()
            DispatchQueue.main.async {
                self.showMovies()
                self.getHomeMovies()
                self.movieCollView.reloadData()
            }
        }
    }
    
    func showMovies(){
        movieCollView.isHidden = false
        activityIndicator.isHidden = true
    }
    
    func loadingMovies(){
        movieCollView.isHidden = true
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    func getHomeMovies(){
        do{
            let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=ec7d44afc5b2a5989fea04b50763c36f&language=en-US&page=1")
            let myData = try Data(contentsOf: url!)
            let movieResults = try JSONDecoder().decode(MovieOutcomes.self, from: myData)
            for m in movieResults.results{
                movies.append(m)
            }
            self.cacheImages()
            print("number of movies: " + String(movies.count))
        }
        catch {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
                
            }
        }
    }
    
    func searchMovies(searchElement: String){
        do{
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=ec7d44afc5b2a5989fea04b50763c36f&language=en-US&query=\(searchElement)&page=1&include_adult=false")
            let myData = try Data(contentsOf: url!)
            let movieResults = try JSONDecoder().decode(MovieOutcomes.self, from: myData)
            movies = movieResults.results
        }
        catch{
            theImageCache.removeAll()
            movies.removeAll()
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                self.movieCollView.reloadData()
            }
        }
    }
    
    func cacheImages(){
        theImageCache.removeAll()
        for movie in movies{
            guard let poster_path = movie.poster_path else{
                let image = UIImage(named: "defaultposter")
                theImageCache.append(image!)
                continue
            }
            let url = URL (string: LinkShortcut.lowQImage + poster_path)
            let myData = try? Data(contentsOf: url!)
            let image = UIImage(data:myData!)
            theImageCache.append(image!)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.title = "MOVIE RESULTS"
        self.movies.removeAll()
        self.movieCollView.reloadData()
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        
        guard var query = mySearchBar.text else{
            return
        }
        query = query.trimmingCharacters(in: .whitespaces)
        let searchElement = query.replacingOccurrences(of: " ", with: "%20")
        
        if searchElement.count == 0{
            DispatchQueue.global(qos: .userInitiated).async {
                self.getHomeMovies()
                self.cacheImages()
                DispatchQueue.main.async {
                    self.movieCollView.reloadData()
                }
            }
        }
        else{
            DispatchQueue.global(qos: .userInitiated).async {
                self.searchMovies(searchElement: searchElement)
                self.cacheImages()
                DispatchQueue.main.async {
                    self.showMovies()
                    self.activityIndicator.isHidden = true
                    self.movieCollView.reloadData()
                }
            }
        }
        mySearchBar.resignFirstResponder()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        let posterView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120.0, height: 160.0))
        posterView.image = theImageCache[indexPath.row]
        cell.backgroundView = posterView
        let titleView = UILabel(frame: CGRect(x: 0, y: 115.0, width: 100.0, height: 35.0))
        titleView.text = movies[indexPath.row].title
        titleView.numberOfLines = 0
        titleView.backgroundColor = .black
        titleView.alpha = 0.9
        titleView.textAlignment = .center
        titleView.textColor = .white
        titleView.font = .boldSystemFont(ofSize: 10.0)
        cell.contentView.addSubview(titleView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        DetailedVC.poster_path = movies[indexPath.row].poster_path
        DetailedVC.movie_id = movies[indexPath.row].id
        DetailedVC.movie_title = movies[indexPath.row].title
        DetailedVC.vote_average = movies[indexPath.row].vote_average
        DetailedVC.vote_count = movies[indexPath.row].vote_count
        DetailedVC.genre_ids = movies[indexPath.row].genre_ids
        DetailedVC.release_date = movies[indexPath.row].release_date
        DetailedVC.overview = movies[indexPath.row].overview
        navigationController?.pushViewController(DetailedVC, animated: true)
    }
}




