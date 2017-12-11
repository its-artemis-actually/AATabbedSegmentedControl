# AATabbedSegmentedControl
Swift animated custom segmented control.

![Demo](https://github.com/its-artemis-actually/AATabbedSegmentedControl/blob/master/demo.gif)

**OR:** See AATabbedSegmentedControl live in the [Quorus iOS app](https://itunes.apple.com/us/app/quorus/id1247768635?mt=8)!

## Simply drag and drop the AATabbedSegmentedControl.swift file into your project!

Colors are customizable through Interface Builder or code.

Example usage:

```Swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customSegmentedControl: AATabbedSegmentedControl!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSegmentedControl.items = ["ITEM 1", "ITEM 2", "ITEM 3"]
        customSegmentedControl.font = UIFont.boldSystemFont(ofSize: 15)
        
        // Optional - code or Storyboard
        customSegmentedControl.selectedTextColor = UIColor.white
        customSegmentedControl.unselectedTextColor = UIColor.white
        customSegmentedControl.selectionIndicatorColor = UIColor.cyan
        customSegmentedControl.backgroundColor = UIColor.darkGray

        customSegmentedControl.onItemSelected = { (selectedIndex) in
            self.label.text = "Item \(selectedIndex + 1) selected."
        }
    }

}

```
