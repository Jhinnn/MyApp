//
//  YMTabBarController.swift
//  DanTang
//
//  Created by 杨蒙 on 2017/3/24.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

class PJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = kGlobalColor
        addChildViewControllers()
    }
    
    /**
     * 添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController(childController: WebsiteViewController(), title: "网站", imageName: "网站")
        addChildViewController(childController: NotesViewController(), title: "笔记", imageName: "笔记")
        addChildViewController(childController: ReadingViewController(), title: "阅读", imageName: "阅读")
        addChildViewController(childController: MineViewController(), title: "视频", imageName: "视频")
    }
    
    /**
     # 初始化子控制器
     
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        childController.title = title
        let navC = PJNavigationController(rootViewController: childController)
        addChildViewController(navC)
    }
}
