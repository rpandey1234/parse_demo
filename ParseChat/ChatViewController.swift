//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Rahul Pandey on 10/27/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
            print("timer func")
            let query = PFQuery(className:"MessageSF")
            query.order(byDescending: "createdAt")
            query.includeKey("user")
            query.findObjectsInBackground(block: { (objects: [PFObject]?, error: Error?) in
                if let objects = objects {
                    self.messages = objects.map({ (object: PFObject) -> Message in
                        let messageText = object["text"] as? String
                        var username: String? = nil
                        if let user = object["user"] as? PFUser {
                            username = user.username
                        }
                        return Message(text: messageText, username: username)
                    })
                    self.tableView.reloadData()
                } else {
                    if let error = error {
                        print("error: \(error.localizedDescription)")
                    } else {
                        print("unknwown error")
                    }
                }
            })
        }
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapSend(_ sender: AnyObject) {
        if let text = chatTextField.text {
            print(chatTextField.text)
            let chat = PFObject(className: "MessageSF")
            chat["text"] = text
            chat["user"] = PFUser.current()
            chat.saveInBackground(block: { (success: Bool, error: Error?) in
                if !success {
                    if let error = error {
                        print("error saving \(error.localizedDescription)")
                    } else {
                        print("unknown error whatever")
                    }
                } else {
                    print("saved")
                }
            })
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        messageCell.messageLabel.text = messages[indexPath.row].text
        messageCell.usernameLabel.text = messages[indexPath.row].username
        return messageCell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
