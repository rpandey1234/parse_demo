//
//  Message.swift
//  ParseChat
//
//  Created by Rahul Pandey on 10/27/16.
//  Copyright © 2016 Rahul Pandey. All rights reserved.
//

import Foundation

class Message {
    let text: String?
    let username: String?
    
    init(text: String?, username: String?) {
        self.text = text
        self.username = username
    }
}
