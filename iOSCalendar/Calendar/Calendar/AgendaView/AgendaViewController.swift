//
//  AgendaViewController.swift
//  Calendar
//
//  Created by Vinodh Govind Swamy on 2/18/18.
//  Copyright © 2018 Vinodh Swamy. All rights reserved.
//

import UIKit

class AgendaViewController: UITableViewController {

    var viewModel: AgendaViewDataSource = AgendaViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let dateRange = DateRange(start: Date().dateByAdding(months: -12), months: 24, years: 0)
        let request = loadEventsRequestParam(dateRange: dateRange)
        viewModel.loadEvents(requestParam: request) { [unowned self] (response) in
            if response.success {
                self.handleViewUpdates(update: response.updates)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.days.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = viewModel.days[section]
        return day.events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let day = viewModel.days[indexPath.section]
        let event = day.events[indexPath.row]
        
        cell.textLabel?.text = event.title

        return cell
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
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
