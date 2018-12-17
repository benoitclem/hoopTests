//
//  Customs.swift
//  formTests
//
//  Created by Clément on 13/12/2018.
//  Copyright © 2018 hoop. All rights reserved.
//

import Foundation
import Eureka

// Coded in nib
class PickerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
}

// Coded here
class DisplayCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = imageView.frame
        frame.size.height = self.frame.size.height
        frame.size.width = self.frame.size.width
        frame.origin.x = 0
        frame.origin.y = 0
        imageView.frame = frame
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class ImageCollectionViewCell: Cell<Bool>, CellType, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var displayCollectionView: UICollectionView!
    @IBOutlet weak var pickerCollectionView: UICollectionView!
    
    let DISPLAY_CV: Int = 1
    let PICKER_CV: Int = 2
    
    public override func setup() {
        super.setup()
        
        // configure display part of cell
        displayCollectionView.register(DisplayCell.self, forCellWithReuseIdentifier: "displayCell")
        displayCollectionView.tag = DISPLAY_CV
        displayCollectionView.dataSource = self
        displayCollectionView.delegate = self
        
        // configure picker part of cell
        pickerCollectionView.register(UINib(nibName: "PickerCell", bundle: nil), forCellWithReuseIdentifier: "pickerCell")
        pickerCollectionView.tag = PICKER_CV
        pickerCollectionView.dataSource = self
        pickerCollectionView.delegate = self
    }

    public override func update() {
        super.update()
        // Do some custom here
        // backgroundColor = (row.value ?? false) ? .white : .green
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(collectionView.tag)
        if collectionView.tag == DISPLAY_CV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "displayCell", for: indexPath) as! DisplayCell
            cell.imageView.image = (row as! ImageCollectionViewRow).image
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pickerCell", for: indexPath) as! PickerCell
            cell.imageView.image = (row as! ImageCollectionViewRow).image
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == DISPLAY_CV {
            return collectionView.frame.size
        } else {
            let width = collectionView.frame.size.width/5.0
            return CGSize(width: width, height: width)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

// The custom Row also has the cell: CustomCell and its correspond value
public final class ImageCollectionViewRow: Row<ImageCollectionViewCell>, RowType {

    public var image: UIImage?

    required public init(tag: String?) {
        super.init(tag: tag)
        // We set the cellProvider to load the .xib corresponding to our cell
        cellProvider = CellProvider<ImageCollectionViewCell>(nibName: "CollectionViewCell")
    }
}
