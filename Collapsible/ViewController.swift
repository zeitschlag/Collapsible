//
//  ViewController.swift
//  Collapsible
//
//  Created by Nathan Mattes on 28.09.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CollapsibleViewDelegate {

    @IBOutlet weak var collapsibleView: CollapsibleView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        collapsibleView.delegate = self
        collapsibleView.updateView()
    }

    //MARK: - UITableViewDelegate

    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "identifier"

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        cell.textLabel?.text = "\(indexPath.row)"

        return cell
    }

    //MARK: - CollapsibleViewDelegate
    
    var contentHeight: CGFloat {
        get {

                var height: CGFloat = 0.0

                if self.tableView.numberOfRows(inSection: 0) > 0 {

                    for i in 0...(self.tableView.numberOfRows(inSection: 0) - 1) {
                        height = height + self.tableView.rectForRow(at: IndexPath(row: i, section: 0)).size.height
                    }
                }

                return height
        }

    }


    func collapseButtonTapped(_ sender: Any) {
        // change Image, for example
    }

}

