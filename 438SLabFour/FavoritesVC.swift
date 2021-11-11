////
////  FavoritesVC.swift
////  JuliaGrandury-Lab4-FINAL
////
////  Created by Julia Grandury on 10/29/19.
////  Copyright © 2019 Julia Grandury. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var favoritesNames: [String] = []
    let faveKey = "favoritesNameArray"
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var clearFavorites: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieTitle()
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMovieTitle()
        favoritesTableView.reloadData()
    }
    
    func getMovieTitle(){
        var newMovieTitle: [String]?
        newMovieTitle = UserDefaults.standard.stringArray(forKey: "favoritesNameArray")
        favoritesNames = newMovieTitle!
    }
    
    
    func favoriteMovie(movieID: Int, movieTitle: String) {
        UserDefaults.standard.set(movieTitle, forKey: String(movieID))
        var favoritesNames = UserDefaults.standard.object(forKey: faveKey) as? [Int] ?? [Int]()
        favoritesNames.append(movieID)
        UserDefaults.standard.set(favoritesNames, forKey: faveKey)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        cell.textLabel!.text = favoritesNames[indexPath.row]
        return cell
    }
    
    //FUNCTION FOR GOING FROM TABLE VIEW TO NOTES VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        if let NotesVC = storyboard.instantiateViewController(withIdentifier: "NotesVC") as? NotesVC{
            navigationController?.pushViewController(NotesVC, animated: true)
            NotesVC.movie_title = favoritesNames[indexPath.row]
            NotesVC.movie_index = indexPath.row
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            UserDefaults.standard.removeObject(forKey: favoritesNames[indexPath.row])
            favoritesNames.remove(at: indexPath.row)
            UserDefaults.standard.set(favoritesNames, forKey: faveKey)
            favoritesTableView.reloadData()
        }
    }

    
    @IBAction func clearAllFavorites(_ sender: Any) {
        favoritesNames.removeAll()
        UserDefaults.standard.set(favoritesNames, forKey: faveKey)
        favoritesTableView.reloadData()
    }
    
    
}


