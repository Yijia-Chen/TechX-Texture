//
//  ViewController.swift
//  final project
//
//  Created by Ruan Tianyin on 2018/8/2.
//  Copyright © 2018年 Ruan Tianyin. All rights reserved.
//

import UIKit
import Fusuma
import Alamofire

class firstViewController: UIViewController, FusumaDelegate, UINavigationControllerDelegate {
    
    var responseCultureName: String = ""
    
    func prepare(for segue: UIStoryboardSegue, sender: firstViewController) {
        let destination = segue.destination as! resultViewController
        destination.fetchedCultureName = self.responseCultureName
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        let data = UIImageJPEGRepresentation(image, 1)
        uploadImage(imageData: data!)
    }
    
    //上传图片到服务器
    func uploadImage(imageData : Data){
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                // 参数解释：
                //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
                //如果需要上传多个文件,就多添加几个
                //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //......
                
        },to: "http://geeekvr.com:28179/predict", encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    if let jsonValue: Dictionary<String, String> = response.result.value! as? Dictionary<String, String> {
                        self.responseCultureName = String(describing: jsonValue["result"]!)
                        self.performSegue(withIdentifier: "showResult", sender: self)
                        
                    }
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                //打印连接失败原因
                print(encodingError)
            }
        })
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let cameraView = FusumaViewController()
        cameraView.delegate = self
        cameraView.cropHeightRatio = 1.0
        present(cameraView, animated: true, completion: nil)
    }
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var category: UIButton!
    
    @IBOutlet weak var setting: UIButton!
    
    @IBOutlet weak var dailyImage: UIImageView!
    
    @IBOutlet weak var cultureName: UILabel!
    

    @IBOutlet weak var camera: UIButton!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        background.image = #imageLiteral(resourceName: "背景")
        background.alpha = 0.7
        category.setImage(#imageLiteral(resourceName: "Category"), for: .normal)
        category.frame = CGRect(x: 18, y: 16, width: 32, height: 28.8)
        setting.setImage(#imageLiteral(resourceName: "Setting"), for: .normal)
        setting.frame = CGRect(x: 323, y: 12, width: 36, height: 37.2)
        cultureName.text = "Culture Name Here"
        cultureName.frame = CGRect(x: 65, y: 443, width: 247, height: 29)
        camera.setImage(#imageLiteral(resourceName: "Camera"), for: .normal)
        camera.frame = CGRect(x: 163, y: 571, width: 50, height: 40.98
        )
        
        let randomNum = Int(arc4random_uniform(10))
    
        dailyImage.image = DataStorage.image1[randomNum]
        dailyImage.frame = CGRect(x: 57, y: 100, width: 264.41, height: 303)
        dailyImage.clipToPolygon(corners: 6)
        
        cultureName.text = DataStorage.names[randomNum]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

