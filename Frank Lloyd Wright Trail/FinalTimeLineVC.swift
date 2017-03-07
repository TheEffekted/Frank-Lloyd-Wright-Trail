//
//  FinalTimeLineVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by MichaelHorning on 3/1/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import UIKit

//TripJsonDelegate
class FinalTimelineVC: UIViewController,TripJsonDelegate {
    
    
    var scrollView: UIScrollView!
    var timeline:   TimelineView!
    var json: JsonParser!
    var sites = TripModel.shared.getLocations()
    var allSites = Site.getSites()
    var sites2 = [Site?]()
    var stops = TripModel.shared.stops
    var startTime = TripModel.shared.startTime
    var endTime = TripModel.shared.endTime
    var tripObj = [TripObject]()
    var newStops = [Stop]()
    var newTripObject = [TripObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 29),
            NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
            ])
        
        for i in 0..<sites!.count {
            
            sites2.append(sites![i].site)
            
        }
        json = JsonParser(withDelegate: self, locations: sites2)
        getTripData(json.orderOfLocations(sites2))
    }
    
    
    // func to get API object data
    func getTripData(objects: [TripObject]) {
        var timeFrames: [TimeFrame] = []
        
        var tripTime = endTime?.timeIntervalSinceDate(startTime!)
        var timeObject = 0.0
        var timeStop = 0.0
        var objectCounter = 0
        //timeFrames.append(TimeFrame(text: Home, date: ))
        
        for i in 0..<stops.count {
            if(stops[i] is MealStop || stops[i] is GenericStop) {
                
                timeStop = +(stops[i].endTime?.timeIntervalSinceDate(stops[i].startTime!))!
            }
            
        }
        for i in 0..<objects.count {
            timeObject = +objects[i].timeValue!
        }
        timeStop = +timeObject
        
        
        for i in 0..<stops.count{
            
            for j in 0..<objects.count{
                // compare the objects to all the sites and if there is a match create card and add a picture from the list of all sites
                
                var newStopTime = 0.0
                while(newStopTime < tripTime){
                    newStops.append(stops[i])
                    
                    if(stops[i] is SiteStop){
                        
                        newTripObject.append(objects[j])
                    }
                    if(timeObject < newStopTime) {
                        
                        newTripObject.append(objects[j])
                        if(stops[i] is MealStop || stops[i] is GenericStop) {
                            newStopTime = +(newStops[i].startTime?.timeIntervalSinceDate(newStops[i].endTime!))!
                            
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
        
        
        for i in 0..<newTripObject.count{
            for j in 0..<sites2.count{
                // compare the objects to all the sites and if there is a match create card and add a picture from the list of all sites
                if(Double(round(100*newTripObject[i].endPoint!)/100) == Double(round(100*allSites[j].lat)/100)){
                    timeFrames.append(TimeFrame(text:"Travel distance is " + newTripObject[i].distanceText! + " Travel time is " + newTripObject[i].timeText!, date: allSites[j].title, image: UIImage(named:allSites[j].imageName!)))
                }
            }
            
        }
        
        timeline = TimelineView(bulletType: .Circle, timeFrames: timeFrames)
        
        scrollView.addSubview(timeline)
        scrollView.addConstraints([
            NSLayoutConstraint(item: timeline, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: timeline, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: 0)
            ])
        
        view.sendSubviewToBack(scrollView)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Trip"
        //let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        //self.navigationItem.rightBarButtonItem = button
    }
    
    //    func doneSelected(sender: UIBarButtonItem){
    //        performSegueWithIdentifier("segueToFinal", sender: nil)
    //    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
}
