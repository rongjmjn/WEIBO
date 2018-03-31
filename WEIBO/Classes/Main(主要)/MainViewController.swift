//
//  MainViewController.swift
//  WEIBO
//
//  Created by FanrongZeng on 2018/3/31.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    // MARK:- 懒加载属性
    private lazy var imageNames:[String] = ["tabbar_home", "tabbar_message_center", "", "tabbar_discover", "tabbar_profile"];
    private lazy var composeBtn: UIButton = UIButton()
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addComposeBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //调整tabBar
        adjustItem()
        
    }
    
}


// MARK:- 类扩展

/** 设置UI */
extension MainViewController{
    
    /** 调整tabBar */
    private func adjustItem() {
        
        for i in 0..<tabBar.items!.count{
            //1.取出item
            let item = tabBar.items![i]
            
            //2.判断下标是不是2,若是,不予交互
            if i == 2 {
                item.isEnabled = false
                continue
            }
            
            //3.设置item选中状态的图片
            item.selectedImage = UIImage.init(named: imageNames[i] + "_highlighted")
        }
    }
    
   ///添加发布按钮
    private func addComposeBtn(){
        //1添加按钮到tabBar中
        tabBar.addSubview(composeBtn)
        
        //2.设置发布按钮的内容
        composeBtn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: .normal)
        
        composeBtn.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        
        composeBtn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: .normal)
        
        composeBtn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        
        //自适应尺寸
        composeBtn.sizeToFit()
        
        //3.设置位置
        composeBtn.center = CGPoint(x: tabBar.bounds.width * 0.5, y: tabBar.bounds.height * 0.5)
        
        //4.监听点击
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), for: .touchUpInside)
        
    }
    
}


/** 监听点击 */
extension MainViewController{
    
    @objc private func composeBtnClick() {
        print("点击了发布按钮")
    }
    
}

