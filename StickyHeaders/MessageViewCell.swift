//
//  MessageViewCell.swift
//  StickyHeaders
//
//  Created by namig.tahmazli on 02/05/2019.
//  Copyright © 2019 namig.tahmazli. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    private var leadingContraints:NSLayoutConstraint!
    private var trailingConstraints: NSLayoutConstraint!
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    private let messageBubble: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout(){
        
        addSubview(messageBubble)
        
        leadingContraints = messageBubble.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        leadingContraints.isActive = true
        
        trailingConstraints = messageBubble.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        trailingConstraints.isActive = false
        
        messageBubble.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        messageBubble.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        let maxWidth = self.frame.width * 0.75
        
        messageBubble.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        messageBubble.addSubview(messageLabel)
        
        let constraints = [messageLabel.leftAnchor.constraint(equalTo: messageBubble.leftAnchor,constant: 8),
        messageLabel.rightAnchor.constraint(equalTo: messageBubble.rightAnchor,constant: -8),
        messageLabel.topAnchor.constraint(equalTo: messageBubble.topAnchor,constant: 8),
        messageLabel.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor,constant: -8)]
        
        NSLayoutConstraint.activate(constraints)
        
//        messageBubble.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|-8-[v0]-8-|",
//            options: NSLayoutConstraint.FormatOptions(),
//            metrics: nil,
//            views: ["v0": messageLabel]))
//        messageBubble.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-8-[v0]-8-|",
//            options: NSLayoutConstraint.FormatOptions(),
//            metrics: nil,
//            views: ["v0": messageLabel]))
    }
    
    func bindData(message: Message){
        messageLabel.text = message.message
        if message.fromMe {
            trailingConstraints.isActive = true
            leadingContraints.isActive = false
        }else{
            trailingConstraints.isActive = false
            leadingContraints.isActive = true
        }
        messageBubble.backgroundColor = message.fromMe ? .green : .red
    }
}
