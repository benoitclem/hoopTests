//
//  HoopSwitchCell.swift
//  formTests
//
//  Created by Clément on 14/12/2018.
//  Copyright © 2018 hoop. All rights reserved.
//

import UIKit
import Eureka

public class HoopSwitchCell: Cell<Bool>, CellType {
    
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    public override func setup() {
        super.setup()
        
        // switchControl.addTarget(self, action: #selector(CustomCell.switchValueChanged), for: .valueChanged)
    }
    
    public override func update() {
        super.update()
        // Do some custom here
        rowLabel.text = (row as! HoopSwitchRow).title
        switchControl.isOn = (row as! HoopSwitchRow).state ?? true
    }
}

public final class HoopSwitchRow: Row<HoopSwitchCell>, RowType {
    
    public var state: Bool?
    
    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<HoopSwitchCell>(nibName: "HoopSwitchCell")
    }
}

