/*
 *Filename          : MainViewController.swift
 *Author            : Feiliang Zhou(Greg)
 *StudentId         : 301216989
 *Date              : October 24, 2021
 *App description   : simple calculator
 *Version           : 3.0
*/

import UIKit

/*
 *https://spin.atomicobject.com/2017/07/18/swift-interface-builder/
 * I google this to get the buttons and lables with borders, it didn't show the borders in the interface builder, but it works in the emulator.
 */
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var numStack:[Double] = []
    var opStack:[String] = []
    var operatorJustClicked:Bool = false
    var result:Double = 0

    /**
     * the computing result area
     */
    @IBOutlet weak var resultArea: UILabel!
    
    /**
     * the computing result area in the landscope orientation
     */
    @IBOutlet weak var resultArea1: UILabel!
    
    /**
     * the computing process area
     */
    @IBOutlet weak var procedureArea: UILabel!
    
    /**
     * buttons show up when in the landscope orientation
     */
    @IBAction func landscopeButtion(_ sender: UIButton) {
        switch sender.titleLabel?.text
        {
        case "Rand":
            self.resultArea.text = String(arc4random())
        case "x²":
            self.resultArea.text = String(Double(self.resultArea.text!)! * Double(self.resultArea.text!)!)
        case "²√ˣ":
            self.resultArea.text = String(
                sqrt(Double(self.resultArea.text!)!)
            )
        case "π":
            self.resultArea.text = "3.1415926"
        case "sin":
            self.resultArea.text = String(
                sin(Double(self.resultArea.text!)!)
            )
        case "cos":
            self.resultArea.text = String(
                cos(Double(self.resultArea.text!)!)
            )
        case "tan":
            self.resultArea.text = String(
                tan(Double(self.resultArea.text!)!)
            )
        case "cot":
            self.resultArea.text = String(
                tan(Double(self.resultArea.text!)!) * cos(Double(self.resultArea.text!)!)
            )
        case "sec":
            self.resultArea.text = String(
                sin(Double(self.resultArea.text!)!) * tan(Double(self.resultArea.text!)!)
            )
        case "cosec":
            self.resultArea.text = String(
                1/(sin(Double(self.resultArea.text!)!) * tan(Double(self.resultArea.text!)!))
            )
        default:
            break;
        }
        self.resultArea1.text =  self.resultArea.text
    }
    // when operator buttons being clicked, computing happends
    @IBAction func operatorButton(_ sender: UIButton) {
        var result:Double = 0
        switch sender.titleLabel?.text
        {
        case "+":
            self.procedureArea.text!.append(self.resultArea.text! + "+")
            numStack.append(Double(self.resultArea.text!)!)
            opStack.append("+")
            operatorJustClicked = true
        case "-":
            self.procedureArea.text!.append(self.resultArea.text! + "-")
            numStack.append(Double(self.resultArea.text!)!)
            opStack.append("-")
            operatorJustClicked = true
        case "÷":
            self.procedureArea.text!.append(self.resultArea.text! + "÷")
            numStack.append(Double(self.resultArea.text!)!)
            opStack.append("÷")
            operatorJustClicked = true
        case "x":
            self.procedureArea.text!.append(self.resultArea.text! + "x")
            numStack.append(Double(self.resultArea.text!)!)
            opStack.append("x")
            operatorJustClicked = true
        case "=":
            numStack.append(Double(self.resultArea.text!)!)
            result = numStack.removeFirst()
            if ((opStack.count < 1) || (numStack.count < 1)) {
                break
            }
            // get the operation out of the stack and do the calculation one by one.
            for num in numStack {
                switch String(opStack.removeFirst())
                {
                case "÷":
                    result = result / num
                case "x":
                    result = result * num
                case "+":
                    result = result + num
                case "-":
                    result = result - num
                default: break
                }
            }
            break
        default:
            break
        }
        if (result != 0) {
            self.procedureArea.text!.append(self.resultArea.text! + "=" + String(result))
            self.resultArea.text = String(result)
        }
        self.resultArea1.text =  self.resultArea.text
        
    }
   
    //here are all the number buttons and dot button, when these buttons being clicked, the current number is influenced
    @IBAction func numberButton(_ sender: UIButton) {
        if (operatorJustClicked) {
            self.resultArea.text = "0"
            operatorJustClicked = false
        }
        switch sender.titleLabel?.text
        {
        case ".":
            if(self.resultArea.text!.contains(".")){
                break;
            }
            self.resultArea.text!.append(sender.titleLabel!.text!)
        case "0":
            if (self.resultArea.text == "0") {
                break;
            }
            self.resultArea.text!.append(sender.titleLabel!.text!)
        default:
            if (self.resultArea.text == "0") {
                self.resultArea.text = ""
            }
            self.resultArea.text!.append(sender.titleLabel!.text!)
        }
        self.resultArea1.text =  self.resultArea.text
        
    }
    
    //all the function buttons are here, they can change the value of the current number
    @IBAction func specialbutton(_ sender: UIButton) {
        switch sender.titleLabel?.text
        {
        case "AC":
            self.resultArea.text = "0"
            self.procedureArea.text = ""
            opStack.removeAll()
            numStack.removeAll()
        case "b":
            self.resultArea.text?.removeLast()
            if(self.resultArea.text == "") {
                self.resultArea.text = "0"
            }
        case "%":
            if (self.resultArea.text != "0") {
                self.resultArea.text = String(Double(self.resultArea.text!)! * 0.01)
            }
        case "+/-":
            var result_string:String = self.resultArea.text!
            if (result_string.contains("-")) {
                result_string.removeFirst()
            } else {
                result_string.insert("-", at: result_string.startIndex)
            }
            self.resultArea.text = result_string
        default: break
        }
        self.resultArea1.text =  self.resultArea.text
    }
}

