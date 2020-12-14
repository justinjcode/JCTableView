//
//  JCTableViewProxy.swift
//  SwiftDemo
//
//  Created by justin zhang on 2020/12/11.
//

import UIKit

public class JCTableViewProxy: NSObject {
    //列表数据源
    public var sectionList:[JCSectionModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    public var tableView: UITableView
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
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
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellModel = self.getCellModel(with: indexPath)
        if let callback = cellModel?.willDisplayCallback {
            callback(cell as? JCTableViewCell)
        }
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellModel = self.getCellModel(with: indexPath)
        if let callback = cellModel?.endDisplayCallback {
            callback(cell as? JCTableViewCell)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = self.getSectionModel(with: section)
        if let callback = sectionModel?.heightForHeader {
            let height: CGFloat = callback()
            return height
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionModel = self.getSectionModel(with: section)
        if let callback = sectionModel?.heightForFooter {
            let height: CGFloat = callback()
            return height
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = self.getCellModel(with: indexPath)
        if let callback = cellModel?.heightCallback {
            let height = callback()
            return height
        }
        return 60
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = self.getSectionModel(with: section)
        if let headerClassName = sectionModel?.headerClassName {
            if let headerClass = NSClassFromString(headerClassName) as? UIView.Type {
                let view = headerClass.init(frame: .zero)
                return view
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionModel = self.getSectionModel(with: section)
        if let footerClassName = sectionModel?.footerClassName {
            if let footerClass = NSClassFromString(footerClassName) as? UIView.Type {
                let view = footerClass.init(frame: .zero)
                return view
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = self.getCellModel(with: indexPath)
        if let callback = cellModel?.didSelectedCallback {
            callback()
        }
    }
    
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
                    if let jcCell = cell as? JCTableViewCell {
                        jcCell.model = cellModel
                    }
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
