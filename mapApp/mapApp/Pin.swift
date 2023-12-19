//
//  Pin.swift
//  mapApp
//
//  Created by Mykyta Popov on 19/12/2023.
//

import Cocoa
import MapKit

class Pin: NSObject, MKAnnotation {
	let title: String?
	var subtitle: String?
	let coordinate: CLLocationCoordinate2D
	let color: NSColor
	
	init(title: String,
		 subtitle: String? = nil,
		 coordinate: CLLocationCoordinate2D,
		 color: NSColor = NSColor.green) {
		self.title = title
		self.subtitle = subtitle
		self.coordinate = coordinate
		self.color = color
	}
}
