//
//  AgendaViewController.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController,
UITableViewDelegate,
UITableViewDataSource,
CalendarViewDatasource,
CalendarViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var agendaContainerView: UIView!
    @IBOutlet weak var calendarContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var agendaViewTopConstriant: NSLayoutConstraint!
    
    var calendarMonthView: CalendarView?
    var viewModel: AgendaViewDataSource!
    
    static func agendaViewController(dateRange:DateRange) -> UIViewController {
        let storyBoard = UIStoryboard.init(name: "AgendaView", bundle: nil)
        let agendaViewController = storyBoard.instantiateViewController(withIdentifier: "agendaViewController") as! AgendaViewController
        
        let agendaViewModel = AgendaViewModel(inDateRange: dateRange)
        agendaViewController.viewModel = agendaViewModel
        return agendaViewController
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialLayout()
        addShadow(to: agendaContainerView)
        
        loadEventsforDate(range: viewModel.dateRange)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let calendarView = calendarMonthView else { return }
        let today = Date()
        viewModel.selectedDate = today
        calendarView.set(selectedDate: today, animated: false)
        expandCalendarMonthView(expand: false)
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
        tableView.reloadData()
        // TODO: curently not using it needs to be rectified for
        // tableView updates, when loading more events using load more
    }
        
    private func scrollAgendaViewTo(date:Date, animated:Bool){
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
        return viewModel.dateRange.start
    }
    
    func endDate() -> Date {
        return viewModel.dateRange.end
    }
    
    // MARK: CalendarViewDelegate
    func didSelectedDate(date: Date) {
        viewModel.selectedDate = date
        scrollAgendaViewTo(date: date, animated: false)
        expandCalendarMonthView(expand: false)
    }
    
    func didTapOnHeader() {
        // TODO: tobe looked into, for testsing added this code
        expandCalendarMonthView(expand: !(agendaViewTopConstriant.constant > AgendaViewConfig.defaultConfig.headerHieght))
    }
    
    //MARK: Orientations
    
    override var shouldAutorotate: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .pad ? .landscape : .portrait
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil, completion:{ (context) in
            self.updateContainerLayoutsConstraint()
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.calendarMonthView?.reloadCalendarView()
        })
    }
    
    //MARK: Private
    private func configureInitialLayout() {
        self.navigationController?.isNavigationBarHidden = true
        updateContainerLayoutsConstraint()
        configureCalendarMonthView()
        configureHeader()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = kDefaultTableCellHeight
    }
    
    private func configureCalendarMonthView() {
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
    
    private func configureHeader() {
        guard let calendarView = calendarMonthView else { return }
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "today_icon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        button.addTarget(self, action: #selector(AgendaViewController.showTodaysAgenda), for: .touchUpInside)
        calendarView.configureRight(barButton: button)
        
        let leftbutton = UIButton(type: .custom)
        leftbutton.setImage(UIImage(named: "menu_icon"), for: .normal)
        leftbutton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        leftbutton.addTarget(self, action: #selector(AgendaViewController.showTodaysAgenda), for: .touchUpInside)
        calendarView.configureLeft(barButton: leftbutton)
    }
    
    func updateContainerLayoutsConstraint() {
        calendarContainerViewHeightConstraint.constant = view.bounds.size.height * AgendaViewConfig.defaultConfig.heightFactor
        agendaViewTopConstriant.constant = calendarContainerViewHeightConstraint.constant
    }
    
    func loadEventsforDate(range:DateRange)  {
        let request = loadEventsRequestParam(dateRange: range)
        viewModel.loadEvents(requestParam: request) { [unowned self] (response) in
            if response.success {
                self.handleViewUpdates(update: response.updates)
                self.scrollAgendaViewTo(date: self.viewModel.selectedDate, animated: false)
            }
        }
    }
}
