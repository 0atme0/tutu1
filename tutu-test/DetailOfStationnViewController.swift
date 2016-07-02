//
//  DetailOfStationnViewController.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 02.07.16.
//  Copyright © 2016 111. All rights reserved.
//

import UIKit

class DetailOfStationnViewController: UIViewController {
    var station: ClassStation = ClassStation()
    @IBOutlet weak var stackOfValues: UIStackView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var stationIdLabel: UILabel!
    @IBOutlet weak var stackOfLabels: UIStackView!
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var cityIdLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        stackOfLabels.transform = CGAffineTransformMakeTranslation(-500, 0)
        stackOfValues.transform = CGAffineTransformMakeTranslation(+500, 0)

        
        latitudeLabel.text = String(station.pointLatitude)
        longitudeLabel.text = String(station.pointLongitude)
        stationIdLabel.text = String(station.stationId)
        stationLabel.text = station.stationTitle
        cityIdLabel.text  = String(station.cityId)
        countryLabel.text = station.countryTitle
        regionLabel.text = station.regionTitle
        cityLabel.text = station.cityTitle
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        UIView.animateWithDuration(0.2, delay: 0.3, options: [], animations: {
            self.stackOfValues.transform = CGAffineTransformIdentity
            }, completion: nil)
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            self.stackOfLabels.transform = CGAffineTransformIdentity
            }, completion: nil)
    }


        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
