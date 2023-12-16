//
//  ViewController.swift
//  simple image viewer app
//
//  Created by Mykyta Popov on 15/12/2023.
//

import Cocoa

class ViewController: NSSplitViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	@IBAction private func sharedClicked(_ sender: NSView) {
		guard
			let detailViewController = children[1] as? DetailViewController,
			let image = detailViewController.imageView.image else { return }
		
		let picker = NSSharingServicePicker(items: [image])
		picker.show(relativeTo: .zero, of: sender, preferredEdge: .minY)
	}
}

