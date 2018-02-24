//
//  AgendaViewController.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

internal let kCalendarMonthViewHeightFactor: CGFloat = 0.48

class AgendaViewController: UIViewController,
UITableViewDelegate,
UITableViewDataSource,
CalendarViewDatasource,
CalendarViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var calendarContainerViewHeightConstraint: NSLayoutConstraint!

    var calendarMonthView: CalendarView?
    var viewModel: AgendaViewDataSource = AgendaViewModel()
    var dateRange: DateRange = DateRange(start: Date().dateByAdding(months: -12),
                                         months: 24,
                                         years: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialLayout()
        
        let request = loadEventsRequestParam(dateRange: dateRange)
        viewModel.loadEvents(requestParam: request) { [unowned self] (response) in
            if response.success {
                self.handleViewUpdates(update: response.updates)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let calendarView = calendarMonthView else { return }
        let today = Date()
        viewModel.selectedDate = today
        calendarView.set(selectedDate: today, animated: false)
    }
    
    func configureInitialLayout() {
        self.navigationController?.isNavigationBarHidden = true
        calendarContainerViewHeightConstraint.constant = view.bounds.size.height * kCalendarMonthViewHeightFactor
        
        guard calendarMonthView == nil else { return }
        let calendarView = CalendarView(frame: calendarContainerView.bounds)
        calendarContainerView.addSubview(calendarView)
        
        // Set the Calendar View datasource and delegate as self
        calendarView.datasource = self
        calendarView.delegate = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        let layoutMargins = calendarContainerView.safeAreaLayoutGuide
        calendarView.leadingAnchor.constraint(equalTo: layoutMargins.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: layoutMargins.trailingAnchor).isActive = true
        calendarView.topAnchor.constraint(equalTo: layoutMargins.topAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: layoutMargins.bottomAnchor).isActive = true
        calendarMonthView = calendarView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.days.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = viewModel.days[section]
        return day.eventsCount()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let day = viewModel.days[indexPath.section]
        let event = day.eventFor(index: indexPath.row)
        
        cell.textLabel?.text = event.title

        return cell
    }
    
    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        let day = viewModel.days[section]
        return day.title
    }
    
    // MARK: - TableView Updates
    
    func handleViewUpdates(update:AgendaViewUpdate) {
        // TODO: curently not using it needs to be rectified for
        // tableView updates, when loading more events using load more
        return
    }
        
    func scrollAgendaViewTo(date:Date, animated:Bool){
        if let indexPath = viewModel.indexPathFor(date: date) {
            tableView.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
    
    @IBAction func showTodaysAgenda(_ sender: Any) {
        scrollAgendaViewTo(date: Date(), animated: true)
    }
    
    // MARK: CalendarViewDatasource
    func startDate() -> Date {
        //TODO: should be given from some other place, right now hard coding for testing
        return dateRange.start
    }
    
    func endDate() -> Date {
        return dateRange.end
    }
    
    // MARK: CalendarViewDelegate
    func didSelectedDate(date: Date) {
        viewModel.selectedDate = date
        scrollAgendaViewTo(date: date, animated: true)
    }
}
