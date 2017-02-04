//
//  TripOrder.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
class TripObject: NSObject {
    
    var startPoint: String?
    var endPoint: String?
    var timeText: String?
    var timeValue: Int?
    var distanceText: String?
    var distanceValue: Int?
    
    init(startPoint: String, endPoint: String, timeText: String, timeValue: Int, distanceText: String, distanceValue: Int) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.timeText = timeText
        self.timeValue = timeValue
        self.distanceText = distanceText
        self.distanceValue = distanceValue
    }
    
}
