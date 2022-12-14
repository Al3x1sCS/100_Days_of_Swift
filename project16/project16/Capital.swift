//
//  Capital.swift
//  project16
//
//  Created by user on 08/09/22.
//
import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikipediaUrl: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, wikipediaUrl: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikipediaUrl = wikipediaUrl
    }
}
