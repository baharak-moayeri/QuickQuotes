//
//  AddQuoteViewController.swift
//  QuickQuotes
//
//  Created by Baharak on 11/2/21.
//

import UIKit

class AddQuoteViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var quoteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        {
            let newQuote = QuickQuotesCD(context:context)
            
            if let quote = quoteTextField.text {
                newQuote.quote = quote
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.quoteTextField.endEditing(true)
        return true
    }

}
