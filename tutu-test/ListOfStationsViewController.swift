//
//  TableViewController.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 20.06.16.
//  Copyright © 2016 111. All rights reserved.
//

import UIKit

class ListOfStationsViewController: UITableViewController, UISearchResultsUpdating {
    var loadData = LoadDataOfStations()
    var searchController : UISearchController!
    var searchResult : [ClassStation] = []
    var stationsList: [ClassStation] = []
    var sortedList:[ClassStation] = []
    var sortedListTemp:[ClassStation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.backgroundColor = UIColor.blackColor()
        searchController.searchBar.placeholder = "Search station..."
        
        sortedListTemp = stationsList.sort { $0.cityTitle < $1.cityTitle }
        sortedList = stationsList.sort { $0.countryTitle < $1.countryTitle }
        
    
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResult.count
        } else {
            return sortedList.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellOfStations", forIndexPath: indexPath)
        
        let station = (searchController.active) ? searchResult[indexPath.row] : sortedList[indexPath.row]
        
        cell.textLabel?.text = station.cityTitle
        cell.detailTextLabel?.text = station.stationTitle

        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if segue.identifier == "segueDetailsOfStation" {
        if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destinationViewController as! DetailOfStationnViewController
            destinationController.station = (searchController.active) ? searchResult[indexPath.row] : sortedList[indexPath.row]
            searchController.searchBar.hidden=true
        }

        }
    }
    
    
    // ====
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(searchText)
            tableView.reloadData()
        }
    }

    func filterContent(searchText: String) {
        dispatch_sync(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
        self.searchResult = self.sortedList.filter({ (station:ClassStation)->Bool in
            let cityMatch = station.cityTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let stationMatch = station.stationTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return cityMatch != nil || stationMatch != nil
        })
        }
    
    }
    
//unwind segue
    @IBAction func close(segue:UIStoryboardSegue){
        searchController.searchBar.hidden=false

    }
    
    

}
