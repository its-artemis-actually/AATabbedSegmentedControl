//
//  AATabbedSegmentedControl.swift
//  AATabbedSegmentedControl
//
//  Created by Samantha Todd on 11/26/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class AATabbedSegmentedControl: UIControl {
    
    private var buttons = [UIButton]()
    private var indicatorWidthConstraint: NSLayoutConstraint?
    private var indicatorCenterXConstraint: NSLayoutConstraint?
    private var barView = UIView()
    
    var items = ["Item 1", "Item 2"] {
        didSet(oldValue) {
            setupButtons()
        }
    }
    
    var selectedIndex = 0 {
        didSet(oldValue) {
            updateSelectedIndex()
            onItemSelected?(selectedIndex)
        }
    }
    
    var onItemSelected: ((Int) -> ())?
    
    @IBInspectable var selectedTextColor: UIColor = UIColor.white {
        didSet(oldValue) {
            setColors()
        }
    }
    
    @IBInspectable var unselectedTextColor: UIColor = UIColor.lightGray {
        didSet(oldValue) {
            setColors()
        }
    }
    
    @IBInspectable var selectionIndicatorColor: UIColor = UIColor.white {
        didSet(newValue) {
            setColors()
        }
    }
    
    var font = UIFont.systemFont(ofSize: UIFont.systemFontSize) {
        didSet(oldValue) {
            setFont()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(barView)
        setBarViewConstantConstraints()
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(barView)
        setBarViewConstantConstraints()
        setupButtons()
    }
    
    private func setupButtons() {
        indicatorWidthConstraint?.isActive = false
        indicatorCenterXConstraint?.isActive = false
        buttons.forEach({ $0.removeFromSuperview() })
        buttons.removeAll()
        for i in 0..<items.count {
            let button = UIButton()
            button.setTitle(items[i], for: .normal)
            button.titleLabel?.font = font
            button.setTitleColor(i == selectedIndex ? selectedTextColor : unselectedTextColor, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            addSubview(button)
        }
        addConstraints()
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
    
    private func setBarViewConstantConstraints() {
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setColors() {
        for i in 0..<buttons.count {
            buttons[i].setTitleColor(i == selectedIndex ? selectedTextColor : unselectedTextColor, for: .normal)
        }
        barView.backgroundColor = selectionIndicatorColor
    }
    
    private func setFont() {
        for button in buttons {
            button.titleLabel?.font = font
        }
    }
    
    private func addConstraints() {
        for i in 0..<buttons.count {
            let button = buttons[i]
            if i == 0 {
                button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            }
            else {
                button.leadingAnchor.constraint(equalTo: buttons[i - 1].trailingAnchor).isActive = true
            }
            button.topAnchor.constraint(equalTo: topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: CGFloat(1.0) / CGFloat(buttons.count), constant: 0).isActive = true
        }
        
        indicatorWidthConstraint?.isActive = false
        indicatorWidthConstraint = barView.widthAnchor.constraint(equalTo: buttons[0].widthAnchor, constant: -20)
        indicatorWidthConstraint?.isActive = true
        indicatorCenterXConstraint?.isActive = false
        indicatorCenterXConstraint = barView.centerXAnchor.constraint(equalTo: buttons[selectedIndex].centerXAnchor)
        indicatorCenterXConstraint?.isActive = true
    }
    
    private func updateSelectedIndex() {
        indicatorCenterXConstraint?.isActive = false
        indicatorCenterXConstraint = barView.centerXAnchor.constraint(equalTo: buttons[selectedIndex].centerXAnchor)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.85, options: .curveEaseInOut, animations: {
            self.indicatorCenterXConstraint?.isActive = true
            self.layoutIfNeeded()
        }, completion: nil)
    }

}
