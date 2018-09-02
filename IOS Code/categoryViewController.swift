//
//  categoryViewController.swift
//  final project
//
//  Created by Ruan Tianyin on 2018/8/3.
//  Copyright © 2018年 Ruan Tianyin. All rights reserved.
//

import UIKit
import UIDropDown

class categoryViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var Back: UIButton!
    var selectedCultures = [UIImage]()
    
    
    var drop: UIDropDown!
    
//    var collectionView: UICollectionView?
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
//        cell.backgroundColor = .red
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let layout = UICollectionViewFlowLayout()
//        collectionView = UICollectionView(frame: CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: view.frame.height - 100), collectionViewLayout: layout)
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
//        collectionView?.delegate = self
//        collectionView?.dataSource = self
//        self.view.addSubview(collectionView!)
        
        Back.frame = CGRect(x: 24, y: 22, width: 22, height: 27)
        drop = UIDropDown(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        drop.textColor = UIColor.white
        drop.center = CGPoint(x: 250, y: 40)
        drop.placeholder = "All"
        drop.options = ["Asia","Europe","Africa","North America","South America","Antarctica","Australia"]
        drop.didSelect { (option, index) in
            //print("You just select: \(option) at index: \(index)")
            if index == 0{
                self.selectedCultures = Asia.image1
            }else if index == 1{
                self.selectedCultures = Europe.images1
            }else if index == 2{
                self.selectedCultures = Africa.image1
            }else{
                self.selectedCultures = DataStorage.image1
            }
            self.performSegue(withIdentifier: "Try", sender: self)
            
        }
        self.view.addSubview(drop)
        let poem1 = UIImageView()
        let poem2 = UIImageView()
        poem1.image = #imageLiteral(resourceName: "poem1")
        poem2.image = #imageLiteral(resourceName: "poem2")
        poem1.frame = CGRect(x: 69, y: 279, width: 35, height: 279)
        poem2.frame = CGRect(x: 25, y: 388, width: 34.96, height: 279)
        self.view.addSubview(poem1)
        self.view.addSubview(poem2)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! patternsCollectionViewController
        destination.selectedCultures = self.selectedCultures
        destination.categoryVC = self
    }

    
    
    //    @objc func showImg() {
    //        let specific = specificIntroViewController()
    //        self.present(specific, animated: true, completion: nil)
    
    //    }
    
    

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

