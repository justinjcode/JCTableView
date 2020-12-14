//
//  JCSectionModel.swift
//  SwiftDemo
//
//  Created by justin zhang on 2020/12/11.
//

import UIKit

public class JCSectionModel: NSObject {
    
    public var headerTitle: String?
    public var footerTitle: String?
    public var headerClassName: String?
    public var footerClassName: String?
    
    public var cellModelList:[JCCellModel] = []
    
    public var heightForHeader: (() -> CGFloat)?
    public var heightForFooter: (() -> CGFloat)?
    
}
