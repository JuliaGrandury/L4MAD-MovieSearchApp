//
//  TrailerVC.swift
//  JuliaGrandury-Lab4-FINAL
//
//  Created by Julia Grandury on 10/31/19.
//  Copyright © 2019 Julia Grandury. All rights reserved.
//

import WebKit

class TrailerVC: UIViewController {
    
    var videoID: String!
    
    @IBOutlet weak var wkView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Watch Trailer"
        loadYoutube()
    }
    
    func loadYoutube() {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/" + videoID) else {
            return
        }
        wkView.load(URLRequest(url: youtubeURL))
    }
}
