//
//  JCTableViewCell.swift
//  SwiftDemo
//
//  Created by justin zhang on 2020/12/11.
//

import Foundation

public protocol JCTableViewCellProtocol: NSObjectProtocol {
    
    func updateContent()
    
}

open class JCTableViewCell: UITableViewCell, JCTableViewCellProtocol {
    
    public var model:JCCellModel = JCCellModel() {
        didSet {
            self.updateContent()
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func updateContent() {
        //implement by subclass
    }
    
}
