//
//  ParameterViewController.swift
//  formTests
//
//  Created by Clément on 13/12/2018.
//  Copyright © 2018 hoop. All rights reserved.
//

import UIKit
import Eureka

class ParameterViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Color of the background table
        self.tableView.backgroundColor = UIColor.white
        form +++ Section("Mes photos")
            <<< ImageCollectionViewRow() { row in
                row.image = UIImage(named: "sophie")
            }
            +++ Section("Informations")
            <<< HoopLabelRow() { row in
                row.title = "clément"
            }
            <<< HoopLabelRow() { row in
                var style = HoopLabelRowStyle()
                style.bgColor = UIColor.green
                style.txtColor = UIColor.white
                row.title = "31"
                row.value = "salut"
                row.labelStyle = style
            }
            +++ Section("À propos de moi")
            <<< HoopTextViewRow() { row in
                row.placeholder = "write something here"
            }
            +++ Section("Je souhaite rencontrer")
            <<< SwitchRow() { row in
                row.tag = "swh"
                row.title = "Homme"
            }
            <<< HoopSwitchRow() { row in
                row.tag = "swf"
                row.title = "Femme"
                row.state = true
            }
            <<< HoopRangeRow() { row in
                row.title = "Tranche d'age"
                let r = Range(min: 18,low: 18,upp: 55,max: 55)
                row.range = r
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< ButtonRow() {
                $0.title = "action"
            }.onCellSelection { cell, row in
                //row.title = "action 1"
                print(self.form.values())
            }
        
    }
    
    // Nice and fast way to customize the header view
    func tableView(_: UITableView, willDisplayHeaderView view: UIView, forSection: Int) {
        
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = .red
            view.textLabel?.font = UIFont(name: "Heletica", size: 15.0)
        }
    }

    @IBAction func getFormInfos(_ sender: Any) {
    }
}




