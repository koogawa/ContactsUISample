//
//  ViewController.swift
//  ContactsUISample
//
//  Created by koogawa on 2015/09/27.
//  Copyright © 2015年 Kosuke Ogawa. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate, CNContactViewControllerDelegate {

    private var contactStore: CNContactStore!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        showContactPickerController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private methods

    private func showContactPickerController() {
        let picker = CNContactPickerViewController()
        picker.delegate = self

        // Display only a person's phone, email, and birthdate
        let displayedItems = [CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactBirthdayKey]
        picker.displayedPropertyKeys = displayedItems

        // Show the picker
        self.presentViewController(picker, animated: true, completion: nil)
    }

    // MARK: CNContactPickerDelegate methods

    // The selected person and property from the people picker.
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let contactName = CNContactFormatter.stringFromContact(contact, style: .FullName) ?? ""
        let propertyName = CNContact.localizedStringForKey(contactProperty.key)
        let message = "Picked \(propertyName) for \(contactName)"

        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Picker Result",
                message: message,
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    // Implement this if you want to do additional work when the picker is cancelled by the user.
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        picker.dismissViewControllerAnimated(true, completion: {})
    }

}

