//
//  WZYKeyBoard.swift
//  eHighSpeed
//
//  Created by 王中尧 on 2018/11/1.
//  Copyright © 2018年 SDGS. All rights reserved.
//

import UIKit

class WZYKeyBoard: UIView {
    
    /// 底部评论条
    var commentBGView: UIView!
    /// commentBGView 的 tf
    var tf: UITextField!
    
    /// placeholder 文字
    var placeholderAttrStr = NSAttributedString()
    /// normal 文字
    var normalAttr = [String:Any]()
    
    /// 发送按钮点击 block
    var sendBlock: ((String) -> Void)?
    /// 键盘弹起 block 返回 弹起高度+弹起时间
    var keyboardWillShowBlock: ((CGFloat, TimeInterval) -> Void)?
    /// 键盘落下 block 返回下降时间
    var keyboardWillHiddenBlock: ((TimeInterval) -> Void)?

    init(frame: CGRect, placeholderAttrStr: NSAttributedString, normalAttr: [String:Any]) {
        super.init(frame: frame)
        
        self.placeholderAttrStr = placeholderAttrStr
        self.normalAttr = normalAttr
        
        addKeyboradNoti()
        configUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - keyborad
    /// 添加键盘监听
    func addKeyboradNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notif:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /// 键盘弹起
    ///
    /// - Parameter notif: <#notif description#>
    @objc func keyboardWillShow(notif: NSNotification){
        let userInfo:NSDictionary = notif.userInfo! as NSDictionary;
        let keyBoardInfo2: AnyObject? = userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as AnyObject?;
        let endY = keyBoardInfo2?.cgRectValue.size.height // 键盘弹出的高度
        let aTime = userInfo.object(forKey: UIKeyboardAnimationDurationUserInfoKey) as! TimeInterval // 键盘弹起的时间
        
        /// 键盘微调间距
        var keyboardMargin = CGFloat(0)
        switch MS_SCREEN_WIDTH {
        case 320:
            keyboardMargin = -2
            break
        case 375:
            keyboardMargin = 0
            break
        case 414:
            keyboardMargin = 0
            break
        default:
            break
        }
        
        if let block = keyboardWillShowBlock {
            block(-(endY! - MS_TabbarHMargin + keyboardMargin), aTime)
        }
    }
    
    @objc func keyboardWillHidden(noti: NSNotification){
        let userInfo:NSDictionary = noti.userInfo! as NSDictionary;
        let aTime = userInfo.object(forKey: UIKeyboardAnimationDurationUserInfoKey) as! TimeInterval
        if let block = keyboardWillHiddenBlock {
            block(aTime)
        }
        // 移除通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // MARK: - UI
    func configUI() {
        // 底部评论条
        commentBGView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        addSubview(commentBGView)
        commentBGView.backgroundColor = UIColor.white
        //        commentBGView.backgroundColor = UIColor(hexColor: 0xff5a39, alpha: 0.3)
        
        let sendBtnW = CGFloat(75)
        let margin = CGFloat(15)
        let tf_h = height - MS_TabbarHMargin
        tf = UITextField(frame: CGRect(x: margin, y: 0, width: commentBGView.width - sendBtnW - margin * 2, height: tf_h))
        commentBGView.addSubview(tf)
        tf.clearsOnBeginEditing = false
        tf.clearButtonMode = .whileEditing;
        tf.textAlignment = .left
        tf.keyboardType = .default
        tf.attributedPlaceholder = placeholderAttrStr
        tf.returnKeyType = .default
        tf.textColor = UIColor(hexColor: 0x999999, alpha: 1)!
        tf.defaultTextAttributes = normalAttr
        
        let middleLine = UIView(frame: CGRect(x: commentBGView.width - sendBtnW - 1, y: 10, width: 1, height: commentBGView.height - MS_TabbarHMargin - 10 * 2))
        commentBGView.addSubview(middleLine)
        middleLine.centerY = tf.centerY
        middleLine.backgroundColor = UIColor(hexColor: 0xE6E6E6, alpha: 1)
        
        let sendBtn = UIButton(frame: CGRect(x: middleLine.frame.maxX, y: 0, width: sendBtnW, height: tf.height))
        commentBGView.addSubview(sendBtn)
        sendBtn.setImage(UIImage(named: "发送"), for: .normal)
        sendBtn.setImage(UIImage(named: "发送"), for: .selected)
        sendBtn.addTarget(self, action: #selector(sendComment(btn:)), for: .touchUpInside)
        sendBtn.centerY = tf.centerY
        
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: commentBGView.width, height: 1))
        commentBGView.addSubview(topLine)
        topLine.backgroundColor = UIColor(hexColor: 0xE6E6E6, alpha: 1)
        
        let bottomLine = UIView(frame: CGRect(x: 0, y: commentBGView.height - MS_TabbarHMargin - 1, width: commentBGView.width, height: 1))
        commentBGView.addSubview(bottomLine)
        bottomLine.backgroundColor = UIColor(hexColor: 0xE6E6E6, alpha: 1)
    }
    
    /// 发送评论
    @objc func sendComment(btn: UIButton) {
        print("----- send 发送私信 -----")
        // 防止暴力点击
        btn.isUserInteractionEnabled = false
        
        let delay = DispatchTime.now() + DispatchTimeInterval.milliseconds(1500) // 1500 毫秒
        DispatchQueue.main.asyncAfter(deadline: delay) {
            btn.isUserInteractionEnabled = true
        }
//        print("tf.text --- \(tf.text)")
        if let block = self.sendBlock, let text = tf.text, text.count > 0 {
            block(text)
        }
        tf.text = ""
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
