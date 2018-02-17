//
//  CustomView.swift
//  ViewResixeWithPan
//
//  Created by Vinodh Govind Swamy on 2/17/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class CustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var startPoint: CGPoint = CGPoint.zero
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addPanGesture()
    }

    func addPanGesture() {
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(CustomView.handlePan(gesture:)))
        addGestureRecognizer(pangesture)
    }
    
    @objc func handlePan(gesture:UIPanGestureRecognizer) {
        let point = gesture.location(in: self.superview)
        let translation = gesture.translation(in: self)
        switch gesture.state {
        case .began:
            print("start:\(point)");
            startPoint = point
        case .changed:
//            print("changed:\(point)");
            resizeViewFor(point: point)
        default: break
        }
    }
    
    func resizeViewFor(point:CGPoint){

        let heightPercent = heightPercentageFor(point: point)
        var transform = self.transform
        transform = CGAffineTransform(translationX: 0, y: 0)
        transform = CGAffineTransform(scaleX: 1, y:  heightPercent)
        self.transform = transform
//        self.frame = CGRect(x: 0, y:0 , width: bounds.size.width, height: bounds.size.height * heightPercent )
    }
    
    func heightPercentageFor(point:CGPoint) -> CGFloat {
        var heightPercet: CGFloat = 100.0
        var totalDistPanned = self.startPoint.y - point.y
        totalDistPanned
        print(heightPercet)
        return heightPercet / 100
    }
}
