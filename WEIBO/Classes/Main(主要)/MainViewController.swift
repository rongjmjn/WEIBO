//
//  MainViewController.swift
//  WEIBO
//
//  Created by FanrongZeng on 2018/3/31.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        //1.获取json文件路径
        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings", ofType: "json") else {
            print("没有获取到json文件的路径")
            return
        }
        
        //2.读取json文件数据
        guard let jsonData = NSData.init(contentsOfFile: jsonPath) else {
            return
        }
        
        guard let result = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
            return
        }
        
        guard let dictArray = result as? [[String : AnyObject]] else {
            return
        }
        
        //3.遍历所有字典
        for dict in dictArray {
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            guard let title = dict["title"] as? String else {
                continue
            }
            guard let imageName = dict["imageName"] as? String else {
                continue
            }
          addChildViewController(childVcName: vcName, title: title, imageName: imageName)
        }
        
    }


    func addChildViewController(childVcName: String, title: String, imageName: String) {
        // 1.获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有获取到命名空间")
            return
        }
        
        // 2.根据字符串获取对应的Class
        guard let AnyClass = NSClassFromString(nameSpace + "." + childVcName) else {
            print("没有创建出来对应的类")
            return
        }
        
        // 3.根据类创建对应的对象
        guard let VCClass = AnyClass as? UIViewController.Type else {
            return
        }
        
        // 4.创建子控制器
        let childVc = VCClass.init()
        
        // 5.设置控制器的属性
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 6.包装一个导航栏控制器
        let childNav = UINavigationController(rootViewController: childVc)
        
        // 7.将控制器添加到MainViewController
        addChildViewController(childNav)
        
    }

}
