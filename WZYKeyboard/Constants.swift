//
//  Constants.swift
//  eHighSpeed
//
//  Created by 王中尧 on 2018/7/6.
//  Copyright © 2018年 SDYSJ. All rights reserved.
//

import UIKit

/// 设备屏幕
let MS_SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
let MS_SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height

/// iPhone X
let MS_IsiPhoneX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!) : false
/// 状态栏和导航栏高度
let MS_StatusBarAndNavigationBarHeight: CGFloat = 44 + UIApplication.shared.statusBarFrame.size.height
/// 状态栏高度
let MS_StatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
/// TabBar 高度
let MS_TabbarH: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49
/// TabBar 间距
let MS_TabbarHMargin: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 34 : 0

/// 自适应横向尺寸
func kSizeWidth(pt: CGFloat) -> CGFloat {
    return (MS_SCREEN_WIDTH / 375) * pt;
}

/// 自适应纵向尺寸
func kSizeHeight(pt: CGFloat) -> CGFloat {
    return (MS_SCREEN_HEIGHT / 667) * pt;
}

/// 加载 UIView 类型的 xib
func loadNib<T>(_ as: T.Type) -> T where T: UIView {
    return Bundle.main.loadNibNamed("\(T.self)", owner: nil, options: nil)?.first as! T
}

/// 加载 UIView 类型的 xib（并设置 frame 参数）
func loadNib<T>(_ as: T.Type, frame: CGRect) -> T where T: UIView {
    let TView = loadNib(`as`)
    TView.frame = frame
    return TView
}

/// 格式化打印 json
///
/// - Parameter data:
func printJson(data: Any) {
    print("转化前 --- \(data)")
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)!
        print("转化后 --- " + "\(json)" + "\n")
    } catch {
        print("出错了！")
    }
}

extension UIColor {
    
    /// 返回一个随机色
    ///
    /// - Parameter alpha: 颜色透明度
    convenience init?(randomColor alpha: CGFloat) {
        self.init(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: alpha)
    }
    
    /// 返回一个 16 进制表示的颜色
    ///
    /// - Parameters:
    ///   - hex: 如 0xFF5A39 
    ///   - alpha: 颜色透明度
    convenience init?(hexColor hex: Int, alpha: CGFloat) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0, green: CGFloat((hex & 0xFF00) >> 8) / 255.0, blue: CGFloat(hex & 0xFF) / 255.0, alpha: alpha)
    }
}

