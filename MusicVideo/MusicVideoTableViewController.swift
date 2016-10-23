//
//  MusicVideoTableViewController.swift
//  MusicVideo
//
//  Created by mitesh soni on 15/10/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class MusicVideoTableViewController: UITableViewController, UISearchResultsUpdating {

    var videos = [Videos]();
    var filterSearch = [Videos]();
    var resultSearchController = UISearchController(searchResultsController: nil);
    
    var limit = 10;
    override func viewDidLoad() {
        super.viewDidLoad()

        runAPI();
    }

    func loadData(videos: [Videos]) -> Void {
        self.videos = videos;
        for video in videos{
            print("name = \(video.vName)");
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.cyan];
        title = "iTunes top \(limit) videos";
        
        //SETUP SEARCH CONTROLLER
        resultSearchController.searchResultsUpdater = self;
        definesPresentationContext = true;
        resultSearchController.dimsBackgroundDuringPresentation = false;
        resultSearchController.searchBar.placeholder = "Search for Artists";
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent;
        //ADD SEARCHBAR TO TABLEVIEW
        tableView.tableHeaderView = resultSearchController.searchBar;
        
        tableView.reloadData();
    }
    
    func getApiCount(){
        if UserDefaults.standard.object(forKey: "APICnt") != nil{
            let theValue = UserDefaults.standard.object(forKey: "APICnt") as! Int;
            self.limit = theValue;
        }
        let formatter = DateFormatter();
        formatter.dateFormat = "E, dd MM YYYY HH:MM:SS";
        let refreshDate = formatter.string(from: NSDate() as Date);
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)" );
    }
    func runAPI(){
        getApiCount();
        let api = APIManager();
        api.loadData(urlString: "https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: loadData)
    }
    @IBAction func refresh(_ sender: UIRefreshControl) {
        refreshControl?.endRefreshing();
        
        if (resultSearchController.isActive){
            refreshControl?.attributedTitle = NSAttributedString(string: "No refresh allowed in search");
        }else{
            runAPI();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (resultSearchController.isActive){
            return filterSearch.count;
        }
        return videos.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyBoard.cellReusableIdentifier, for: indexPath) as! MusicVideoTableViewCell
        if (resultSearchController.isActive){
            cell.video = filterSearch[indexPath.row];
        } else{
            cell.video = videos[indexPath.row];
        }
        return cell
    }

    private struct storyBoard{
        static let cellReusableIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132;
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyBoard.segueIdentifier{
            if let indexPath = tableView.indexPathForSelectedRow{
                let video : Videos;
                if (resultSearchController.isActive){
                    video = filterSearch[indexPath.row];
                } else{
                    video = videos[indexPath.row];
                }
                if let designation = segue.destination as? MusicVideoDetailVC{
                    designation.videos = video;
                }
                
            }
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.text?.lowercased();
        filterSearch(searchText: searchController.searchBar.text!);
    }
    func filterSearch(searchText: String){
      filterSearch = videos.filter({ (videos) -> Bool in
        return videos.vArtist.lowercased().contains(searchText.lowercased());
      })
        tableView.reloadData();
    }

}
