//
//  DatePickTextField.swift
//  iXplore
//
//  Created by David Xu on 7/14/16.
//  Copyright © 2016 David Xu. All rights reserved.
//

import UIKit

class DatePickTextField: UITextField {
    
    let datePicker = UIDatePicker()
    let keyBoardTool = UIToolbar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action:#selector(changeKeyBoard), forControlEvents: .EditingDidBegin)
        datePicker.addTarget(self, action: #selector(self.translateDate), forControlEvents: .ValueChanged)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action:#selector(changeKeyBoard), forControlEvents: .EditingDidBegin)
        datePicker.addTarget(self, action: #selector(self.translateDate), forControlEvents: .ValueChanged)
    }
    func translateDate(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        self.text = dateFormatter.stringFromDate(datePicker.date)
    }
    func changeKeyBoard(){
        datePicker.datePickerMode = .Date
        self.inputView = datePicker
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(self.resign))
        keyBoardTool.frame = CGRect(x: 0, y: 0, width: datePicker.frame.width, height: 40)
        keyBoardTool.setItems([space,doneButton], animated: true)
        self.inputAccessoryView = keyBoardTool
        
    }
    func resign(){
        self.resignFirstResponder()
    }
    

}
