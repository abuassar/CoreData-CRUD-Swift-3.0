//
//  EventTableViewController.swift
//  CoreDataCRUD
//  Written by Steven R.
//

import UIKit

class EventTableViewController: UITableViewController {

    var eventList:Array<Event> = []
    
    //Implicitly unwrapped placeholder for the Controller
    var eventAPI: EventAPI!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventAPI = EventAPI.sharedInstance
        
        if eventAPI.createAndPersistTestData() {
            var outputText :String!
            outputText = "Successfully created test items. Click get all events to retrieve them."
            print(outputText)
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        self.eventAPI = EventAPI.sharedInstance
        
        if eventAPI.createAndPersistTestData() {
            var outputText :String!
            outputText = "Successfully created test items. Click get all events to retrieve them."
            print(outputText)
            
            eventList = eventAPI.getAll()
        }

    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let eventCell = tableView.dequeueReusableCellWithIdentifier("eventItemCell", forIndexPath: indexPath) as! EventTableViewCell

        let eventItem = eventList[indexPath.row]
        
        eventCell.eventDateLabel.text = getFormattedDate(eventItem.date)
        eventCell.eventTitleLabel.text = eventItem.title
        eventCell.eventLocationLabel.text = "\(eventItem.venue) - \(eventItem.city)"
        
        return eventCell
    }
    
    private func getFormattedDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM\nyyyy"
        let DateInFormat = dateFormatter.stringFromDate(date)
            
        return DateInFormat
    }

}
