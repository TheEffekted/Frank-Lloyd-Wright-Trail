//
//  RealmWrite.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/18/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWrite{
    static func writeTripName(tripName: String, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.tripName = tripName
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeStartDate(startDate: Date, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.startDate = startDate
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeStartTime(startTime: Date, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.startTime = startTime
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeFullStartDate(_ fullStartDate: Date, _ trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.fullStartDate = fullStartDate
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeFullEndDate(_ fullEndDate: Date, _ trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.fullEndDate = fullEndDate
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeEndDate(endDate: Date, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.endDate = endDate
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeEndTime(endTime: Date, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.endTime = endTime
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeSiteStopDate(index: Int, date: Date, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops[index].date = date
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeSiteStopStartTime(index: Int, date: Date, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops[index].startTime = date
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeSiteStopFullStartDate(index: Int, date: Date, trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops[index].startDate = date
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeSiteStopFullEndDate(index: Int, date: Date, trip: Trip) {
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops[index].endDate = date
            }
        } catch let error {
            print(error)
        }
    }
    
    static func writeSiteStopEndTime(index: Int, date: Date, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops[index].endTime = date
            }
        } catch let error {
            print(error)
        }
    }
    
    
    static func add(siteStop: SiteStop, trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                trip.siteStops.append(siteStop)
            }
        } catch let error {
            print(error)
        }
    }
    
    
    static func add(trip: Trip){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(trip)
            }
        } catch let error {
            print(error)
        }
    }
    
    
    
    
}
