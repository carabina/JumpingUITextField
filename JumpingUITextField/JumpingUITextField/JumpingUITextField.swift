//
//  JumpingUITextField - https://github.com/AWeleczka/JumpingUITextField
//  Extension for UITextField written in swift 4.2
//
//  Readme:        https://github.com/AWeleczka/JumpingUITextField/blob/master/README.md
//  Changelog:     https://github.com/AWeleczka/JumpingUITextField/blob/master/CHANGELOG.md
//  CocoaPod:      https://cocoapods.org/pods/JumpingUITextField
//  License (MIT): https://github.com/AWeleczka/JumpingUITextField/blob/master/LICENSE
//
//  Copyright (c) 2019 Alexander Weleczka - https://AWeleczka.de/
//

import UIKit

@IBDesignable public class JumpingUITextField: UITextField {
  @IBInspectable var group: String = ""
  @IBInspectable var order: UInt = 0

  public static func nextJumpingUITextField(_ field: JumpingUITextField) {
    if field.order > 0 && field.group.count > 0 {
      for subview in field.getJumpingInputs() {
        if field.group == subview.group && subview.order == field.order + 1 {
          subview.becomeFirstResponder()
        }
      }
    }

    field.resignFirstResponder()
  }

  private func getJumpingInputs() -> [JumpingUITextField] {
    var subberviews: [UIView] = []
    var inputs: [JumpingUITextField] = []

    var supperview = self.superview
    while supperview?.superview != nil {
      supperview = supperview?.superview
    }
    if let supperview = supperview {
      subberviews = self.extractSubviews(view: supperview)
    }

    for jumping in subberviews where jumping is JumpingUITextField {
      if let jumping = jumping as? JumpingUITextField {
        inputs.append(jumping)
      }
    }

    return inputs
  }

  private func extractSubviews(view: UIView) -> [UIView] {
    var subberviews: [UIView] = []

    if view.subviews.count == 0 {
      subberviews.append(view)
    } else {
      subberviews.append(view)
      for subview in view.subviews {
        subberviews.append(contentsOf: self.extractSubviews(view: subview))
      }
    }

    return subberviews
  }
}
