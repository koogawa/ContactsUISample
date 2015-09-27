//
//  ViewController.swift
//  ContactsUISample
//
//  Created by koogawa on 2015/09/27.
//  Copyright © 2015 Kosuke Ogawa. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private methods

    @IBAction func showContactPickerController() {
        let pickerViewController = CNContactPickerViewController()
        pickerViewController.delegate = self

        // Display only a person's phone, email, and postal address
        let displayedItems = [CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactPostalAddressesKey]
        pickerViewController.displayedPropertyKeys = displayedItems

        // Show the picker
        self.presentViewController(pickerViewController, animated: true, completion: nil)
    }

    // MARK: CNContactPickerDelegate methods

    // Called when a property of the contact has been selected by the user.
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let contactName = CNContactFormatter.stringFromContact(contact, style: .FullName) ?? ""
        let propertyName = CNContact.localizedStringForKey(contactProperty.key)
        let title = "\(contactName)'s \(propertyName)"

        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: title,
                message: contactProperty.value?.description,
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    // Called when the user taps Cancel.
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
    }

}

