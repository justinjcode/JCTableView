//
//  JCCellModel.swift
//  SwiftDemo
//
//  Created by justin zhang on 2020/12/11.
//

import Foundation

public class JCCellModel: NSObject {
    
    //cell class
    public var cellClass: String?
    
    //data
    public var data: Any?
    
    //callback
    public var willDisplayCallback: ((JCTableViewCell?) -> Void)?
    public var endDisplayCallback: ((JCTableViewCell?) -> Void)?
    public var heightCallback: (() -> CGFloat)?
    public var didSelectedCallback: (() -> Void)?
    
}
