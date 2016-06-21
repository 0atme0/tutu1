//
//  Cities.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 20.06.16.
//  Copyright © 2016 111. All rights reserved.
//

//Реалм база городов

import Foundation
import RealmSwift

class Cities: Object{
    
    dynamic var city_from: Bool = true
    dynamic var country_title: String = ""
    dynamic var point_longitude: Double = 0.0
    dynamic var point_latitude: Double = 0.0
    dynamic var districtTitle: String = ""
    dynamic var city_id: Int = 0
    dynamic var city_title: String = ""
    dynamic var region_title: String = ""
 
    var stations = List<Stations>()  //один ко многим
    
    override static func primaryKey() -> String? {
        return "city_id"
    }
}