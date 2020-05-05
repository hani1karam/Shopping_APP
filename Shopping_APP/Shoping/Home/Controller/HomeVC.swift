//
//  HomeVC.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
protocol DelegateItemSelected {
    var name: String? {get set}
    var image: String? {get set}
    
}
class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,DelegateItemSelected {
    
    static func instance () -> HomeVC {
        let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
    }
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var pagecontroller: UIPageControl!
    @IBOutlet weak var HomeTV: UITableView!
    
    
    var imgarray = ["https://mercatoadmin.xyz/PROJECT1/ecommerce/images/Banner/1.png",
                    "https://mercatoadmin.xyz/PROJECT1/ecommerce/images/Banner/2.png",
                    "https://mercatoadmin.xyz/PROJECT1/ecommerce/images/Banner/3.png"] as [String]
    var timer = Timer()
    var counter = 0
    var items = [Datum]()
    var name: String?
    var image: String?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCompained()
        collection.delegate = self
        collection.dataSource = self
        HomeTV.delegate = self
        HomeTV.dataSource = self
        pagecontroller.numberOfPages = imgarray.count
        pagecontroller.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Deatils = segue.destination as! DetailsVC
        
        Deatils.delegate = self
        Deatils.delegate?.name = items[index].title
        Deatils.delegate?.image =  items[index].image!
        
    }
    
    @objc func changeImage() {
        
        if counter < imgarray.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pagecontroller.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pagecontroller.currentPage = counter
            counter = 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgarray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.loadImageUsingCache(withUrl: "\(imgarray[indexPath.row])")
            
        }
        return cell
        
    }
    
    fileprivate func startAnimation() {
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .black, padding: 0)
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 2){
            loading.stopAnimating()
        }
    }
    
    func loadCompained(){
        startAnimation()
        NetworkApi.sendRequest(method: .get, url: "https://salemsaber.com/websites/dabberha_dynamic/api/ar/EGP/allCategories", completion:
            
            {(err,response: Compines?) in
                
                if err == nil{
                    guard let data = response?.data else{return}
                    self.items = data.self
                    self.HomeTV.reloadData()
                    
                }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Home = HomeTV.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        Home.name.text = items[indexPath.row].title
        Home.configure(compines: self.items[indexPath.row])
        
        return Home
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Home", sender: self)
        
    }
    
}
let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
    
}
extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
    
    
}




