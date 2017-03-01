//
//  TimelineVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class TimelineVC: UIViewController, TripJsonDelegate {
    
    
    var scrollView: UIScrollView!
    var timeline:   TimelineView!
    var json: JsonParser!
    var sites = TripModel.shared.getSites()
    var allSites = Site.getSites()
    
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
        
        json = JsonParser(withDelegate: self, locations: sites)
        getTripData(json.orderOfLocations(sites))
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // func to get API object data
    func getTripData(objects: [TripObject]) {
        var timeFrames: [TimeFrame] = []
        
        for i in 0..<objects.count{
            for j in 0..<sites.count{
               // compare the objects to all the sites and if there is a match create card and add a picture from the list of all sites
                if(Double(round(100*objects[i].endPoint!)/100) == Double(round(100*allSites[j].lat)/100)){
                    timeFrames.append(TimeFrame(text:"Travel distance is " + objects[i].distanceText! + " Travel time is " + objects[i].timeText!, date: allSites[j].title, image: UIImage(named:allSites[j].imageName!)))
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
    
    
}
