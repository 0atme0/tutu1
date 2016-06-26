//
//  TableViewController.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 20.06.16.
//  Copyright © 2016 111. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    var city = Load()
    var from : Bool = false
    var Search : UISearchController!
    var searchResult : [Stat] = []
    var stat_list: [Stat] = []
    var sorted_list:[Stat] = []
    var sorted_list_temp:[Stat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Search = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = Search.searchBar
        Search.searchResultsUpdater = self
        Search.dimsBackgroundDuringPresentation = false
        
        stat_list = city.LoadToClass(from)
        sorted_list_temp = stat_list.sort { $0.cityTitle < $1.cityTitle }
        sorted_list = stat_list.sort { $0.countryTitle < $1.countryTitle }
        
    
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
        if Search.active {
            return searchResult.count
        } else {
            return sorted_list.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
        
        let station = (Search.active) ? searchResult[indexPath.row] : sorted_list[indexPath.row]
        
        cell.textLabel?.text = station.cityTitle
        cell.detailTextLabel?.text = station.stationTitle

        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if Search.active {
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
     if segue.identifier == "detail" {
        if let indexPath = tableView.indexPathForSelectedRow {
            let destinationController = segue.destinationViewController as! DetailViewController
            destinationController.Station = (Search.active) ? searchResult[indexPath.row] : sorted_list[indexPath.row]
            Search.searchBar.hidden=true
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
        searchResult = sorted_list.filter({ (stat:Stat)->Bool in
            let cityMatch = stat.cityTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let stationMatch = stat.stationTitle.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return cityMatch != nil || stationMatch != nil
        })

    
    }
    
//unwind segue
    @IBAction func close(segue:UIStoryboardSegue){
        Search.searchBar.hidden=false

    }
    
    

}
