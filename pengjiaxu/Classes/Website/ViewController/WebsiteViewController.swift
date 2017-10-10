//
//  WebsiteViewController.swift
//  pengjiaxu
//
//  Created by Arthur on 2017/9/21.
//  Copyright © 2017年 Arthur. All rights reserved.
//

import UIKit


struct WebsiteSet {
    var imageName: String
    var websiteTitles: [String]
    var websiteUrls: [String]
}

class WebsiteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,PushWebsiteDelegate {
    
    var tableView: UITableView!
    
    let websites = [
        
        WebsiteSet(imageName: "baidu_logo", websiteTitles: ["百度知道","百度百科","百度贴吧","百度图片","百度音乐","百度视频"], websiteUrls: ["https://www.baidu.com","https://baike.baidu.com","https://tieba.baidu.com/index.html","http://image.baidu.com","http://music.baidu.com","http://v.baidu.com"]),
        
         WebsiteSet(imageName: "youku_logo", websiteTitles: ["优酷","腾讯视频","爱奇艺","搜狐视频","暴风影音","4K屋"], websiteUrls: ["http://www.youku.com","https://v.qq.com","https://www.iqiyi.com","http://tv.sohu.com","http://www.baofeng.com","http://www.kkkkwu.com"]),
         
//         WebsiteSet(imageName: "wangyiyun_logo", websiteTitles: ["网易云","QQ音乐","酷狗","虾米音乐","酷我","咪咕音乐"], websiteUrls: ["http://music.163.com","http://y.qq.com","http://www.kugou.com","http://www.xiami.com","http://www.kuwo.cn","http://music.migu.cn"]),
         
         WebsiteSet(imageName: "jingdong_logo", websiteTitles: ["京东","淘宝","天猫"], websiteUrls: ["https://www.jd.com","https://www.taobao.com","https://www.tmall.com"]),
        
        WebsiteSet(imageName: "zhihu_logo", websiteTitles: ["知乎首页","知乎话题","知乎发现"], websiteUrls: ["https://www.zhihu.com","https://www.zhihu.com/topic","https://www.zhihu.com/explore"]),

    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "网站导航"
        view.backgroundColor = UIColor.white
        
        setupTableView()
        
    }
    
    
    func setupTableView() {
    
        tableView = UITableView(frame:CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight - 64), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "WebsiteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WebsiteTableViewCell
        //下面这两个语句一定要添加，否则第一屏显示的collection view尺寸，以及里面的单元格位置会不正确
        cell.selectionStyle = .none
        cell.delegate = self
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        
        //重新加载单元格数据
        cell.reloadData(title:websites[indexPath.row].imageName,
                        titlesArray: websites[indexPath.row].websiteTitles, urlsArray: websites[indexPath.row].websiteUrls)

        return cell
        
    }
    
    
    func pushAction(url: String) {
        let webView: WKWebViewController = WKWebViewController()
        webView.load_UrlSting(string: url)
        navigationController?.pushViewController(webView, animated: true)
    
    }
    
}
