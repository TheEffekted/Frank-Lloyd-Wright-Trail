//
//  GoogleDirectionsAPI.swift
//  Frank Lloyd Wright Trail
//
//  Created by Max on 3/24/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift
import UIKit

class GoogleDirectionsAPI: NSObject, CLLocationManagerDelegate {
    
    func getOptimizedWayPoints(_ id: Int, completion: @escaping (_ timeLineCards: [TimelineCardModel]) -> Void) {
        //retrieve the start and end coordinates from user location
        guard let userCoords = getStartCoordinates() else {
            print("User Location Failed")
            return
        }
        
        guard let trip = RealmQuery.queryTripByID(id) else {
            print("Could Not Find Trip by ID")
            return
        }
        
        
        //retrieve coordinates of all the sitestops to be used as waypoints
        guard let waypointCoords = getSiteCoords(trip.siteStops) else {
            print("Error Getting Sites' Coords")
            return
        }
        //format coordinates for use in url
        let userCoordString = "\(userCoords.lat),\(userCoords.lon)"
        var waypointsCoordString = ""
        for coord in waypointCoords {
            waypointsCoordString += "\(coord.lat),\(coord.lon)%7C"
        }
        //remove last 3 characters (extra "%7C")
        waypointsCoordString = String(waypointsCoordString.characters.dropLast())
        waypointsCoordString = String(waypointsCoordString.characters.dropLast())
        waypointsCoordString = String(waypointsCoordString.characters.dropLast())
        
        let key = "AIzaSyD99efuqx7jK3bOi7txWUDRZNlh-G50b0w"
        
        let directionEndPoint = "https://maps.googleapis.com/maps/api/directions/json?origin=\(userCoordString)&destination=\(userCoordString)&waypoints=optimize:true%7C\(waypointsCoordString)&key=\(key)"
        print("URL!! = \(directionEndPoint)")
        
        guard let url = URL(string: directionEndPoint) else {
            print("Error Converting to URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {data, response, error in
            guard error == nil else {
                print("Error Calling GET")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error Receiving Data")
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                guard let dictionary = json as? [String: Any] else {
                    print("Conversion to Dictionary Failed")
                    return
                }
                guard let routes = dictionary["routes"] as? [[String: Any]] else {
                    print("Conversion to Routes Failed")
                    return
                }
                guard let route = routes.first else { return }
                guard let waypointOrder = route["waypoint_order"] as? [Int] else {
                    print("Conversion to Waypoint Order Failed")
                    return
                }
                guard let legs = route["legs"] as? [[String: Any]] else {
                    print("Conversion to Legs Failed")
                    return
                }
                //timelineCards to be returned
                var timelineCards = [TimelineCardModel]()
                var timelineHomeCard = TimelineCardModel()
                timelineHomeCard.icon = UIImage(named: "house")
                
                timelineCards.append(timelineHomeCard)
                for (index, leg) in legs.enumerated() {
                    var timelineSiteCard = TimelineCardModel()
                    var timelineCarCard = TimelineCardModel()
                    guard let distance = leg["distance"] as? [String: Any] else {
                        print("Conversion to Distance Failed")
                        return
                    }
                    guard let distanceText = distance["text"] as? String else {
                        print("Conversion to Distance Text Failed")
                        return
                    }
                    guard let duration = leg["duration"] as? [String: Any] else {
                        print("Conversion to Duration Failed")
                        return
                    }
                    guard let durationText = duration["text"] as? String else {
                        print("Conversion to Duration Text Failed")
                        return
                    }
                    timelineCarCard.distance = distanceText
                    timelineCarCard.duration = durationText
                    timelineCarCard.icon = UIImage(named: "car")
                    timelineCards.append(timelineCarCard)
                    //add sites in correct order
                    let index = waypointOrder[index]
                    let site = trip.siteStops[index].site
                    timelineSiteCard.name = site?.title!
                    timelineSiteCard.locationImage = UIImage(named: (site?.imageName!)!)
                    timelineCards.append(timelineSiteCard)
                }
                timelineCards.append(timelineHomeCard)
                completion(timelineCards)
                
            } catch let error {
                print(error)
                print("Error Converting Data to JSON")
                return
            }
        }
        //hit url and obtain results
        task.resume()
    }
    
    func getStartCoordinates() -> (lat: Double, lon: Double)? {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            return (Double((locationManager.location?.coordinate.latitude)!), Double((locationManager.location?.coordinate.longitude)!))
        }
        return nil
    }
    
    func getSiteCoords(_ siteStops: List<SiteStop>) -> [(lat: Double, lon: Double)]? {
        var coordsList = [(Double, Double)]()
        for siteStop in siteStops {
            guard let site = siteStop.site else {
                print("No Site in SiteStop")
                return nil
            }
            let lat = Double(site.lat.value!)
            let lon = Double(site.lon.value!)
            coordsList.append(lat, lon)
        }
        return coordsList
    }
}