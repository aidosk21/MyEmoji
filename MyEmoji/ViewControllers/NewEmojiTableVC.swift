//
//  NewEmojiTableVC.swift
//  MyEmoji
//
//  Created by Aidos on 10.10.2022.
//

import UIKit

class NewEmojiTableVC: UITableViewController {
    
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var emojiTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButton()
        updateTextFields()
    }
    
    private func updateSaveButton() {
        let emojiText = emojiTF.text ?? ""
        let nameText = nameTF.text ?? ""
        let descText = descTF.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descText.isEmpty
        
    }
    
    private func updateTextFields() {
        emojiTF.text = emoji.emoji
        nameTF.text = emoji.name
        descTF.text = emoji.description
    }

    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "save" else { return }
        let emojiText = emojiTF.text ?? ""
        let nameText = nameTF.text ?? ""
        let descText = descTF.text ?? ""
        
        self.emoji = Emoji(emoji: emojiText, name: nameText, description: descText, isFavourite: self.emoji.isFavourite)
        
    }
    // MARK: - Table view data source

  

    
}
