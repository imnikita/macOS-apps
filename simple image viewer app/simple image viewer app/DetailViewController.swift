//
//  DetailViewController.swift
//  simple image viewer app
//
//  Created by Mykyta Popov on 15/12/2023.
//

import Cocoa

class DetailViewController: NSViewController {

	@IBOutlet weak var imageView: NSImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	func imageSelected(_ name: String) {
		imageView.image = NSImage(named: name)
	}
    
}
