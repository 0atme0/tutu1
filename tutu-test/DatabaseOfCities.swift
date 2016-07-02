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

class DatabaseOfCities: Object{
    
    dynamic var cityFrom: Bool = true
    dynamic var countryTitle: String = ""
    dynamic var pointLongitude: Double = 0.0
    dynamic var pointLatitude: Double = 0.0
    dynamic var districtTitle: String = ""
    dynamic var cityId: Int = 0
    dynamic var cityTitle: String = ""
    dynamic var regionTitle: String = ""
 
    var stations = List<DatabaseOfStations>()  //один ко многим
    
    override static func primaryKey() -> String? {
        return "cityId"
    }
}