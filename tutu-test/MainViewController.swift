//
//  ViewController.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 20.06.16.
//  Copyright © 2016 111. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import Async

class MainViewController: UIViewController {
    
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var loadToButton: UIButton!
    @IBOutlet weak var loadFromButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var labelTo: UILabel!
    @IBOutlet weak var labelFrom: UILabel!
    var file: FilePlist = FilePlist()
    var loadData = LoadDataOfStations()
    var arrayFrom : [ClassStation] = []
    var arrayTo : [ClassStation] = []

    @IBAction func book(sender: AnyObject) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        if labelFrom.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка", message:  "Укажите пункт отправления" , preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else if labelTo.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка", message:  "Укажите пункт прибытия" , preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
        let alert = UIAlertController(title: "Бронирование", message:  "Вы забронировали поездку  "+dateFormatter.stringFromDate(date.date)+"\n Пункт отправления:\n"+labelFrom.text!+"\n Пункт прибытия:\n"+labelTo.text! , preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        loadFromButton.enabled=false
        loadToButton.enabled=false
        bookButton.enabled=false
        loadingIndicator.hidesWhenStopped = true;
        loadingIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.Gray;
        loadingIndicator.center = view.center;
        loadingIndicator.startAnimating();

        super.viewDidLoad()
//проверяем был ли джсон загружен в базу
        if file.flag == nil {
        loadData.loadJson({(completion: Bool) -> () in
            
            let asyncGroup = dispatch_group_create()
            dispatch_group_async(asyncGroup, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0))
            {
                self.arrayFrom = self.loadData.loadToClass(true)
            }
            dispatch_group_async(asyncGroup, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0))
            {
                self.arrayTo = self.loadData.loadToClass(false)
            }
            dispatch_group_notify(asyncGroup, dispatch_get_main_queue())
            {
                self.loadToButton.enabled = true
                self.loadFromButton.enabled = true
                self.bookButton.enabled = true
                self.loadingIndicator.stopAnimating();

            }
        })
        } else {
            let asyncGroup = dispatch_group_create()
            dispatch_group_async(asyncGroup, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0))
            {
                self.arrayFrom = self.loadData.loadToClass(true)
            }
            dispatch_group_async(asyncGroup, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0))
            {
                self.arrayTo = self.loadData.loadToClass(false)
            }
            dispatch_group_notify(asyncGroup, dispatch_get_main_queue())
            {
                self.loadToButton.enabled = true
                self.loadFromButton.enabled = true
                self.bookButton.enabled = true
                self.loadingIndicator.stopAnimating();

            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueStationsListFrom" {
                
                let destVC = segue.destinationViewController as! ListOfStationsViewController
            destVC.stationsList = arrayFrom
            
        }
        if segue.identifier == "segueStationsListTo" {
            
            let destVC = segue.destinationViewController as! ListOfStationsViewController
            destVC.stationsList = arrayTo
        }
    }
    
//unwind segue
    @IBAction func add(segue:UIStoryboardSegue){
        if let detailVC = segue.sourceViewController as? DetailOfStationnViewController{
            if detailVC.station.from == true {
                labelFrom.text = detailVC.station.cityTitle+"/"+detailVC.station.stationTitle
            }
            if detailVC.station.from == false {
                labelTo.text = detailVC.station.cityTitle+"/"+detailVC.station.stationTitle
            }
        }
    }


}

