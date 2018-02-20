//
//  ViewController.swift
//  cardio-spike
//
//  Created by Michael Patterson on 2/20/18.
//  Copyright © 2018 Michael Patterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CardIOPaymentViewControllerDelegate {
    @IBOutlet weak var nameResultLabel: UILabel!
    @IBOutlet weak var typeResultLabel: UILabel!
    @IBOutlet weak var numberResultLabel: UILabel!
    @IBOutlet weak var cvvResultLabel: UILabel!
    @IBOutlet weak var expResultLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        errorLabel.text = "user canceled"
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            print(str)
            nameResultLabel.text = info.cardholderName
            nameResultLabel.sizeToFit()
            
            typeResultLabel.text = "\(info.cardType.rawValue)"
            typeResultLabel.sizeToFit()
            
            numberResultLabel.text = info.cardNumber
            numberResultLabel.sizeToFit()
            
            cvvResultLabel.text = info.cvv
            cvvResultLabel.sizeToFit()
            
            expResultLabel.text = "\(info.expiryMonth)/\(info.expiryYear)"
            expResultLabel.sizeToFit()
        }
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func scanCard(_ sender: Any) {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.modalPresentationStyle = .formSheet
        cardIOVC?.collectCardholderName = true
        present(cardIOVC!, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        CardIOUtilities.preload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

