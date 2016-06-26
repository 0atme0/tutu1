//
//  DetailViewController.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 21.06.16.
//  Copyright © 2016 111. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
 

    var Station: Stat = Stat()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DetailViewCell
        switch indexPath.row {
        case 0:
            cell.label.text = "Название страны"
            cell.value.text = Station.countryTitle
        case 1:
            cell.label.text = "Название региона"
            cell.value.text = Station.regionTitle
        case 2:
            cell.label.text = "Название города"
            cell.value.text = Station.cityTitle
        case 3:
            cell.label.text = "Идентификатор города"
            cell.value.text = String(Station.cityId)
        case 4:
            cell.label.text = "Название станции"
            cell.value.text = Station.stationTitle
        case 5:
            cell.label.text = "Идентификатор станции"
            cell.value.text = String(Station.stationId)
        case 6:
            cell.label.text = "Долгота"
            cell.value.text = String(Station.point_longitude)
        case 7:
            cell.label.text = "Широта"
            cell.value.text = String(Station.point_latitude)
        default:
            cell.label.text = ""
            cell.value.text = ""
        }
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
