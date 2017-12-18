//
//  RandomLocationGenerator.swift
//  Course Project
//
//  Created by Araceli Teixeira on 18/12/17.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import Foundation

class RandomLocationGenerator {
    private static let minLat = 43.6
    private static let maxLat = 43.8
    private static let minLong = -79.7
    private static let maxLong = -79.2
    private static let scale = 100000.0
    
    public static func generateCoordinates() -> (Double, Double) {
        var lat = minLat + Double(arc4random_uniform(UInt32(scale)))/scale * (maxLat - minLat)
        let long = minLong + Double(arc4random_uniform(UInt32(scale)))/scale * (maxLong - minLong)
        if long > -79.5 {
            lat += 0.1
        }
        if long < -79.6 {
            lat -= 0.1
        }
        return (lat, long)
    }
}
