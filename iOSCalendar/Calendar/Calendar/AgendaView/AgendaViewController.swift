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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialLayout()
        
        let dateRange = DateRange(start: Date().dateByAdding(months: -12), months: 24, years: 0)
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
        calendarView.set(selectedDate: Date(), animated: false)
    }
    
    func configureInitialLayout() {
        self.navigationController?.isNavigationBarHidden = true
        calendarContainerViewHeightConstraint.constant = view.bounds.size.height * kCalendarMonthViewHeightFactor
        // Set the Calendar View datasource and delegate as self
        
        guard calendarMonthView == nil else { return }
        let calendarView = CalendarView(frame: calendarContainerView.bounds)
        calendarContainerView.addSubview(calendarView)
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
        return day.events.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let day = viewModel.days[indexPath.section]
        let event = day.events[indexPath.row]
        
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
        self.tableView.beginUpdates()

        for update in update.sectionsUpdate {
            switch update.type {
            case .insert:
                self.tableView.insertSections(update.sectionIndex, with: .fade)
            case .delete:
                self.tableView.deleteSections(update.sectionIndex, with: .fade)
            case .update:
                self.tableView.reloadSections(update.sectionIndex, with: .fade)
            }
        }

        self.tableView.endUpdates()
    }
    
    // MARK: - TableView Updates
    @IBAction func showTodaysAgenda(_ sender: Any) {
        if let indexPath = viewModel.indexSetFor(date: Date()){
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
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
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
