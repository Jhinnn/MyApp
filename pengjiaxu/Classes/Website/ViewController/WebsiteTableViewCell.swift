//
//  WebsiteTableViewCell.swift
//  pengjiaxu
//
//  Created by Arthur on 2017/9/21.
//  Copyright © 2017年 Arthur. All rights reserved.
//

import UIKit


protocol PushWebsiteDelegate {
    func pushAction(url: String)
}

class WebsiteTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var delegate: PushWebsiteDelegate?
    

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var titlesArray:[String] = []
    var urlsArray:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置collectionView的代理
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // 注册CollectionViewCell
        self.collectionView!.register(UINib(nibName:"WebsiteCollectionViewCell", bundle:nil),
                                      forCellWithReuseIdentifier: "myCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (KScreenWidth - 16 - 20) / 3,height: 35)
        //列间距,行间距,偏移
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        self.collectionView.collectionViewLayout = layout
            
    }
    
    //加载数据
    func reloadData(title:String, titlesArray:[String], urlsArray:[String]) {
        //设置标题
        self.headImageView.image = UIImage(named: title)
        //保存图片数据
        self.titlesArray = titlesArray
        
        self.urlsArray = urlsArray
        
        //collectionView重新加载数据
        self.collectionView.reloadData()
        
        //更新collectionView的高度约束
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        collectionViewHeight.constant = contentSize.height
    }
    
    
    
    //返回collectionView的单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return titlesArray.count
    }
    
    //返回对应的单元格
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell",
                                                       for: indexPath) as! WebsiteCollectionViewCell
        cell.contentLabel.text = titlesArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = urlsArray[indexPath.item] 
    
        self.delegate?.pushAction(url: url)
    
    }
    
    //绘制单元格底部横线
    override func draw(_ rect: CGRect) {
        //线宽
        let lineWidth = 1 / UIScreen.main.scale
        //线偏移量
        let lineAdjustOffset = 1 / UIScreen.main.scale / 2
        //线条颜色
        let lineColor = UIColor(red: 0xe0/255, green: 0xe0/255, blue: 0xe0/255, alpha: 1)
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //创建一个矩形，它的所有边都内缩固定的偏移量
        let drawingRect = self.bounds.insetBy(dx: lineAdjustOffset, dy: lineAdjustOffset)
        
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x: drawingRect.minX, y: drawingRect.maxY))
        path.addLine(to: CGPoint(x: drawingRect.maxX, y: drawingRect.maxY))
        
        //添加路径到图形上下文
        context.addPath(path)
        
        //设置笔触颜色
        context.setStrokeColor(lineColor.cgColor)
        //设置笔触宽度
        context.setLineWidth(lineWidth)
        
        //绘制路径
        context.strokePath()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
