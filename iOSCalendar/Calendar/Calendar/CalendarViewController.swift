//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/20/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

internal let kCalendarMonthViewHeightFactor: CGFloat = 0.48

class CalendarViewController: UIViewController, CalendarViewDatasource, CalendarViewDelegate {

    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var agendaContainerView: UIView!
    @IBOutlet weak var calendarContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarMonthView: CalendarView!
    
    // MARK: - Animations
    private var animator = UIViewPropertyAnimator()
    private var progressWhenInterrupted = [UIViewPropertyAnimator : CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarMonthView.set(selectedDate: Date(), animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureInitialLayout() {
        calendarContainerViewHeightConstraint.constant = view.bounds.size.height * kCalendarMonthViewHeightFactor
        // Set the Calendar View datasource and delegate as self
        calendarMonthView.datasource = self
        calendarMonthView.delegate = self
    }
    
    // MARK: CalendarViewDatasource
    func startDate() -> Date {
        //TODO: should be given from some other place, right now hard coding for testing
        return Date().dateByAdding(months: -12)
    }
    
    func endDate() -> Date {
        return Date().dateByAdding(months: 13)
    }
    
    // MARK: CalendarViewDelegate
    func didSelectedDate(date: Date) {
        print("Selected Date : \(date)")
    }
    
}
