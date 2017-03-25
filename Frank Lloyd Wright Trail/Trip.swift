//
//  Trip.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/18/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class Trip: Object{
    dynamic var tripName = "New trip"
    dynamic var startDate: Date?{
        didSet{
            if let start = self.startTime{
                self.fullStartDate = CombineDates.combineDateWithTime(self.startDate!, time: start)
            }else{
                self.fullStartDate = CombineDates.combineDateWithTime(self.startDate!, time: Date())
            }
        }
    }
    dynamic var startTime: Date?{
        didSet{
            if let startDay = self.startDate{
                self.fullStartDate = CombineDates.combineDateWithTime(startDay, time: self.startTime!)
            }else{
                self.fullStartDate = CombineDates.combineDateWithTime(Date(), time: self.startTime!)
            }
        }
    }
    dynamic var fullStartDate: Date?
    dynamic var endDate: Date?{
        didSet{
            if let end = self.endTime{
                self.fullEndDate = CombineDates.combineDateWithTime(self.endDate!, time: end)
            }else{
                self.fullEndDate = CombineDates.combineDateWithTime(self.endDate!, time: Date())
            }
        }
    }
    dynamic var endTime: Date?{
        didSet{
            if let endDay = self.endDate{
                self.fullEndDate = CombineDates.combineDateWithTime(endDay, time: self.endTime!)
            }else{
                self.fullEndDate = CombineDates.combineDateWithTime(Date(), time: self.endTime!)
            }
            
        }
    }
    dynamic var fullEndDate: Date?
    let sitesInfo = List<TripObject>()
    let siteStops = List<SiteStop>()
    let genericStops = List<GenericStop>()
    let mealStops = List<MealStop>()
    dynamic var id = 0
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Trip.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var stops: [Stop] {
        get {
            var stops = [Stop]()
            for stop in siteStops {
                stops.append(stop)
            }
            for stop in genericStops {
                stops.append(stop)
            }
            for stop in mealStops {
                stops.append(stop)
            }
            return stops
        }
    }
    
}