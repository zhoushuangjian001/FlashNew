//
//  BaseViewController.swift
//  FlashNew
//
//  Created by 周双建 on 2019/5/26.
//  Copyright © 2019 周双建. All rights reserved.
//

import UIKit
import Masonry

let LOADINGKEY:UnsafeRawPointer = UnsafeRawPointer.init(bitPattern: "com.loading.key".hashValue)!

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}


// MARK: -- loading view
extension BaseViewController {
    
    // TODO: -- show loading view
    func showLoading(){
        
        // -- judg exists loading view
        if objc_getAssociatedObject(self, LOADINGKEY) != nil {return}
        
        // -- main view
        let baseView = UIApplication.shared.delegate!.window!!
        // -- cover viewself
        let coverView = UIView.init()
        // -- set background color
        coverView.backgroundColor = UIColor.red
        // -- set mark key
        objc_setAssociatedObject(self, LOADINGKEY, coverView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        // -- add view
        baseView.addSubview(coverView)
        baseView.bringSubviewToFront(coverView)
        // -- cover view layout
        coverView.mas_makeConstraints { make in
            make?.edges.equalTo()(baseView)
        }
        
        // -- show view
        let showView = UIView.init()
        // -- set view
        showView.layer.masksToBounds = true
        showView.layer.cornerRadius = 6
        showView.backgroundColor = UIColor.white
        // -- add view
        coverView.addSubview(showView)
        // -- layout view
        showView.mas_makeConstraints { (make) in
            make?.centerX.equalTo()(coverView)
            make?.centerY.equalTo()(coverView)?.offset()(-10)
            make?.width.mas_lessThanOrEqualTo()(coverView.mas_width)?.multipliedBy()(0.618)
        }
        
        // -- add elements
        let activityIndicator = UIActivityIndicatorView.init()
        activityIndicator.style = .gray
        activityIndicator.startAnimating()
        showView.addSubview(activityIndicator)
        // -- layout
        activityIndicator.mas_makeConstraints { (make) in
            make?.top.equalTo()(showView)?.offset()(15)
            make?.centerX.equalTo()(showView)
            make?.size.mas_equalTo()(CGSize.init(width: 70, height: 70))
        }
        
        let titleLable = UILabel.init()
        titleLable.textColor = UIColor.black
        titleLable.textAlignment = .center
        titleLable.numberOfLines = 0
        titleLable.text = "请啥风格发放噶福咖妃噶覆盖覅盼"
        showView.addSubview(titleLable)
        // -- layout
        titleLable.mas_makeConstraints { (make) in
            make?.top.equalTo()(activityIndicator.mas_bottom)?.offset()(20)
            make?.bottom.equalTo()(showView)?.offset()(-15)
            make?.left.equalTo()(showView)?.offset()(15)
            make?.right.equalTo()(showView)?.offset()(-15)
        }
    }
    
    //TODO: -- remove loading view
    func removeLoading() {

        var tempObj = objc_getAssociatedObject(self, LOADINGKEY) as? UIView
        if tempObj != nil {
            tempObj?.removeFromSuperview()
            tempObj = nil
            objc_removeAssociatedObjects(self)
        }
    }
}



