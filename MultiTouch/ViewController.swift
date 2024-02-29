//
//  ViewController.swift
//  MultiTouch
//
//  Created by Sefa Aycicek on 29.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let BALL_WIDTH_HEIGHT : CGFloat = 100
    let INTERVAL : CGFloat = 0.01
    
    var timer : Timer? = nil
    
    var balls = [CustomBallView]()
    
    @IBOutlet weak var ballView2: CustomBallView!
    @IBOutlet weak var ballView: CustomBallView!
    // array = 1,1,1,1,1
    //set = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballView.layer.cornerRadius = BALL_WIDTH_HEIGHT / 2
        ballView2.layer.cornerRadius = BALL_WIDTH_HEIGHT / 2
        
        //balls.append(ballView)
        //balls.append(ballView2)
        
        
        startTimer()
    
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: INTERVAL, repeats: true, block: { _ in
            //self.ballView.move()
            //self.ballView2.move()
            
            self.balls.forEach { aBall in
                aBall.move()
                aBall.checkIntersact(balls: self.balls)
            }
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            //firstTouch.tapCount
            let point : CGPoint =  firstTouch.location(in: self.view)
                    
            let newBall = CustomBallView(frame: CGRect(x: point.x,
                                                       y: point.y ,
                                                       width: BALL_WIDTH_HEIGHT,
                                                       height: BALL_WIDTH_HEIGHT))
            newBall.layer.cornerRadius = BALL_WIDTH_HEIGHT / 2
            newBall.backgroundColor = UIColor.random
            self.view.addSubview(newBall)
            self.balls.append(newBall)
            
            
        }
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            //firstTouch.tapCount
         /*   let point : CGPoint =  firstTouch.location(in: self.view)
            debugPrint("\(point.x) - \(point.y)")
            
          //  if ballView.frame.intersects(ballView2.frame)
            if ballView.frame.contains(point) {
                ballView.frame = CGRect(x: point.x - 50,
                                        y: point.y - 50,
                                        width: BALL_WIDTH_HEIGHT,
                                        height: BALL_WIDTH_HEIGHT)
            }*/
            
        }
    }
}


class CustomBallView : UIView {
    var STEP_VALUE_X : CGFloat = 2
    var STEP_VALUE_Y : CGFloat = 2
    
    let BALL_WIDTH_HEIGHT : CGFloat = 100
    
    func move() {
        self.frame = CGRectMake(self.frame.origin.x + self.STEP_VALUE_X,
                                self.frame.origin.y + self.STEP_VALUE_Y,
                                self.BALL_WIDTH_HEIGHT,
                                self.BALL_WIDTH_HEIGHT)
        if let superview = self.superview {
            if self.frame.maxX >= superview.bounds.maxX ||
            self.frame.minX <= 0 {
                
                self.STEP_VALUE_X = -1 * self.STEP_VALUE_X
            }
            
            if self.frame.maxY >= superview.bounds.maxY ||
                self.frame.minY <= 0
            {
                self.STEP_VALUE_Y = -1 * self.STEP_VALUE_Y
            }
        }
    }
    
    func checkIntersact(balls : [CustomBallView]) {
        for aBall in balls {
            let a = aBall.center;
            let b = self.center;
            let distance = sqrt(pow((b.x - a.x),2) + pow((b.y - a.y),2))

            if aBall != self && distance < BALL_WIDTH_HEIGHT {
                //images are touching.
          
            //if aBall != self && aBall.frame.intersects(self.frame) {
                self.STEP_VALUE_X = -1 * self.STEP_VALUE_X
                self.STEP_VALUE_Y = -1 * self.STEP_VALUE_Y
                break
            }
        }
       
    }
}


extension UIColor {
    static var random : UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
