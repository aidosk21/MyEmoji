//
//  MyEmojiVC.swift
//  MyEmoji
//
//  Created by Aidos on 28.09.2022.
//

import UIKit

class MyEmojiVC: UITableViewController {
    
    
    var emoji = [
        Emoji(emoji: "🤬", name: "Angry", description: "This is angry emoji", isFavourite: false),
        Emoji(emoji: "👽", name: "Alien", description: "Alien emoji", isFavourite: false),
        Emoji(emoji: "👻", name: "Ghost", description: "This is ghost emoji", isFavourite: false),
        Emoji(emoji: "🚀", name: "Raketa", description: "This is raketa emoji", isFavourite: false),
        Emoji(emoji: "⌚️", name: "Apple Watch", description: "This is apple watch emoji", isFavourite: false),
        Emoji(emoji: "🌏", name: "Earth", description: "This is earth emoji", isFavourite: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        
       
         self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.title = "MyEmoji👨🏻‍💻"
        
    }
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "save" else { return }
        let newEmojiVC = segue.source as! NewEmojiTableVC
        let newEmoji = newEmojiVC.emoji
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emoji[selectedIndexPath.row] = newEmoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let indexPath = IndexPath(row: emoji.count, section: 0)
            emoji.append(newEmoji)
            tableView.insertRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "edit" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let emojiEdit = emoji[indexPath.row]
        let navigationVC = segue.destination as! UINavigationController
        let newEmojiVC = navigationVC.topViewController as! NewEmojiTableVC
        newEmojiVC.emoji = emojiEdit
        newEmojiVC.title = "Edit"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emoji.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let emojis = emoji[indexPath.row]
        cell.set(emoji: emojis)
        
   

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emoji.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emoji.remove(at: sourceIndexPath.row)
        emoji.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.emoji.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var emojis = emoji[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Fav") { action, view, completion in
            emojis.isFavourite = !emojis.isFavourite
            self.emoji[indexPath.row] = emojis
            completion(true)
        }
        action.backgroundColor = emojis.isFavourite ? .systemRed : .systemGray
        action.image = UIImage(systemName: "heart.circle.fill")
        return action
    }



}
