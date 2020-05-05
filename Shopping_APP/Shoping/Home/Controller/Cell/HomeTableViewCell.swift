//
//  HomeTableViewCell.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/5/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var View: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        UI()
    }
    
    func UI() {
        View.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        View.layer.cornerRadius = 3.0
        View.layer.masksToBounds = false
        View.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        View.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        View.layer.shadowOpacity = 0.8
        
    }
    func configure(compines: Datum) {
        
        DispatchQueue.main.async {
            if let img = compines.image{
                self.img.setImage(imageUrl: img)
            }
        }
    }
    
    
}
extension UIImageView {
    func setImage(imageUrl: String){
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string:imageUrl), placeholder: nil, options: [.transition(.fade(0.7))],   completionHandler: nil)
    }
}
