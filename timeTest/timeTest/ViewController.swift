//
//  ViewController.swift
//  timeTest
//
//  Created by 郭明健 on 2018/1/5.
//  Copyright © 2018年 艾泽拉斯. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.size.width      //屏幕宽
let kScreenH = UIScreen.main.bounds.size.height     //屏幕高

let kMaxSeconds : Int = 10

class ViewController: UIViewController {
    
    @IBOutlet weak var stateLabel: UILabel!
    
    //MARK:- 懒加载属性
    fileprivate lazy var hdhTimeView : HDHTimerView = {
        let timeView = HDHTimerView.getTimerView()
        timeView.maxSeconds = kMaxSeconds
        //        timeView.backgroundColor = UIColor.groupTableViewBackground
        let x = (kScreenW - timeView.frame.size.width) / 2.0
        let rect = CGRect.init(x: x, y: 100, width: timeView.frame.size.width, height: timeView.frame.size.height)
        timeView.frame = rect
        
        return timeView
    }()
    
    fileprivate lazy var hdhProgressBarView : HDHProgressBarView = {
        let progressBarView = HDHProgressBarView.getProgressBarView()
        progressBarView.frame = CGRect(x: 0, y: 250, width: kScreenW, height: progressBarView.frame.size.height)
        progressBarView.finishedTime = kMaxSeconds
        
        return progressBarView
    }()
    
    //MARK:- 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //进度条
        view.addSubview(hdhProgressBarView)
        
        //计时器
        view.addSubview(hdhTimeView)
        hdhTimeView.timeCompleteBlock = { (maxSeconds) in
            //print("计时到了：\(maxSeconds)秒")
            self.stateLabel.text = "录音完成"
        }
        
    }
    
    //MARK:- actions
    @IBAction func start(_ sender: Any) {
        hdhTimeView.start()
        
        hdhProgressBarView.start()

        stateLabel.text = "录音中..."
    }
    
    @IBAction func stop(_ sender: Any) {
        hdhTimeView.stop()
        
        hdhProgressBarView.stop()

        stateLabel.text = "录音已暂停"
    }
    
    @IBAction func reset(_ sender: Any) {
        hdhTimeView.reset()
        
        hdhProgressBarView.reset()

        stateLabel.text = ""
    }
}

