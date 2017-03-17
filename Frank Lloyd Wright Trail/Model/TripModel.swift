//
//  TripModel.swift
//  Frank Lloyd Wright Trail
//  The TripModel struct is used to hold the information that the user selects on the Choose Destination Scene (the sites) and the Trip Time scene (the length of the full trip)
//  Created by Max on 1/29/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation

struct TripModel {
    
    static var shared = TripModel()
    
    var tripName: String?
    var startDate: NSDate?{
        didSet{
            if let start = self.startTime{
                self.fullStartDate = CombineDates.combineDateWithTime(self.startDate!, time: start)
            }else{
                self.fullStartDate = CombineDates.combineDateWithTime(self.startDate!, time: NSDate())
            }
        }
    }
    var startTime: NSDate?{
        didSet{
            if let startDay = self.startDate{
                self.fullStartDate = CombineDates.combineDateWithTime(startDay, time: self.startTime!)
            }else{
                self.fullStartDate = CombineDates.combineDateWithTime(NSDate(), time: self.startTime!)
            }
        }
    }
    var fullStartDate: NSDate?
    var endDate: NSDate?{
        didSet{
            if let end = self.endTime{
                self.fullEndDate = CombineDates.combineDateWithTime(self.endDate!, time: end)
            }else{
                self.fullEndDate = CombineDates.combineDateWithTime(self.endDate!, time: NSDate())
            }
        }
    }
    var endTime: NSDate?{
        didSet{
            if let endDay = self.endDate{
                self.fullEndDate = CombineDates.combineDateWithTime(endDay, time: self.endTime!)
            }else{
                self.fullEndDate = CombineDates.combineDateWithTime(NSDate(), time: self.endTime!)
            }
            
        }
    }
    var fullEndDate: NSDate?
    var sitesInfo = [TripObject]()
    var stops = [Stop]()
    var type : String?
    
    func getLocationCount() -> Int{
        var count = 0
        for stop in self.stops{
            if stop is SiteStop{
                count+=1
            }
        }
        return count
    }
    
    func getLocations() -> [SiteStop]?{
        var sites = [SiteStop]()
        for stop in self.stops{
            if let loc = stop as? SiteStop{
                sites.append(loc)
            }
        }
        return sites
    }
    
   

}


