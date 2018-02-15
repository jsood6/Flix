//
//  NowPlayingViewController.swift
//  flix
//
//  Created by jsood on 2/4/18.
//  Copyright © 2018 Jigyasaa Sood. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate{
    
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchController: UISearchController!
    var movies: [[String:Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        activityIndicator.startAnimating()
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        
        refreshControl = UIRefreshControl()
        //action is what method is called and start enums by .
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchMovies()
        activityIndicator.stopAnimating()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        fetchMovies()
    }
    
    func fetchMovies()
    {
        let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        //getting data
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        //task to get the data
        let task = session.dataTask(with: request) { (data, response, error) in
            //This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                //based on error, display corresponding message
                
                //create a alert view controller
                let alertController = UIAlertController(title: "Cannot load movies", message: "Please check your wifi connection", preferredStyle: .alert)
                
                //create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) {(action) in
                    //handle response here
                }
                
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
               
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                print(dataDictionary)
                let movies = dataDictionary["results"] as! [[String:Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
            }
        }
        //ALWAYS NEED TO CALL THIS FUNCTION! this will actually start the task
        task.resume()
    }
    
    //how many cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //count is the number of movies in our dictionary
        
            return movies.count
        
    }
    
    //what the cell is going to be
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImage.af_setImage(withURL: posterURL)
        
        tableView.deselectRow(at: indexPath, animated: true)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie 
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
