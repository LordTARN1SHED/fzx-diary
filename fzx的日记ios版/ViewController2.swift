//
//  ViewController2.swift
//  fzx的日记ios版
//
//  Created by Lord TARN1SHED on 2023/10/31.
//

import UIKit
import AVFoundation


class ViewController2: UIViewController,UIGestureRecognizerDelegate {
    
    var audioPlayer: AVAudioPlayer?
    var songs: [URL] = [] // 存储音乐文件的URL数组

    var currentSongIndex: Int = 0
    
    @IBOutlet weak var progressView: UIProgressView!
    let stringArray: [String] = ["城南花已开", "Enemy",  "Twilight", "New boy", "悬溺"]
    var intArray: [Int] = [0, 0, 0, 0, 0]
    var rep:Bool = false
    let imageNames = ["1.jpg", "2.jpg", "3.jpg","4.jpg","5.jpg"]
    var currentIndex = 0

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playbutton: UIButton!
    @IBOutlet weak var prevbutton: UIButton!
    @IBOutlet weak var nextbutton: UIButton!
    @IBOutlet weak var lovebutton: UIButton!
    @IBOutlet weak var repeatbutton: UIButton!
    
    @IBOutlet var myView2: UIView!
    @IBOutlet weak var songname: UILabel!
    var isDayMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe))
                leftSwipeGesture.direction = .left
                imageView.addGestureRecognizer(leftSwipeGesture)

                let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
                rightSwipeGesture.direction = .right
                imageView.addGestureRecognizer(rightSwipeGesture)

                // 允许多个手势共存
                leftSwipeGesture.delegate = self
                rightSwipeGesture.delegate = self

                // 如果您使用 Interface Builder 将手势添加到 imageView，请确保将 imageView 的 "User Interaction Enabled" 属性设置为 true
                imageView.isUserInteractionEnabled = true
        
        print(isDayMode)
        if(isDayMode==false){
            UIView.transition(with: myView2, duration: 1, options: .transitionCrossDissolve, animations: {
                self.myView2.backgroundColor = UIColor.gray
            }, completion: nil)
        }else{
            UIView.transition(with: myView2, duration: 1, options: .transitionCrossDissolve, animations: {
                self.myView2.backgroundColor = UIColor.white
            }, completion: nil)
        }

        // 将音乐文件的URL添加到数组中
        if let song1URL = Bundle.main.url(forResource: "song1", withExtension: "mp3") {
            songs.append(song1URL)
            print("done song1")
        }
        if let song2URL = Bundle.main.url(forResource: "song2", withExtension: "mp3") {
            songs.append(song2URL)
            print("done song2")
        }
        if let song3URL = Bundle.main.url(forResource: "song3", withExtension: "mp3") {
            songs.append(song3URL)
            print("done song3")
        }
        if let song4URL = Bundle.main.url(forResource: "song4", withExtension: "mp3") {
            songs.append(song4URL)
            print("done song4")
        }
        if let song5URL = Bundle.main.url(forResource: "song5", withExtension: "mp3") {
            songs.append(song5URL)
            print("done song5")
        }
        print("Num of Song=\(songs.count)")
        
        playSong(atIndex: currentSongIndex)
        displayImage(atIndex: currentIndex)

        // Do any additional setup after loading the view.
    }
    
    func displayImage(atIndex index: Int) {
        if index >= 0 && index < imageNames.count {
            let imageName = imageNames[index]
            UIView.transition(with: imageView, duration: 1, options: .transitionCrossDissolve, animations: {
                self.imageView.image = UIImage(named: imageName) // imageView 是您的 UIImageView 控件
            }, completion: nil)
            
            currentIndex = index
        }
    }
    
    func playSong(atIndex index: Int) {
        do {
            UIView.transition(with: playbutton, duration: 1, options: .transitionCrossDissolve, animations: {
                self.playbutton.setImage(UIImage(systemName: "pause"), for: .normal)
            }, completion: nil)
            
            UIView.transition(with: songname, duration: 1, options: .transitionCrossDissolve, animations: {
                self.songname.text=self.stringArray[index]
            }, completion: nil)
            if(intArray[currentSongIndex] == 0){
                UIView.transition(with: lovebutton, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.lovebutton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                }, completion: nil)
            }else{
                UIView.transition(with: lovebutton, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.lovebutton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                }, completion: nil)
            }
            audioPlayer = try AVAudioPlayer(contentsOf: songs[index])
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            //audioPlayer?.numberOfLoops = -1 // 无限循环

            // 创建一个定时器，每秒更新一次进度条
                    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                        guard let self = self else {
                            timer.invalidate() // 停止定时器
                            return
                        }
                        
                        // 获取音乐的当前播放时间
                        let currentPlayTime = self.audioPlayer?.currentTime ?? 0.0
                        
                        // 获取音乐的总时长
                        let totalDuration = self.audioPlayer?.duration ?? 1.0
                        
                        // 计算进度（范围在 0.0 到 1.0 之间）
                        let progress = Float(currentPlayTime / totalDuration)
                        
                        // 更新进度条的值
                        self.progressView.progress = progress
                        
                        if(progress >= 0.99&&rep==false){
                            currentSongIndex += 1
                            if currentSongIndex >= songs.count {
                                currentSongIndex = 0
                            }
                            playSong(atIndex: currentSongIndex)
                        }
                    }
            
            print("play audio")
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if (audioPlayer?.isPlaying == false) {
            UIView.transition(with: playbutton, duration: 1, options: .transitionCrossDissolve, animations: {
                self.playbutton.setImage(UIImage(systemName: "pause"), for: .normal)
            }, completion: nil)
            audioPlayer?.play()
            print("play：\(currentSongIndex)")
        }else{
            audioPlayer?.pause()
            UIView.transition(with: playbutton, duration: 1, options: .transitionCrossDissolve, animations: {
                self.playbutton.setImage(UIImage(systemName: "play"), for: .normal)
            }, completion: nil)
            print("pause：\(currentSongIndex)")
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        currentSongIndex += 1
        if currentSongIndex >= songs.count {
            currentSongIndex = 0
        }
        playSong(atIndex: currentSongIndex)
        currentIndex += 1
            if currentIndex >= imageNames.count {
                currentIndex = 0
            }
            displayImage(atIndex: currentIndex)
    }

    @IBAction func previousButtonTapped(_ sender: UIButton) {
        currentSongIndex -= 1
        if currentSongIndex < 0 {
            currentSongIndex = songs.count - 1
        }
        playSong(atIndex: currentSongIndex)
        currentIndex -= 1
            if currentIndex < 0 {
                currentIndex = imageNames.count - 1
            }
            displayImage(atIndex: currentIndex)
    }
    
    @objc func handleLeftSwipe() {
        currentSongIndex += 1
        if currentSongIndex >= songs.count {
            currentSongIndex = 0
        }
        playSong(atIndex: currentSongIndex)
        currentIndex += 1
            if currentIndex >= imageNames.count {
                currentIndex = 0
            }
            displayImage(atIndex: currentIndex)
            print("左滑")
        }

        @objc func handleRightSwipe() {
            currentSongIndex -= 1
            if currentSongIndex < 0 {
                currentSongIndex = songs.count - 1
            }
            playSong(atIndex: currentSongIndex)
            currentIndex -= 1
                if currentIndex < 0 {
                    currentIndex = imageNames.count - 1
                }
                displayImage(atIndex: currentIndex)
            print("右滑")
        }

        // 实现 UIGestureRecognizerDelegate 方法以防止手势冲突
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    
    @IBAction func loveButtonTapped(_ sender: UIButton) {
        if(intArray[currentSongIndex] == 0){
            intArray[currentSongIndex] = 1
            UIView.transition(with: lovebutton, duration: 1, options: .transitionCrossDissolve, animations: {
                self.lovebutton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            }, completion: nil)
        }else{
            intArray[currentSongIndex] = 0
            UIView.transition(with: lovebutton, duration: 1, options: .transitionCrossDissolve, animations: {
                self.lovebutton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            }, completion: nil)
        }
    }

    @IBAction func repeatButtonTapped(_ sender: UIButton) {
        if(rep){
            rep = false
            UIView.transition(with: repeatbutton, duration: 1, options: .transitionCrossDissolve, animations: {
                self.repeatbutton.setImage(UIImage(systemName: "repeat"), for: .normal)
            }, completion: nil)
            audioPlayer?.numberOfLoops = 1 // 播放一次，然后停止

        }else{
            rep = true
            UIView.transition(with: repeatbutton, duration: 1, options: .transitionCrossDissolve, animations: {
                self.repeatbutton.setImage(UIImage(systemName: "repeat.1"), for: .normal)
            }, completion: nil)
            audioPlayer?.numberOfLoops = -1 // 无限循环

        }
        
    }
    
    @IBAction func fastForward() {
        if let audioPlayer = audioPlayer {
            let currentTime = audioPlayer.currentTime
            let newTime = currentTime + 5.0 // 快进5秒
            if newTime < audioPlayer.duration {
                audioPlayer.currentTime = newTime
            }
        }
    }

    @IBAction func rewind() {
        if let audioPlayer = audioPlayer {
            let currentTime = audioPlayer.currentTime
            let newTime = currentTime - 5.0 // 快退5秒
            if newTime > 0 {
                audioPlayer.currentTime = newTime
            }
        }
    }
    
    @IBAction func fastForward2() {
        if let audioPlayer = audioPlayer {
            let currentTime = audioPlayer.currentTime
            let newTime = currentTime + 30.0 // 快进5秒
            if newTime < audioPlayer.duration {
                audioPlayer.currentTime = newTime
            }
        }
    }

    @IBAction func rewind2() {
        if let audioPlayer = audioPlayer {
            let currentTime = audioPlayer.currentTime
            let newTime = currentTime - 30.0 // 快退5秒
            if newTime > 0 {
                audioPlayer.currentTime = newTime
            }
        }
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
