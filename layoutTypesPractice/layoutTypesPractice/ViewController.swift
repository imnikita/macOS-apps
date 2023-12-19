//
//  ViewController.swift
//  layoutTypesPractice
//
//  Created by Mykyta Popov on 19/12/2023.
//

import Cocoa

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		
//		createVFL()
//		createAnchors()
//		makeStackView()
		makeGridView()
	}
	
	func makeView(_ number: Int) -> NSView {
		let vm = NSTextField(labelWithString: "View #:\(number)")
		vm.translatesAutoresizingMaskIntoConstraints = false
		vm.alignment = .center
		vm.wantsLayer = true
		vm.layer?.backgroundColor = NSColor.cyan.cgColor
		
		return vm
	}
	
	func createVFL() {
		let textFields = [
			"view0": makeView(0),
			"view1": makeView(1),
			"view2": makeView(2),
			"view3": makeView(3),
		]
		
		for (name, textField) in textFields {
			view.addSubview(textField)
			view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(name)]|",
															   options: [],
															   metrics: nil,
															   views: textFields))
		}
		
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view0]-[view1]-[view2]-[view3]|", options: [], metrics: nil, views: textFields))
	}
	
	func createAnchors() {
		
		var previous: NSView?
		
		let views = [makeView(1), makeView(2), makeView(3), makeView(4)]
		
		views.forEach {
			view.addSubview($0)
			
			NSLayoutConstraint.activate([
				$0.widthAnchor.constraint(equalTo: view.widthAnchor),
				$0.heightAnchor.constraint(equalToConstant: 88),
				$0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
			])
			
			if previous != nil {
				$0.topAnchor.constraint(equalTo: previous!.bottomAnchor, constant: 10).isActive = true
			} else {
				$0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
			}
			
			previous = $0
		}
		
		previous?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	func makeStackView() {
		let stackView = NSStackView(views: [makeView(1), makeView(2), makeView(3), makeView(4)])
		stackView.distribution = .fillEqually
		stackView.orientation = .vertical
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(stackView)
		
		stackView.views.forEach {
			$0.setContentHuggingPriority(NSLayoutConstraint.Priority(1), for: .horizontal)
			$0.setContentHuggingPriority(NSLayoutConstraint.Priority(1), for: .vertical)
		}
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
	}
	
	func makeGridView() {
		let empty = NSGridCell.emptyContentView
		let gridView = NSGridView(views: [
			[makeView(0)],
			[makeView(1), empty, makeView(2)],
			[makeView(3), makeView(4), makeView(5), makeView(6)],
			[makeView(7), empty, makeView(8)],
			[makeView(9)]
		])
		
		gridView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(gridView)
		
		NSLayoutConstraint.activate([
			gridView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			gridView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			gridView.topAnchor.constraint(equalTo: view.topAnchor),
			gridView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

