//
//  ViewController3.swift
//  fzx的日记ios版
//
//  Created by Lord TARN1SHED on 2023/11/1.
//

import UIKit
import Foundation

class ViewController3: UIViewController {
    @IBOutlet var myView3: UIView!
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var increasing = true
    var timer: Timer?
    
    @IBOutlet weak var hui: UILabel!
    
    @IBOutlet weak var du: UILabel!
    
    
    @IBOutlet var colorButtons: [UIButton]!
    var isDayMode: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateColor), userInfo: nil, repeats: true)
        
        if(isDayMode==false){
            UIView.transition(with: myView3, duration: 1, options: .transitionCrossDissolve, animations: {
                self.myView3.backgroundColor = UIColor.gray
            }, completion: nil)
        }else{
            UIView.transition(with: myView3, duration: 1, options: .transitionCrossDissolve, animations: {
                self.myView3.backgroundColor = UIColor.white
            }, completion: nil)
        }
        // 为每个按钮添加点击事件处理方法
        for button in colorButtons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
        
    var inc: Bool = true

    @objc func buttonTapped(_ sender: UIButton) {
        // 获取按钮当前的 tintColor
        guard let currentColor = sender.tintColor else { return }

        // 从当前颜色中提取 RGB 组件
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        currentColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        blue=red
        green=red

        // 增加 RGB 值
        
        if(red==1&&green==1&&blue==1&&inc==true){
            inc=false
        }
        if(red==0&&green==0&&blue==0&&inc==false){
            inc=true
        }
        if(inc){
            red += 0.04
            green += 0.04
            blue += 0.04
        }else{
            red -= 0.04
            green -= 0.04
            blue -= 0.04
        }
        
        red = round(red * 100) / 100.0
        green = round(green * 100) / 100.0
        blue = round(blue * 100) / 100.0
        
        if(red>1){red=1}
        if(green>1){green=1}
        if(blue>1){blue=1}
        if(red<0){red=0}
        if(green<0){green=0}
        if(blue<0){blue=0}
        
        print(red,green,blue)
        // 创建新的颜色
        let newColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)

        // 更新按钮的 tintColor
        sender.tintColor = newColor
        if(colorButtons[0].tintColor==colorButtons[1].tintColor&&colorButtons[1].tintColor==colorButtons[2].tintColor&&colorButtons[2].tintColor==colorButtons[3].tintColor&&colorButtons[3].tintColor==colorButtons[4].tintColor&&colorButtons[4].tintColor==colorButtons[5].tintColor&&colorButtons[5].tintColor==colorButtons[6].tintColor&&colorButtons[6].tintColor==colorButtons[7].tintColor&&colorButtons[7].tintColor==colorButtons[8].tintColor){
            if let redComponent = colorButtons[0].tintColor.cgColor.components?[0] {
                if redComponent > 0.9 {
                    UIView.transition(with: LabelGood, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.LabelGood.text="white"
                    }, completion: nil)
                }
                else if redComponent < 0.1 {
                    UIView.transition(with: LabelGood, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.LabelGood.text="black"
                    }, completion: nil)
                }
                else if (redComponent <= 0.65 && redComponent >= 0.35) {
                    UIView.transition(with: LabelGood, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.LabelGood.text="gray"
                    }, completion: nil)
                }
                else if (redComponent <= 0.9 && redComponent > 0.65) {
                    UIView.transition(with: LabelGood, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.LabelGood.text="light gray"
                    }, completion: nil)
                }
                else {
                    UIView.transition(with: LabelGood, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.LabelGood.text="dark gray"
                    }, completion: nil)
                }
            }
            
            
            
            
        }else{
            UIView.transition(with: LabelGood, duration: 1, options: .transitionCrossDissolve, animations: {
                self.LabelGood.text=""
            }, completion: nil)
        }
    }

    @IBOutlet weak var LabelGood: UILabel!
    
    @objc func updateColor() {
            // 逐渐增加或减小red值
            if increasing {
                red += 0.02
                green += 0.02
                blue += 0.02
                if red >= 1.0 {
                    red = 1.0
                    increasing = false
                }
            } else {
                red -= 0.02
                green -= 0.02
                blue -= 0.02
                if red <= 0.0 {
                    red = 0.0
                    increasing = true
                }
            }

            // 设置文本标签的颜色
            hui.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            du.textColor = UIColor(red: 1-red, green: 1-green, blue: 1-blue, alpha: 1.0)
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
