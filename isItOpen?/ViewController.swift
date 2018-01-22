//
//  ViewController.swift
//  isItOpen?
//
//  Created by Bhavdeep Singh on 07/12/17.
//  Copyright © 2017 Bhavdeep Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func StarbucksBtn(_ sender: Any) {
        
    }
    @IBOutlet weak var StarbucksAv: UILabel!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var SCAA_Av: UILabel!
    @IBOutlet weak var DCAv: UILabel!
    
    @IBOutlet weak var NextOpenSCAA: UILabel!
    @IBOutlet weak var NextOpenDC: UILabel!
    @IBOutlet weak var NextOpenRAW: UILabel!
    @IBOutlet weak var NextOpenSB: UILabel!
    
    func whenOpenNext(_Currday : Int, _CurrHours : Int, _CurrMinutes : Int, _Shop : String) -> String {
        var NextOpenHours : Int  = 0
        var NextOpenMinutes : Int = 0
        var NewHours : Int
        var NewMinutes : Int
        
        if(_Currday < 6 && _Currday != 1)
        {
            if(_Shop == "DC" || _Shop == "SB")
            {
                NextOpenHours = 700
                NextOpenMinutes = 0
            }
            else if (_Shop == "RAW")
            {
                NextOpenHours = 600
                NextOpenMinutes = 0
            }
            else
            {
                NextOpenHours = 1000
                NextOpenMinutes = 0
            }
        }
        else if (_Currday == 7 || _Currday == 1)
        {
            if(_Shop == "DC" )
            {
                NextOpenHours = 1000
                NextOpenMinutes = 0
            }
            else if(_Shop == "SB")
            {
                NextOpenHours = 1030
                NextOpenMinutes = 30
            }
            else if (_Shop == "RAW")
            {
                NextOpenHours = 900
                NextOpenMinutes = 0
            }
        }
        else if (_Currday == 6)
        {
            if(_Shop == "DC" || _Shop == "SB")
            {
                NextOpenHours = 700
                NextOpenMinutes = 0
            }
            else if (_Shop == "RAW")
            {
                NextOpenHours = 600
                NextOpenMinutes = 0
            }
            else if (_Shop == "SCAA")
            {
                return "Monday"
            }
        }
        
        NewHours = NextOpenHours - ((_CurrHours*100) + _CurrMinutes)
        NewHours /= 100
        if(NewHours < 0)
        {
            NewHours *= -1
        }
        NewMinutes = (NextOpenMinutes+60) - _CurrMinutes
        if(NewMinutes >= 60)
        {
            NewHours = NewHours + 1
            NewMinutes = NewMinutes - 60
        }
        if (NewHours == 0)
        {
            return "\(NewMinutes) min"
        }
        else if(NewMinutes == 60)
        {
            NewMinutes = 0
        }
        return "\(NewHours) h  \(NewMinutes) min"
    }
    
    func RAW(_day : Int, _hour : Int, _minute : Int) -> Bool {
        if(_day < 6 && _day != 1)
        {
            if(_hour < 6 || _hour > 23)
            {
                return false
            }
            else
            {
                return true
            }
        }
        
        else if (_day == 7 || _day == 1)
        {
            if(_hour < 9 || _hour > 21)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else if (_day == 6)
        {
            if(_hour < 6 || _hour > 22)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            return true;
        }
    }
    
    func Starbucks(_day : Int, _hour : Int, _minute : Int) -> Bool {
        if(_day < 6 && _day != 1)
        {
            if(_hour < 7 || _hour > 20)
            {
                return false
            }
            else
            {
                return true
            }
        }
            
        else if (_day == 7 || _day == 1)
        {
            if((_hour < 10 && _minute < 30) || _hour > 17)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else if (_day == 6)
        {
            if((_hour < 7 || _minute < 30) || _hour > 17)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            return true;
        }
    }
    
    func SCAA(_day : Int, _hour : Int, _minute : Int) -> Bool {
        if(_day < 6 && _day != 1)
        {
            if(_hour < 10 || _hour > 19)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else
        {
            return false;
        }
    }
    
    func DC(_day : Int, _hour : Int, _minute : Int) -> Bool {
        if(_day < 6 && _day != 1)
        {
            if(_hour >= 0 && _hour < 7)
            {
                return false
            }
            else
            {
                return true
            }
        }
            
        else if (_day == 7)
        {
            if(_hour < 10 || _hour > 19)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else if (_day == 1)
        {
            if(_hour < 10)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else if (_day == 6)
        {
            if(_hour < 7 || _hour > 20)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            return true;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let calendar = Calendar.current
        
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        var day = calendar.component(.weekday, from:date)
        
        print(hour)
        print(minutes)
        print(day)
        
        var isRawOpen : Bool
        var isStarbucksOpen : Bool
        var isSCAAOpen : Bool
        var isDCOpen : Bool
        
        isRawOpen = RAW(_day: day, _hour: hour, _minute: minutes)
        isStarbucksOpen = Starbucks(_day: day, _hour: hour, _minute: minutes)
        isSCAAOpen = SCAA(_day: day, _hour: hour, _minute: minutes)
        isDCOpen = DC(_day: day, _hour: hour, _minute: minutes)
        
       
        
        if(isRawOpen == false)
        {
            Label1.text = "Closed"
            Label1.textColor = UIColor.red
            NextOpenRAW.text = whenOpenNext(_Currday: day, _CurrHours: hour, _CurrMinutes: minutes, _Shop: "RAW")
        }
        if(isStarbucksOpen == false)
        {
            StarbucksAv.text = "Closed"
            StarbucksAv.textColor = UIColor.red
            NextOpenSB.text = whenOpenNext(_Currday: day, _CurrHours: hour, _CurrMinutes: minutes, _Shop: "SB")
        }
        if(isSCAAOpen == false)
        {
            SCAA_Av.text = "Closed"
            SCAA_Av.textColor = UIColor.red
            NextOpenSCAA.text =  whenOpenNext(_Currday: day, _CurrHours: hour, _CurrMinutes: minutes, _Shop: "SCAA")
        }
        if(isDCOpen == false)
        {
            DCAv.text = "Closed"
            DCAv.textColor = UIColor.red
            NextOpenDC.text = whenOpenNext(_Currday: day, _CurrHours: hour, _CurrMinutes: minutes, _Shop: "DC")
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
}

