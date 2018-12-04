//
//  location.swift
//  rainyshinycloudy
//
//  Created by AIR on 15.11.2018.
//  Copyright © 2018 AIR. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitud: Double!
}
