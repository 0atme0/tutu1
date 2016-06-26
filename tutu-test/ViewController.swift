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

class ViewController: UIViewController {
    
    var from : Bool = false //город отправления или город прибытия
    @IBOutlet weak var Date: UIDatePicker!
    @IBOutlet weak var LabelTo: UILabel!
    @IBOutlet weak var LabelFrom: UILabel!
    var file: FilePlist = FilePlist()
    var city = Load()

    @IBAction func book(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        if LabelFrom.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка", message:  "Укажите пункт отправления" , preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else if LabelTo.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка", message:  "Укажите пункт прибытия" , preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
        let alert = UIAlertController(title: "Бронирование", message:  "Вы забронировали поездку  "+dateFormatter.stringFromDate(Date.date)+"\n Пункт отправления:\n"+LabelTo.text!+"\n Пункт прибытия:\n"+LabelFrom.text! , preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//проверяем был ли джсон загружен в базу
        if file.flag == nil {
            city.LoadJson()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "1" {
                
                let destVC = segue.destinationViewController as! TableViewController
                destVC.from = true
            
        }
        if segue.identifier == "0" {
            
            let destVC = segue.destinationViewController as! TableViewController
            destVC.from = false
        }
    }
    
//unwind segue
    @IBAction func add(segue:UIStoryboardSegue){
        if let detailVC = segue.sourceViewController as? DetailViewController{
            if detailVC.Station.from == true {
                LabelFrom.text = detailVC.Station.cityTitle+"/"+detailVC.Station.stationTitle
            }
            if detailVC.Station.from == false {
                LabelTo.text = detailVC.Station.cityTitle+"/"+detailVC.Station.stationTitle
            }
        }
    }


}

