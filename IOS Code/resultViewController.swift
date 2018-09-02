//
//  resultViewController.swift
//  final project
//
//  Created by Ruan Tianyin on 2018/8/3.
//  Copyright © 2018年 Ruan Tianyin. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {
    
    @IBOutlet weak var standard2: UIImageView!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var Background: UIImageView!
    
    @IBOutlet weak var Picture: UIImageView!
    
    @IBOutlet weak var Standard: UIImageView!
    
    @IBOutlet weak var CultureName: UILabel!
    
    @IBOutlet weak var Info: UILabel!
    
    var fetchedCultureName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Background.image = #imageLiteral(resourceName: "背景")
        Background.alpha = 0.7
        Standard.clipToPolygon(corners: 6)
        Standard.image = #imageLiteral(resourceName: "Image default")
        //Standard.frame = CGRect(x: 223, y: 130, width: 131.64, height: 152)
        //standard2.frame = CGRect(x: 161, y: 29, width: 123.84, height: 143)
        standard2.clipToPolygon(corners: 6)
        //CultureImage.backgroundColor = UIColor.black
        standard2.image = #imageLiteral(resourceName: "default2")
        Picture.clipToPolygon(corners: 6)
        Picture.image = #imageLiteral(resourceName: "Seigaiha")
        Picture.frame = CGRect(x: 20, y: 117, width: 218, height: 218)
        BackButton.frame = CGRect(x: 24, y: 22, width: 22, height: 27)
        CultureName.frame = CGRect(x: 47, y: 387, width: 303, height: 233)
        CultureName.text = fetchedCultureName
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
