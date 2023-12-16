//
//  WindowController.swift
//  simple image viewer app
//
//  Created by Mykyta Popov on 16/12/2023.
//

import Cocoa

class WindowController: NSWindowController {

	@IBOutlet weak var shareButton: NSButton!
	
	override func windowDidLoad() {
        super.windowDidLoad()
		shareButton.sendAction(on: .leftMouseDown)
    }
}
