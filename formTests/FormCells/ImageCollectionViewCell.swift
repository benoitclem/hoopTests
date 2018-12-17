//
//  Customs.swift
//  formTests
//
//  Created by Clément on 13/12/2018.
//  Copyright © 2018 hoop. All rights reserved.
//

import Foundation
import Eureka

class ImageCell: UICollectionViewCell {
    
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

    @IBOutlet weak var collectionView: UICollectionView!
    
    public override func setup() {
        super.setup()
        // configure CollectionView
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        // switchControl.addTarget(self, action: #selector(CustomCell.switchValueChanged), for: .valueChanged)
    }

//    @objc func switchValueChanged(){
//        row.value = switchControl.isOn
//        row.updateCell() // Re-draws the cell which calls 'update' bellow
//    }

    public override func update() {
        super.update()
        // Do some custom here
        // backgroundColor = (row.value ?? false) ? .white : .green
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imageView.image = (row as! ImageCollectionViewRow).image
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
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
