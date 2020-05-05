//
//  DetailsVC.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/5/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var ttle: UILabel!
    
    var delegate: DelegateItemSelected?

    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.layer.cornerRadius = 30
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let item = delegate {
            self.ttle.text = item.name
            self.img.setImage(imageUrl: (delegate?.image!)!)
        }
    }
   
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
}
