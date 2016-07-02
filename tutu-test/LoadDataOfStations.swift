//
//  Load.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 20.06.16.
//  Copyright © 2016 111. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
import Async


class LoadDataOfStations{
    
    
    func loadJson(completion: (Bool)->()){
        
        let asyncGroup = dispatch_group_create()
        var checkToLoad: FilePlist = FilePlist()
        let url = "https://raw.githubusercontent.com/tutu-ru/hire_ios-test/master/allStations.json"
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                dispatch_group_async(asyncGroup, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {

                let realm = try! Realm()
                if let value = response.result.value {

                    let json = JSON(value)
                        for (_,subJson):(String, JSON) in json["citiesFrom"] {
                    
                            var city = DatabaseOfCities()
                            city.cityFrom = true
                            city.countryTitle = subJson["countryTitle"].stringValue
                            city.cityId = subJson["cityId"].intValue
                            city.cityTitle = subJson["cityTitle"].stringValue
                            city.pointLongitude = subJson["point"]["longitude"].doubleValue
                            city.pointLatitude = subJson["point"]["latitude"].doubleValue
                            city.districtTitle = subJson["districtTitle"].stringValue
                            city.regionTitle = subJson["regionTitle"].stringValue
                    
                            for (_,subJson):(String, JSON) in subJson["stations"] {
                                var station = DatabaseOfStations()
                                station.cityId = subJson["cityId"].intValue
                                station.countryTitle = subJson["countryTitle"].stringValue
                                station.cityTitle = subJson["cityTitle"].stringValue
                                station.pointLongitude = subJson["point"]["longitude"].doubleValue
                                station.pointLatitude = subJson["point"]["latitude"].doubleValue
                                station.districtTitle = subJson["districtTitle"].stringValue
                                station.stationTitle = subJson["stationTitle"].stringValue
                                station.regionTitle = subJson["regionTitle"].stringValue
                                station.stationId = subJson["stationId"].intValue
                                city.stations.append(station)
                            }
                        
                    try! realm.write {
                        realm.add(city, update: true)
                            }
                    }
                    for (_,subJson):(String, JSON) in json["citiesTo"] {
                        var city = DatabaseOfCities()
                        city.cityFrom = false
                        city.countryTitle = subJson["countryTitle"].stringValue
                        city.cityId = subJson["cityId"].intValue
                        city.cityTitle = subJson["cityTitle"].stringValue
                        city.pointLongitude = subJson["point"]["longitude"].doubleValue
                        city.pointLatitude = subJson["point"]["latitude"].doubleValue
                        city.districtTitle = subJson["districtTitle"].stringValue
                        city.regionTitle = subJson["regionTitle"].stringValue
                        
                        for (_,subJson):(String, JSON) in subJson["stations"] {
                            var station = DatabaseOfStations()
                            station.cityId = subJson["cityId"].intValue
                            station.countryTitle = subJson["countryTitle"].stringValue
                            station.cityTitle = subJson["cityTitle"].stringValue
                            station.pointLongitude = subJson["point"]["longitude"].doubleValue
                            station.pointLatitude = subJson["point"]["latitude"].doubleValue
                            station.districtTitle = subJson["districtTitle"].stringValue
                            station.stationTitle = subJson["stationTitle"].stringValue
                            station.regionTitle = subJson["regionTitle"].stringValue
                            station.stationId = subJson["stationId"].intValue
                            city.stations.append(station)
                        }
                        
                        try! realm.write {
                            realm.add(city, update: true)
                        }
                    }
                    checkToLoad.flag = true
                    
                }
                }
        
            case .Failure(let error):
                print(error)
                
        }
            dispatch_group_notify(asyncGroup, dispatch_get_main_queue()) {
                completion(true)
            }
      
        }
       
        
}
    
//функция создает из реалм массив станций класса Стат
    func loadToClass(from:Bool) -> [ClassStation] {
        var statList: [ClassStation] = []
        let realm = try! Realm()

        let last_data = realm.objects(DatabaseOfCities)
        for var i  in 0..<last_data.count {
            if last_data[i].cityFrom == from{
            var cityTmp = ClassCity()
            cityTmp.cityTitle = last_data[i].cityTitle
            cityTmp.cityFrom = last_data[i].cityFrom
            cityTmp.cityId = last_data[i].cityId
            cityTmp.countryTitle = last_data[i].countryTitle
            cityTmp.districtTitle = last_data[i].districtTitle
            cityTmp.pointLatitude = last_data[i].pointLatitude
            cityTmp.pointLongitude = last_data[i].pointLongitude
            cityTmp.regionTitle = last_data[i].regionTitle
            
            for value in last_data[i].stations{
                var stationTmp = ClassStation()
                stationTmp.from = cityTmp.cityFrom
                stationTmp.cityId = value.cityId
                stationTmp.cityTitle = value.cityTitle
                stationTmp.countryTitle = value.countryTitle
                stationTmp.districtTitle = value.districtTitle
                stationTmp.pointLatitude = value.pointLatitude
                stationTmp.pointLongitude = value.pointLongitude
                stationTmp.regionTitle = value.regionTitle
                stationTmp.stationId = value.stationId
                stationTmp.stationTitle = value.stationTitle
                
                cityTmp.stations.append(stationTmp)
                statList.append(stationTmp)
            }
            }
        }
        return statList
    }


}