
//
//  MainTableView.swift
//  SearchScope
//
//  Created by Vũ on 2/20/19.
//  Copyright © 2019 Vũ. All rights reserved.
//

import UIKit
class MainTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: CGRect.zero, style: .grouped)
        self.delegate = self
        self.dataSource = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
