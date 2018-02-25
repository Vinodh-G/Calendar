//
//  AgendaViewController.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

internal let kCalendarMonthViewHeightFactor: CGFloat = 0.48
internal let kDefaultTableCellHeight: CGFloat = 44.0
internal let kMaxTableCellHeight: CGFloat = 240.0

class AgendaViewController: UIViewController,
UITableViewDelegate,
UITableViewDataSource,
CalendarViewDatasource,
CalendarViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var calendarContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var agendaViewTopConstriant: NSLayoutConstraint!
    
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
                self.scrollAgendaViewTo(date: self.viewModel.selectedDate, animated: false)
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
        agendaViewTopConstriant.constant = calendarContainerViewHeightConstraint.constant
        configureCalendarMonthView()
        configureHeader()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = kDefaultTableCellHeight
    }
    
    func configureCalendarMonthView() {
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

    func configureHeader() {
        guard let calendarView = calendarMonthView else { return }
        let button = UIButton(type: .custom)
        button.backgroundColor = .purple
        button.addTarget(self, action: #selector(AgendaViewController.showTodaysAgenda), for: .touchUpInside)
        calendarView.configureRight(barButton: button)
        
        let leftbutton = UIButton(type: .custom)
        leftbutton.backgroundColor = .purple
        leftbutton.addTarget(self, action: #selector(AgendaViewController.showTodaysAgenda), for: .touchUpInside)
        calendarView.configureLeft(barButton: button)
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
        return day.hasEvents ? day.events.count : 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let dayVM = viewModel.days[indexPath.section]
        
        if dayVM.hasEvents {
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.kEventCellId, for: indexPath) as! EventCell
            let eventVM = dayVM.events[indexPath.row]
            cell.viewModel = eventVM
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoEventsCell.kNoEventsCellId, for: indexPath) as! NoEventsCell
            cell.viewModel = NoEventsViewModel()
            return cell
        }
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
    }
        
    func scrollAgendaViewTo(date:Date, animated:Bool){
        if let indexPath = viewModel.indexPathFor(date: date),
            tableView.numberOfSections > indexPath.section,
            tableView.numberOfRows(inSection: indexPath.section) > indexPath.row {
            tableView.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
    
    @IBAction func showTodaysAgenda(_ sender: Any) {
        let today = Date()
        scrollAgendaViewTo(date: today, animated: true)
        guard let calendarView = calendarMonthView else { return }
        calendarView.set(selectedDate: today, animated: true)
    }
    
    // MARK: CalendarViewDatasource
    func startDate() -> Date {
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
    
    func didTapOnHeader() {
        // TODO: tobe looked into, for testsing added this code
        expandCalendarMonthView(expand: !(agendaViewTopConstriant.constant > 44))
    }
}
