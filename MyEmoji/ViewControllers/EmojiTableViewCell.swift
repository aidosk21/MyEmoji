//
//  EmojiTableViewCell.swift
//  MyEmoji
//
//  Created by Aidos on 28.09.2022.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func set(emoji: Emoji) {
        self.descriptionLabel.text = emoji.description
        self.nameLabel.text = emoji.name
        self.emojiLabel.text = emoji.emoji
    }

    

}
