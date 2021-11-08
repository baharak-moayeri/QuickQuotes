//
//  QuoteTableViewController.swift
//  QuickQuotes
//
//  Created by Baharak on 10/11/21.
//

import UIKit

class QuoteTableViewController: UITableViewController {
    
    var quickQuotesCDs: [QuickQuotesCD] = []

    var quotes = [
    "I love you the more in that I believe you had liked me for my own sake and for nothing else. John Keats",
    "There is nothing permanent except change. Heraclitus",
    "You cannot shake hands with a clenched fist. Indira Gandhi",
    "Lord, make us instruments of Thy peace. Where there is hatred, let us sow love; where there is injury, pardon; where there is discord, union; where there is doubt, faith; where there is despair, hope; where there is darkness, light; where there is sadness, joy. St. Francis of Assisi"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getQuickQuotes()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 10
        return quotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = quotes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuote = quotes[indexPath.row]
        performSegue(withIdentifier: "moveToQuoteDetail", sender: selectedQuote)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                if (indexPath.row > 3) {
                    let selectedQuickQuotes = quickQuotesCDs[indexPath.row - 4]
                    context.delete(selectedQuickQuotes)
                    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                    self.quotes.remove(at: indexPath.row)
                    getQuickQuotes()
                }
                
            }
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
        //} else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let quoteViewController = segue.destination as? QuoteDetailViewController {
            if let selectedQuote = sender as? String {
                quoteViewController.quote = selectedQuote
            }
        }
    }
    
    func getQuickQuotes(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let quickQuotesFromCoreData = try? context.fetch(QuickQuotesCD.fetchRequest()){
                if let quickQuotes = quickQuotesFromCoreData as? [QuickQuotesCD] {
                    quickQuotesCDs = quickQuotes
                    for entity in quickQuotesCDs {
                        if let quotString = entity.quote {
                            if !quotes.contains(quotString) {
                                self.quotes.append(quotString)
                            }
                        }
                    }
                    
                    tableView.reloadData()
                }
            }
        }
    }
    

}
