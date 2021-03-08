//
//  Global.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/6.
//

import Foundation
import MBProgressHUD

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//MARK: 提示HUD
func showTipStr(info:String) {
    guard let vc = topVC else { return }
    let hud = MBProgressHUD.showAdded(to: vc.view, animated: true)
    hud.mode = MBProgressHUDMode.text
    hud.label.text = info
    hud.hide(animated: true, afterDelay: 0.8)
}
