//
//  ViewController.swift
//  fzx的日记ios版
//
//  Created by Lord TARN1SHED on 2023/10/30.
//

import UIKit
import Foundation
import WebKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    var diary: [String] = ["", "",  "", "", ""]
    var word: [String] = ["","", "", "", ""]
    
    @IBOutlet weak var label: UITextField!
    @IBOutlet weak var tomorrowword: UITextField!
    @IBOutlet weak var yesterdayword: UILabel!
    
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    
    @IBOutlet weak var webView2: WKWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!

    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myView: UIView!
    
    var isDayMode = true
    var day:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.layer.cornerRadius = 5 // 设置圆角半径，可以根据需要调整
        label.layer.masksToBounds = true // 使边界超出的内容被裁剪
        
        // 初始设置为白天模式
        setDayMode()

        // 添加按钮点击事件处理方法
        myButton.addTarget(self, action: #selector(buttonTapped7), for: .touchUpInside)
        
        // 这里可以读取 UISlider 的值
        let sliderValue = slider.value
        print("Slider Value: \(sliderValue)")
        
        // 创建一个 URL 对象，指定您要加载的网页
        if let url = URL(string: "https://top.baidu.com/board") {
            // 创建一个 URLRequest 对象，用于加载 URL
            let request = URLRequest(url: url)
            
            // 在 WKWebView 中加载网页
            webView.load(request)
        }
        
        if let url = URL(string: "https://bing.xinac.net/") {
            // 创建一个 URLRequest 对象，用于加载 URL
            let request = URLRequest(url: url)
            
            // 在 WKWebView 中加载网页
            webView2.load(request)
        }
        
        b1.tintColor = UIColor.systemGray
        b2.tintColor = UIColor.systemGray2
        b3.tintColor = UIColor.systemGray3
        b4.tintColor = UIColor.systemGray4
        b5.tintColor = UIColor.systemGray5
        b1.addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
        b2.addTarget(self, action: #selector(buttonTapped2), for: .touchUpInside)
        b3.addTarget(self, action: #selector(buttonTapped3), for: .touchUpInside)
        b4.addTarget(self, action: #selector(buttonTapped4), for: .touchUpInside)
        b5.addTarget(self, action: #selector(buttonTapped5), for: .touchUpInside)
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 可以根据需要选择日期格式
        let dateString = dateFormatter.string(from: currentDate)
        UIView.transition(with: date, duration: 1, options: .transitionCrossDissolve, animations: {
            self.date.text=dateString
        }, completion: nil)
        print("今日日期: \(dateString)")
        
        day=2;
        label.text=diary[2]
        tomorrowword.text=word[2]
        yesterdayword.text=word[1]
        
        UIView.transition(with: b3, duration: 1, options: .transitionCrossDissolve, animations: {
            self.b1.tintColor = UIColor.systemGray
            self.b2.tintColor = UIColor.systemGray2
            self.b3.tintColor = UIColor.systemBlue
            self.b4.tintColor = UIColor.systemGray4
            self.b5.tintColor = UIColor.systemGray5
        }, completion: nil)
    }
    
    @objc func buttonTapped7() {
           if isDayMode {
               // 切换到夜晚模式
               setNightMode()
           } else {
               // 切换到白天模式
               setDayMode()
           }

           // 切换按钮图像
           toggleButtonImage()

           // 切换模式标志
           isDayMode = !isDayMode
       }
    
    
    func setDayMode() {
        UIView.transition(with: myView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.myView.backgroundColor = UIColor.white
        }, completion: nil)

        UIView.transition(with: myButton, duration: 1, options: .transitionCrossDissolve, animations: {
            self.myButton.setImage(UIImage(systemName: "sunrise.circle.fill"), for: .normal)
        }, completion: nil)

        UIView.transition(with: searchBar, duration: 1, options: .transitionCrossDissolve, animations: {
            self.searchBar.barTintColor = UIColor.white
        }, completion: nil)

    }


    func setNightMode() {
        UIView.transition(with: myView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.myView.backgroundColor = UIColor.gray
        }, completion: nil)

        UIView.transition(with: myButton, duration: 1, options: .transitionCrossDissolve, animations: {
            self.myButton.setImage(UIImage(systemName: "sunset.circle"), for: .normal)
        }, completion: nil)

        UIView.transition(with: searchBar, duration: 1, options: .transitionCrossDissolve, animations: {
            self.searchBar.barTintColor = UIColor.gray
        }, completion: nil)
    }


    func toggleButtonImage() {
        if isDayMode {
            myButton.setImage(UIImage(systemName: "sunset.circle"), for: .normal)
        } else {
            myButton.setImage(UIImage(systemName: "sunrise.circle.fill"), for: .normal)
        }
    }
    
    @objc func buttonTapped1() {
        // 更改按钮的 tintColor
        UIView.transition(with: b1, duration: 1, options: .transitionCrossDissolve, animations: {
            self.b1.tintColor = UIColor.systemBlue
            self.b2.tintColor = UIColor.systemGray2
            self.b3.tintColor = UIColor.systemGray3
            self.b4.tintColor = UIColor.systemGray4
            self.b5.tintColor = UIColor.systemGray5
        }, completion: nil)
        
    }
    @objc func buttonTapped2() {
            // 更改按钮的 tintColor
        UIView.transition(with: b2, duration: 1, options: .transitionCrossDissolve, animations: {
            self.b1.tintColor = UIColor.systemGray
            self.b2.tintColor = UIColor.systemBlue
            self.b3.tintColor = UIColor.systemGray3
            self.b4.tintColor = UIColor.systemGray4
            self.b5.tintColor = UIColor.systemGray5
        }, completion: nil)
    }
    @objc func buttonTapped3() {
            // 更改按钮的 tintColor
        UIView.transition(with: b3, duration: 1, options: .transitionCrossDissolve, animations: {
            self.b1.tintColor = UIColor.systemGray
            self.b2.tintColor = UIColor.systemGray2
            self.b3.tintColor = UIColor.systemBlue
            self.b4.tintColor = UIColor.systemGray4
            self.b5.tintColor = UIColor.systemGray5
        }, completion: nil)
    }
    @objc func buttonTapped4() {
            // 更改按钮的 tintColor
        UIView.transition(with: b4, duration: 1, options: .transitionCrossDissolve, animations: {
            self.b1.tintColor = UIColor.systemGray
            self.b2.tintColor = UIColor.systemGray2
            self.b3.tintColor = UIColor.systemGray3
            self.b4.tintColor = UIColor.systemBlue
            self.b5.tintColor = UIColor.systemGray5
        }, completion: nil)
    }
    @objc func buttonTapped5() {
            // 更改按钮的 tintColor
        UIView.transition(with: b5, duration: 1, options: .transitionCrossDissolve, animations: {
            self.b1.tintColor = UIColor.systemGray
            self.b2.tintColor = UIColor.systemGray2
            self.b3.tintColor = UIColor.systemGray3
            self.b4.tintColor = UIColor.systemGray4
            self.b5.tintColor = UIColor.systemBlue
        }, completion: nil)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let searchText = searchBar.text {
                let encodedQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if let searchURL = URL(string: "https://www.baidu.com/s?wd=\(encodedQuery ?? "")") {
                    let request = URLRequest(url: searchURL)
                    webView.load(request)
                }
            }
            searchBar.resignFirstResponder()
        }

    
    @IBOutlet weak var slider: UISlider!

    

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let sliderValue = Int(sender.value*100)
        print("Slider Value: \(sliderValue)")
        displayrating.text=String(sliderValue)
    }
    
    @IBAction func yiwang(_ sender: Any) {
        // 获取当前日期
        let currentDate = Date()

        // 创建一个 Calendar 实例
        let calendar = Calendar.current

        // 创建一个 DateComponents 实例来表示要添加的日期
        var dateComponents = DateComponents()
        dateComponents.day = -2  // 在当前日期上减去一天

        // 使用 Calendar 进行日期运算
        if let yesterday = calendar.date(byAdding: dateComponents, to: currentDate) {
            // 创建 DateFormatter 以将日期格式化为字符串
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"  // 根据需要选择日期格式

            // 将日期转换为字符串
            let yesterdayString = dateFormatter.string(from: yesterday)
            UIView.transition(with: date, duration: 1, options: .transitionCrossDissolve, animations: {
                self.date.text=yesterdayString
            }, completion: nil)

            print("以往日期: \(yesterdayString)")
        } else {
            print("无法计算以往日期")
        }
        
        day=0;
        UIView.transition(with: label, duration: 1, options: .transitionCrossDissolve, animations: {
            self.label.text=self.diary[0]
        }, completion: nil)
        UIView.transition(with: tomorrowword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.tomorrowword.text=self.word[0]
        }, completion: nil)
        UIView.transition(with: yesterdayword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.yesterdayword.text="无"
        }, completion: nil)
        
    }
    @IBAction func yesterday(_ sender: Any) {

        // 获取当前日期
        let currentDate = Date()

        // 创建一个 Calendar 实例
        let calendar = Calendar.current

        // 创建一个 DateComponents 实例来表示要添加的日期
        var dateComponents = DateComponents()
        dateComponents.day = -1  // 在当前日期上减去一天

        // 使用 Calendar 进行日期运算
        if let yesterday = calendar.date(byAdding: dateComponents, to: currentDate) {
            // 创建 DateFormatter 以将日期格式化为字符串
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"  // 根据需要选择日期格式

            // 将日期转换为字符串
            let yesterdayString = dateFormatter.string(from: yesterday)
            UIView.transition(with: date, duration: 1, options: .transitionCrossDissolve, animations: {
                self.date.text=yesterdayString
            }, completion: nil)
            

            print("昨日日期: \(yesterdayString)")
        } else {
            print("无法计算昨日日期")
        }
        
        day=1;
        UIView.transition(with: label, duration: 1, options: .transitionCrossDissolve, animations: {
            self.label.text=self.diary[1]
        }, completion: nil)
        UIView.transition(with: tomorrowword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.tomorrowword.text=self.word[1]
        }, completion: nil)
        UIView.transition(with: yesterdayword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.yesterdayword.text=self.word[0]
        }, completion: nil)

    }
    @IBAction func today(_ sender: Any) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 可以根据需要选择日期格式
        let dateString = dateFormatter.string(from: currentDate)
        UIView.transition(with: date, duration: 1, options: .transitionCrossDissolve, animations: {
            self.date.text=dateString
        }, completion: nil)
        print("今日日期: \(dateString)")
        
        day=2;
        UIView.transition(with: label, duration: 1, options: .transitionCrossDissolve, animations: {
            self.label.text=self.diary[2]
        }, completion: nil)
        UIView.transition(with: tomorrowword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.tomorrowword.text=self.word[2]
        }, completion: nil)
        UIView.transition(with: yesterdayword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.yesterdayword.text=self.word[1]
        }, completion: nil)
        
        
        

    }
    @IBAction func tomorrow(_ sender: Any) {

        // 获取当前日期
        let currentDate = Date()

        // 创建一个 Calendar 实例
        let calendar = Calendar.current

        // 创建一个 DateComponents 实例来表示要添加的日期
        var dateComponents = DateComponents()
        dateComponents.day = 1  // 在当前日期上减去一天

        // 使用 Calendar 进行日期运算
        if let yesterday = calendar.date(byAdding: dateComponents, to: currentDate) {
            // 创建 DateFormatter 以将日期格式化为字符串
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"  // 根据需要选择日期格式

            // 将日期转换为字符串
            let tomorrowString = dateFormatter.string(from: yesterday)
            UIView.transition(with: date, duration: 1, options: .transitionCrossDissolve, animations: {
                self.date.text=tomorrowString
            }, completion: nil)
            print("明日日期: \(tomorrowString)")
        } else {
            print("无法计算明日日期")
        }
        
        day=3;
        UIView.transition(with: label, duration: 1, options: .transitionCrossDissolve, animations: {
            self.label.text=self.diary[3]
        }, completion: nil)
        UIView.transition(with: tomorrowword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.tomorrowword.text=self.word[3]
        }, completion: nil)
        UIView.transition(with: yesterdayword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.yesterdayword.text=self.word[2]
        }, completion: nil)

    }
    @IBAction func yihou(_ sender: Any) {
        // 获取当前日期
        let currentDate = Date()

        // 创建一个 Calendar 实例
        let calendar = Calendar.current

        // 创建一个 DateComponents 实例来表示要添加的日期
        var dateComponents = DateComponents()
        dateComponents.day = 2  // 在当前日期上减去一天

        // 使用 Calendar 进行日期运算
        if let yesterday = calendar.date(byAdding: dateComponents, to: currentDate) {
            // 创建 DateFormatter 以将日期格式化为字符串
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"  // 根据需要选择日期格式

            // 将日期转换为字符串
            let tomorrowString = dateFormatter.string(from: yesterday)
            UIView.transition(with: date, duration: 1, options: .transitionCrossDissolve, animations: {
                self.date.text=tomorrowString
            }, completion: nil)
            print("以后日日期: \(tomorrowString)")
        } else {
            print("无法计算以后日期")
        }
        
        day=4;
        UIView.transition(with: label, duration: 1, options: .transitionCrossDissolve, animations: {
            self.label.text=self.diary[4]
        }, completion: nil)
        UIView.transition(with: tomorrowword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.tomorrowword.text=self.word[4]
        }, completion: nil)
        UIView.transition(with: yesterdayword, duration: 1, options: .transitionCrossDissolve, animations: {
            self.yesterdayword.text=self.word[3]
        }, completion: nil)
    }
    
    @IBOutlet weak var displayrating: UILabel!
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            // Switch is ON
            UIView.transition(with: myLabel, duration: 1, options: .transitionCrossDissolve, animations: {
                self.myLabel.text = "LOVE today"
                self.myLabel.textColor = UIColor.systemRed
            }, completion: nil)
        } else {
            // Switch is OFF
            UIView.transition(with: myLabel, duration: 1, options: .transitionCrossDissolve, animations: {
                self.myLabel.text = "Unlike today"
                self.myLabel.textColor = UIColor.systemBlue
            }, completion: nil)
        }

        }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "jump1", sender: self)
    }
    @IBAction func buttonTapped6(_ sender: UIButton) {
        performSegue(withIdentifier: "jump2", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(isDayMode)
        if segue.identifier == "jump1" {
            if let destinationVC = segue.destination as? ViewController2 {
                // 在这里设置 ViewController2 中的属性或传递数据
                destinationVC.isDayMode = isDayMode
            }
        }
        if segue.identifier == "jump2" {
            if let destinationVC = segue.destination as? ViewController3 {
                // 在这里设置 ViewController3 中的属性或传递数据
                destinationVC.isDayMode = isDayMode
            }
        }
    }

    @IBAction func finishedit(_ sender: Any) {
        if let text = tomorrowword.text {
                    word[day] = text // 将文本保存到变量中
                }
    }
    @IBAction func fe(_ sender: Any) {
        if let text = tomorrowword.text {
                    word[day] = text // 将文本保存到变量中
                }
    }
    @IBAction func fe2(_ sender: Any) {
        if let text = tomorrowword.text {
                    word[day] = text // 将文本保存到变量中
                }
    }
    
    
    @IBAction func finishdiary(_ sender: Any) {
        if let text = label.text {
                    diary[day] = text // 将文本保存到变量中
                }
    }
    @IBAction func fd(_ sender: Any) {
        if let text = label.text {
                    diary[day] = text // 将文本保存到变量中
                }
    }
    @IBAction func fd2(_ sender: Any) {
        if let text = label.text {
                    diary[day] = text // 将文本保存到变量中
                }
    }
    
    
    @IBOutlet weak var date: UILabel!
}

