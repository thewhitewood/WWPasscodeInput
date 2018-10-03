/*
 MIT License
 
 Copyright (c) 2018 Nicholas Wood / The White Wood Media Ltd
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

protocol WWPasscodeInputDelegate {
    func passcodeInputDidChangeInput(passcodeInput:WWPasscodeInput, completed:Bool, value:String?)
}

@IBDesignable
public class WWPasscodeInput:UIView {
    
    var delegate:WWPasscodeInputDelegate?
    
    var input:String? { return inputField.text }
    
    var font:UIFont = UIFont.systemFont(ofSize: 50, weight: .regular) {
        didSet { resetView() }
    }
    
    @IBInspectable public var textColor:UIColor = .black {
        didSet { resetView() }
    }
    
    @IBInspectable public var passcodeLimit:Int = 6 {
        didSet { resetView() }
    }
    
    @IBInspectable public var markerRadius:Int = 5 {
        didSet { resetView() }
    }
    
    @IBInspectable public var markerOutlineColour:UIColor = .gray {
        didSet{ resetView() }
    }
    
    @IBInspectable public var markerColour:UIColor = .gray {
        didSet{ resetView() }
    }
    
    @IBInspectable public var completedMarkerColour:UIColor = .black {
        didSet{ resetView() }
    }
    
    @IBInspectable public var completedMarkerOutlineColour:UIColor = .black {
        didSet{ resetView() }
    }
    
    @IBInspectable public var markerBorderWidth:CGFloat = 0.0 {
        didSet{ resetView() }
    }
    
    private var markers:[Marker] = []
    private var labelXConstraint:NSLayoutConstraint?
    
    private lazy var label:UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var stackView:UIStackView = {
        let view:UIStackView = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        return view
    }()
    
    private lazy var inputField:UITextField = {
        let view:UITextField = UITextField()
        view.autocorrectionType = .no
        view.keyboardType = .numberPad
        view.delegate = self
        view.isHidden = true
        view.addTarget(self, action: #selector(onChanged), for: UIControl.Event.editingChanged)
        return view
    }()
    
    private lazy var button:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onSelected), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    //MARK:- Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 250, height: 50)
    }
    
    override public func becomeFirstResponder() -> Bool {
        return inputField.becomeFirstResponder()
    }
    
    //MARK:- Methods
    
    private func configureView(){
        resetView()
        
        // StackView
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackViewYConstraint = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let stackViewLeftConstraint = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let stackViewRightConstraint = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        self.addConstraints([stackViewYConstraint, stackViewLeftConstraint, stackViewRightConstraint])
        
        // Label
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let labelYConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        labelXConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        addConstraints([labelYConstraint, labelXConstraint!])
        
        // Input Field
        addSubview(inputField)
        inputField.translatesAutoresizingMaskIntoConstraints = false
        let inputFieldTopConstraint = NSLayoutConstraint(item: inputField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let inputFieldLeftConstraint = NSLayoutConstraint(item: inputField, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let inputFieldRightConstraint = NSLayoutConstraint(item: inputField, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let inputFieldBottomConstraint = NSLayoutConstraint(item: inputField, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        self.addConstraints([inputFieldTopConstraint, inputFieldLeftConstraint, inputFieldRightConstraint, inputFieldBottomConstraint])
        
        // Button
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonTopConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let buttonLeftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let buttonRightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let buttonBottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        self.addConstraints([buttonTopConstraint, buttonLeftConstraint, buttonRightConstraint, buttonBottomConstraint])
    }
    
    private func resetView(){
        // Label
        label.font = UIFont.systemFont(ofSize: 50, weight: .regular)
        label.textColor = textColor
        
        // Reset Markers
        markers.removeAll()
        let removedSubviews = stackView.arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            stackView.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
        
        // Create Markers and Stock
        for _ in 0..<passcodeLimit {
            let marker = Marker(markerRadius: markerRadius)
            marker.backgroundColor = markerColour
            marker.layer.borderColor = markerOutlineColour.cgColor
            marker.layer.borderWidth = markerBorderWidth
            markers.append(marker)
        }
        
        for marker in markers {
            stackView.addArrangedSubview(marker)
        }
    }
    
    //MARK:- Handlers
    
    @objc func onSelected(_ sender:UIButton){
        inputField.becomeFirstResponder()
        
        guard let parent = superview else { return }
        
        let recogniser:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        parent.addGestureRecognizer(recogniser)
    }
    
    @objc func tapHandler(_ sender:UITapGestureRecognizer){
        endEditing(true)
    }
    
    @objc func onChanged(_ sender:UITextField){
        delegate?.passcodeInputDidChangeInput(passcodeInput: self, completed: sender.text?.count == passcodeLimit, value: sender.text)
    }
}

//MARK:- UITextFieldDelegate

extension WWPasscodeInput : UITextFieldDelegate {
    
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard range.location < passcodeLimit else { return false }
        
        label.text = string
        label.alpha = 1
        
        guard let marker = markers[range.location] as UIView?, let constraint = labelXConstraint else { return false }
        
        self.removeConstraint(constraint)
        
        labelXConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: marker, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        
        self.addConstraint(labelXConstraint!)
        
        marker.alpha = 0
        
        UIView.animate(withDuration: 0, delay: string.isEmpty ? 0.1 : 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.label.alpha = 0
            marker.backgroundColor = string.isEmpty ? self.markerColour : self.completedMarkerColour
            marker.layer.borderColor = string.isEmpty ? self.markerOutlineColour.cgColor : self.completedMarkerOutlineColour.cgColor
        }, completion: { (complete) in
            marker.alpha = 1
        })
        
        return true
    }
}

internal class Marker:UIView {
    
    private var markerRadius:Int = 5
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    convenience init(markerRadius:Int){
        self.init(frame: CGRect(x: 0, y: 0, width: markerRadius * 2, height: markerRadius * 2))
        self.markerRadius = markerRadius
        configureView()
    }
    
    private func configureView(){
        layer.cornerRadius = CGFloat(markerRadius)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: markerRadius * 2, height: markerRadius * 2)
    }
}
