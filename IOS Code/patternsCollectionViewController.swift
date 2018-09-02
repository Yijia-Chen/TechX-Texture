//
//  patternsCollectionViewController.swift
//  final project
//
//  Created by Ruan Tianyin on 2018/8/4.
//  Copyright © 2018年 Ruan Tianyin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class patternsCollectionViewController: UICollectionViewController, UINavigationControllerDelegate {
    
    var selectedCultures = [UIImage]()
    var categoryVC: categoryViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCultures.count
    }
    
    
    var cultureName: String = ""
    var cultureInfo: String = ""
    var cultureImage1 = UIImage()
    var cultureImage2 = UIImage()
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! CultureImageCell
        cell.myImage.image = selectedCultures[indexPath.row]
        
        cell.myImage.clipToPolygon(corners: 6)
        
        return cell
        
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCultures == Asia.image1{
            print("1")
            cultureName = Asia.names[indexPath.row]
            cultureInfo = Asia.infos[indexPath.row]
            cultureImage1 = Asia.image1[indexPath.row]
        }else if selectedCultures == Europe.images1{
            print("2")
            cultureName = Europe.names[indexPath.row]
            print(cultureName)
            cultureInfo = Europe.infos[indexPath.row]
            cultureImage1 = Europe.images1[indexPath.row]
        }else if selectedCultures == Africa.image1{
            print("3")
            cultureName = Africa.names[indexPath.row]
            cultureInfo = Africa.infos[indexPath.row]
            cultureImage1 = Africa.image1[indexPath.row]
        }else{
            print("4")
            cultureName = DataStorage.names[indexPath.row]
            cultureInfo = DataStorage.infos[indexPath.row]
            cultureImage1 = DataStorage.image1[indexPath.row]
        }

        //cultureImage2 = DataStorage.image2[indexPath.row]
        performSegue(withIdentifier: "toSpecific", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! specificIntroViewController
        destination.cultureName = cultureName
        destination.cultureInfo = cultureInfo
        destination.cultureImage1 = cultureImage1
        destination.cultureImage2 = cultureImage2
        destination.patternsVC = self
    }


}
