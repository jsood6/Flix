//
//  Movie.swift
//  flix
//
//  Created by Melissa Phuong Nguyen on 2/28/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL?
    var overview: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"

        let posterPathString = dictionary["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"

        posterUrl = URL(string: baseURLString + posterPathString)!

    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
    
}


//        let title = movie["title"] as! String
//        let overview = movie["overview"] as! String
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//
//        let posterPathString = movie["poster_path"] as! String
//        let baseURLString = "https://image.tmdb.org/t/p/w500"
//
//        let posterURL = URL(string: baseURLString + posterPathString)!
//        cell.posterImage.af_setImage(withURL: posterURL)
