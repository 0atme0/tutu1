//
//  City.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 21.06.16.
//  Copyright © 2016 111. All rights reserved.
//

//Класс для удобного использования массива городов

import UIKit

class City {

    var city_from: Bool = true
    var country_title: String = ""
    var point_longitude: Double = 0.0
    var point_latitude: Double = 0.0
    var districtTitle: String = ""
    var city_id: Int = 0
    var city_title: String = ""
    var region_title: String = ""
    
    var stations : [Stat] = []
    
}
