//
//  PosterDetailViewController.swift
//  flix
//
//  Created by jsood on 2/12/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import UIKit

class PosterDetailViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieRatings: UILabel!
    
    
    
    var movie: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let movie = movie{
            movieTitleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            if let vote_average = movie["vote_average"] as? Double
            {
                movieRatings.text = String(vote_average)
            }
            else{
            movieRatings.text = "No Rating"
            }
            print(movieRatings.text)
            print(movie)
            
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: baseURLString + backdropPathString)!
            backdropImageView.af_setImage(withURL: backdropURL)
            
            let posterPathURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
