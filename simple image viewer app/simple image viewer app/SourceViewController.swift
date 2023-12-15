//
//  SourceViewController.swift
//  simple image viewer app
//
//  Created by Mykyta Popov on 15/12/2023.
//

import Cocoa

class SourceViewController: NSViewController {

	@IBOutlet weak var tableView: NSTableView!
	
	private var pictures = [String]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		setImagesNames()
    }
	
	private func setImagesNames() {
		let fileManager = FileManager.default
		guard
			let path = Bundle.main.resourcePath,
			let items = try? fileManager.contentsOfDirectory(atPath: path) else { return }
		
		pictures = items.filter { $0.hasSuffix(".jpg") }
	}
}

extension SourceViewController: NSTableViewDataSource, NSTableViewDelegate {
	func numberOfRows(in tableView: NSTableView) -> Int {
		pictures.count
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard
			let stringId = tableColumn?.identifier.rawValue,
			let vm = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: stringId),
										owner: self) as? NSTableCellView else { return nil }
		vm.textField?.stringValue = pictures[row]
		return vm
	}
	
	func tableViewSelectionDidChange(_ notification: Notification) {
		guard tableView.selectedRow != -1 else { return }
		guard let splitVC = parent as? NSSplitViewController else { return }
		if let detailVC = parent?.children[1] as? DetailViewController {
			let imageName = pictures[tableView.selectedRow]
			detailVC.imageSelected(imageName)
		}
	}
}
