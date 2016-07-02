//
//  CopyrightViewController.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 21.06.16.
//  Copyright © 2016 111. All rights reserved.
//

import UIKit

class CopyrightViewController: UIViewController {

    @IBOutlet weak var stack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

//Начальные значения во время загрузки
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translation = CGAffineTransformMakeTranslation(0, -5000)
        stack.transform = CGAffineTransformConcat(scale, translation)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
 
        
//Анимация после загрузки
        UIView.animateWithDuration(0.5, delay: 0, options: [], animations: {
            self.stack.transform = CGAffineTransformIdentity
            }, completion: nil)
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
