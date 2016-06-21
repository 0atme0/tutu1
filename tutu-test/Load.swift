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

class Load {
    let realm = try! Realm()

//функция парсит джсон и записывает в реалм
    func LoadJson(){
        
        var Load: FilePlist = FilePlist()
        let URL = "https://raw.githubusercontent.com/tutu-ru/hire_ios-test/master/allStations.json"
        Alamofire.request(.GET, URL).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                        for (_,subJson):(String, JSON) in json["citiesFrom"] {
                            var City = Cities()
                            City.city_from = true
                            City.country_title = subJson["countryTitle"].stringValue
                            City.city_id = subJson["cityId"].intValue
                            City.city_title = subJson["cityTitle"].stringValue
                            City.point_longitude = subJson["point"]["longitude"].doubleValue
                            City.point_latitude = subJson["point"]["latitude"].doubleValue
                            City.districtTitle = subJson["districtTitle"].stringValue
                            City.region_title = subJson["regionTitle"].stringValue
                    
                            for (_,subJson):(String, JSON) in subJson["stations"] {
                                var Station = Stations()
                                Station.cityId = subJson["cityId"].intValue
                                Station.countryTitle = subJson["countryTitle"].stringValue
                                Station.cityTitle = subJson["cityTitle"].stringValue
                                Station.point_longitude = subJson["point"]["longitude"].doubleValue
                                Station.point_latitude = subJson["point"]["latitude"].doubleValue
                                Station.districtTitle = subJson["districtTitle"].stringValue
                                Station.stationTitle = subJson["stationTitle"].stringValue
                                Station.regionTitle = subJson["regionTitle"].stringValue
                                Station.stationId = subJson["stationId"].intValue
                                City.stations.append(Station)
                            }
                        
                    try! self.realm.write {
                        self.realm.add(City, update: true)
                            }
                    }
                    for (_,subJson):(String, JSON) in json["citiesTo"] {
                        var City = Cities()
                        City.city_from = false
                        City.country_title = subJson["countryTitle"].stringValue
                        City.city_id = subJson["cityId"].intValue
                        City.city_title = subJson["cityTitle"].stringValue
                        City.point_longitude = subJson["point"]["longitude"].doubleValue
                        City.point_latitude = subJson["point"]["latitude"].doubleValue
                        City.districtTitle = subJson["districtTitle"].stringValue
                        City.region_title = subJson["regionTitle"].stringValue
                        
                        for (_,subJson):(String, JSON) in subJson["stations"] {
                            var Station = Stations()
                            Station.cityId = subJson["cityId"].intValue
                            Station.countryTitle = subJson["countryTitle"].stringValue
                            Station.cityTitle = subJson["cityTitle"].stringValue
                            Station.point_longitude = subJson["point"]["longitude"].doubleValue
                            Station.point_latitude = subJson["point"]["latitude"].doubleValue
                            Station.districtTitle = subJson["districtTitle"].stringValue
                            Station.stationTitle = subJson["stationTitle"].stringValue
                            Station.regionTitle = subJson["regionTitle"].stringValue
                            Station.stationId = subJson["stationId"].intValue
                            City.stations.append(Station)
                        }
                        
                        try! self.realm.write {
                            self.realm.add(City, update: true)
                        }
                    }
                    Load.flag = true
                    
                }
            case .Failure(let error):
                print(error)
            }
        }
        
}
    
//функция создает из реалм массив станций класса Стат
    func LoadToClass(from:Bool) -> [Stat] {
        var Stat_list: [Stat] = []
        let last_data = self.realm.objects(Cities)
        for var i  in 0..<last_data.count {
            if last_data[i].city_from == from{
            var tmp = City()
            tmp.city_title = last_data[i].city_title
            tmp.city_from = last_data[i].city_from
            tmp.city_id = last_data[i].city_id
            tmp.country_title = last_data[i].country_title
            tmp.districtTitle = last_data[i].districtTitle
            tmp.point_latitude = last_data[i].point_latitude
            tmp.point_longitude = last_data[i].point_longitude
            tmp.region_title = last_data[i].region_title
            
            for value in last_data[i].stations{
                var tmp1 = Stat()
                tmp1.from = tmp.city_from
                tmp1.cityId = value.cityId
                tmp1.cityTitle = value.cityTitle
                tmp1.countryTitle = value.countryTitle
                tmp1.districtTitle = value.districtTitle
                tmp1.point_latitude = value.point_latitude
                tmp1.point_longitude = value.point_longitude
                tmp1.regionTitle = value.regionTitle
                tmp1.stationId = value.stationId
                tmp1.stationTitle = value.stationTitle
                
                tmp.stations.append(tmp1)
                Stat_list.append(tmp1)
            }
            }
        }
        return Stat_list
    }


}