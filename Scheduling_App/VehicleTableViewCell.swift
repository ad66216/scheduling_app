//
//  VehicleTableViewCell.swift
//  Scheduling_App
//
//  Created by Alex Danner on 7/14/17.
//  Copyright © 2017 Be More Innovations. All rights reserved.
//

import Foundation
import Material

class VehicleTableViewCell : TableViewCell {
    
    private var spacing: CGFloat = 10
    
    /// A boolean that indicates whether the cell is the last cell.
    public var isLast = false
    
    var card: PresenterCard!
    
    /// Content area.
    var vehicleImageView: UIImageView!
    var vehicleNameView: UILabel!
    
    /// Bottom Bar views.
    var bottomBar: Bar!
    var dateFormatter: DateFormatter!
    var dateLabel: UILabel!
    var favoriteButton: IconButton!
    var shareButton: IconButton!
    
    /// Toolbar views.
    var toolbar: Toolbar!
    var moreButton: IconButton!
    var makeModel: UILabel!
    
    public var vehicle: Vehicle? {
        didSet {
            layoutSubviews()
        }
    }
    
    open override var height: CGFloat {
        get {
            return card.height
        }
        
        set(value) {
            super.height = value
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let v = vehicle else {
            return
        }
        
//        let text = v.make! + " " + v.model! + " - " + v.color!
//        let text = v.make! + " " + v.model!
        self.vehicleNameView.text = String(v.year)
//        self.vehicleNameView.text = text
        dateLabel.text = "VIN: " + v.vin!
        makeModel.text = "   " + v.make! + " " + v.model!
//        toolbar.titleLabel = makeModel
        
        self.vehicleImageView.height = 200
        
            v.image?.getDataInBackground(block: { (imageData: Data?, error: Error?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)?.resize(toWidth: self.contentView.width)
                        
                        DispatchQueue.main.async { [weak self, image = image] in
                            self?.vehicleImageView.image = image
                        }
                    }
                }
            })
        
        card.x = 0
        card.y = 0
        card.width = width
        card.setNeedsLayout()
        card.layoutIfNeeded()
    }
    
    open override func prepare() {
        super.prepare()
        
        layer.rasterizationScale = Screen.scale
        layer.shouldRasterize = true
        
        pulseAnimation = .none
        backgroundColor = nil
        
        prepareImageView()
        prepareDateFormatter()
        prepareDateLabel()
//        prepareFavoriteButton()
//        prepareShareButton()
        prepareMoreButton()
        prepareMakeModelLabel()
        prepareToolbar()
        prepareNameView()
        prepareBottomBar()
        preparePresenterCard()
    }

    func prepareImageView() {
        self.vehicleImageView = UIImageView()
        self.vehicleImageView.contentMode = .scaleAspectFill
    }
    
    func prepareDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    func prepareDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = RobotoFont.regular(with: 12)
        dateLabel.textColor = Color.blueGrey.base
        dateLabel.textAlignment = .center
    }
    
    func prepareMakeModelLabel() {
        makeModel = UILabel()
    }
    
    func prepareFavoriteButton() {
        favoriteButton = IconButton(image: Icon.favorite, tintColor: Color.red.base)
    }
    
    func prepareShareButton() {
        shareButton = IconButton(image: Icon.cm.share, tintColor: Color.blueGrey.base)
    }
    
    func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreHorizontal, tintColor: Color.blueGrey.base)
    }
    
    func prepareToolbar() {
//        toolbar = Toolbar(rightViews: [moreButton])
        toolbar = Toolbar(leftViews: [makeModel], rightViews: [moreButton], centerViews: [])
//        toolbar = Toolbar(rightViews: [moreButton])
        toolbar.backgroundColor = nil
        
//        toolbar.title = makeModel.text
        toolbar.title = "Material"
        toolbar.titleLabel.textColor = .white
        toolbar.titleLabel.textAlignment = .center
        
        toolbar.detail = "Build Beautiful Software"
        toolbar.detailLabel.textColor = .white
        toolbar.detailLabel.textAlignment = .center
    }
    
    func prepareNameView() {
        vehicleNameView = UILabel()
        vehicleNameView.numberOfLines = 0
        vehicleNameView.font = RobotoFont.regular(with: 14)
    }
    
//    func prepareBottomBar() {
//        bottomBar = Bar(leftViews: [favoriteButton], rightViews: [shareButton], centerViews: [dateLabel])
//    }
    
    func prepareBottomBar() {
        bottomBar = Bar(leftViews: [dateLabel], rightViews: [], centerViews: [])
    }
    
    func preparePresenterCard() {
        card = PresenterCard()
        
        card.toolbar = toolbar
        card.presenterView = vehicleImageView
        card.contentView = vehicleNameView
        
        card.contentViewEdgeInsetsPreset = .square3
        card.contentViewEdgeInsets.bottom = 0
        card.bottomBar = bottomBar
        card.depthPreset = .none
        
        contentView.addSubview(card)
    }
}
