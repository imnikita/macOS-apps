//
//  ViewController.swift
//  MindMasterGame
//
//  Created by Mykyta Popov on 15/12/2023.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet private weak var tableView: NSTableView!
	@IBOutlet private weak var goButton: NSButton!
	@IBOutlet private weak var guess: NSTextField!
	
	private var answer = ""
	private var guesses = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		startNewGame()
	}

	override var representedObject: Any? {
		didSet {
		
		}
	}
	
	@IBAction func goButtonPressed(_ sender: NSButton) {
		let guessString = guess.stringValue
		guard Set(guessString).count == 4, guessString.count == 4 else { return }
		
		let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
		guard guessString.rangeOfCharacter(from: badCharacters) == nil else { return }
		
		guesses.insert(guessString, at: 0)
		tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
		
		if result(for: guessString).contains("4b") {
			let alert = NSAlert()
			alert.messageText = "You win"
			alert.informativeText = "Congrats!!! Click OK to plat again"
			alert.runModal()
			
			startNewGame()
		}
		
		
	}
	
	private func result(for guess: String) -> String {
		var bulls = 0
		var cows = 0
		
		let guessLetters = Array(guess)
		let answerLetters = Array(answer)
		
		for (index, letter) in guessLetters.enumerated() {
			if letter == answerLetters[index] {
				bulls += 1
			} else if answerLetters.contains(letter) {
				cows += 1
			}
		}
		
		return "\(bulls)b, \(cows)c"
	}
	
	private func startNewGame() {
		guess.stringValue = ""
		guesses.removeAll()
		var numbers = Array(0...9).shuffled()
		
		for _ in 0 ..< 4 {
			answer.append(String(numbers.removeLast()))
		}
		debugPrint(answer)
		tableView.reloadData()
	}
}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
	func numberOfRows(in tableView: NSTableView) -> Int {
		guesses.count
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard
			let stringId = tableColumn?.identifier.rawValue,
			let vm = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: stringId),
										owner: self) as? NSTableCellView else { return nil }
		
		if tableColumn?.title == "Guess" {
			vm.textField?.stringValue = guesses[row]
		} else {
			vm.textField?.stringValue = result(for: guesses[row])
		}
		
		return vm
	}
	
	func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
		false
	}
	
}

