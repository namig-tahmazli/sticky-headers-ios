//
//  ViewController.swift
//  StickyHeaders
//
//  Created by namig.tahmazli on 02/05/2019.
//  Copyright © 2019 namig.tahmazli. All rights reserved.
//

import UIKit

struct Message {
    let message:String
    let fromMe:Bool
    let date: Date
}

struct GroupedMessages{
    let date: Date
    let messages:[Message]
}

extension Date {
    static func fromString(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: dateString) ?? Date()
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
}

class HeaderLabel: UILabel {
    override var intrinsicContentSize: CGSize {
        let original = super.intrinsicContentSize
        let width = original.width + 2*16
        let height = original.height + 16
        layer.cornerRadius = height/2
        layer.masksToBounds = true
        return CGSize(width: width, height: height)
    }
}

class ViewController: UITableViewController {
    
    private let reuseIdentifier = "cell"
    
    private let messages:[GroupedMessages] = {
        
        let array = [
        Message(message: "It is very long message that will cause it to wrap so we can see that it is happending", fromMe: true, date: Date.fromString(dateString: "10/11/2018")),
        Message(message: "It is very long message that will cause it to wrap so we can see that it is happending", fromMe: true, date: Date.fromString(dateString: "10/11/2018")),
        Message(message: "It is very long message that will cause it to wrap so we can see that it is happending", fromMe: false, date: Date.fromString(dateString: "10/10/2018")),
        Message(message: "It is very long message that will cause it to wrap so we can see that it is happending", fromMe: false, date: Date.fromString(dateString: "10/10/2018")),
        Message(message: "It is very long message that will cause it to wrap so we can see that it is happending", fromMe: true, date: Date.fromString(dateString: "10/09/2018")),
        Message(message: "It is very long message that will cause it to wrap so we can see that it is happending", fromMe: false, date: Date.fromString(dateString: "10/09/2018")),
        Message(message: "It is very long message that will cause it to wrap so we can see that it is happending", fromMe: true, date: Date.fromString(dateString: "10/08/2018")),
        Message(message: "It is very long message that will cause it to wrap so we can see that it is happending", fromMe: false, date: Date.fromString(dateString: "10/08/2018"))
    ]
        
        return Dictionary.init(grouping: array, by: { (element: Message) -> Date in
            return element.date
        }).map{(key, value) in
            return GroupedMessages(date: key, messages: value)
        }
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MessageViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages[section].messages.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        
        let label = HeaderLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let date = messages[section].date
        label.text = date.toString()
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessageViewCell
        let message = messages[indexPath.section].messages[indexPath.row]
        cell.bindData(message: message)
        return cell
    }
}

