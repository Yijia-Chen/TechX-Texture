//
//  specificIntroViewController.swift
//  final project
//
//  Created by Ruan Tianyin on 2018/8/3.
//  Copyright © 2018年 Ruan Tianyin. All rights reserved.
//

import UIKit

class specificIntroViewController: UIViewController, UINavigationControllerDelegate {

    var patternsVC: patternsCollectionViewController?
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: {() in
            self.patternsVC?.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBOutlet weak var Background: UIImageView!
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var CultureImage: UIImageView!
    
    @IBOutlet weak var CultureName: UILabel!
    
    
    @IBOutlet weak var SpecificInfo: UILabel!
    
    var cultureName: String?
    var cultureInfo: String?
    var cultureImage1 = UIImage()
    var cultureImage2 = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Background.image = #imageLiteral(resourceName: "背景")
        Background.alpha = 0.7
        BackButton.frame = CGRect(x: 24, y: 22, width: 22, height: 27)
        CultureImage.frame = CGRect(x: 87, y: 46, width: 201.78, height: 233)
        CultureImage.clipToPolygon(corners: 6)
        //CultureImage.backgroundColor = UIColor.black
        CultureImage.image = cultureImage1
        CultureName.frame = CGRect(x: 100, y: 315, width: 180, height: 33)
        CultureName.text = cultureName
        SpecificInfo.text = cultureInfo
        SpecificInfo.frame = CGRect(x: 47, y: 387, width: 303, height: 233)
        
        CultureName.numberOfLines = 0
        SpecificInfo.numberOfLines = 0 
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
