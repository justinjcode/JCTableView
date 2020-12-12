//
//  JCTableViewProxy.swift
//  SwiftDemo
//
//  Created by justin zhang on 2020/12/11.
//

import UIKit

public class JCTableViewProxy: NSObject {
    //列表数据源
    public var sectionList:[JCSectionModel] = []
    
    //根据IndexPath获取对应cell model
    public func getCellModel(with indexPath: IndexPath) -> JCCellModel? {
        if indexPath.section < self.sectionList.count {
            let sectionModel = self.sectionList[indexPath.section]
            if indexPath.row < sectionModel.cellModelList.count {
                let cellModel = sectionModel.cellModelList[indexPath.row]
                return cellModel
            }
        }
        return nil
    }
    
    //根据section获取对应section model
    public func getSectionModel(with section: NSInteger) -> JCSectionModel? {
        if section < self.sectionList.count {
            let sectionModel = self.sectionList[section]
            return sectionModel
        }
        return nil
    }
}

extension JCTableViewProxy: UITableViewDelegate {
    
}

extension JCTableViewProxy: UITableViewDataSource {
    
    //MARK:cells
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionList.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < self.sectionList.count {
            let sectionModel = self.sectionList[section]
            return sectionModel.cellModelList.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellModel = self.getCellModel(with: indexPath) {
            assert(cellModel.cellClass != nil, "[JCTableViewProxy] cellModel.cellClass should not be nil!!!")
            if let className = cellModel.cellClass {
                if let cellClass = NSClassFromString(className) as? UITableViewCell.Type {
                    let cell = cellClass.init()
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    //MARK:section header&footer
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.getSectionModel(with: section)
        return section?.headerTitle
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let section = self.getSectionModel(with: section)
        return section?.footerTitle
    }
    
}
