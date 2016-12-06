import UIKit

class VHomeInputText:UITextView, UITextViewDelegate
{
    private weak var controller:CHome!
    private let kInsetsHorizontal:CGFloat = 15
    
    convenience init(controller:CHome)
    {
        self.init()
        
        font = UIFont.regular(size:25)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        textColor = UIColor.black
        tintColor = UIColor.black
        bounces = false
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        returnKeyType = UIReturnKeyType.default
        keyboardAppearance = UIKeyboardAppearance.light
        autocorrectionType = UITextAutocorrectionType.no
        spellCheckingType = UITextSpellCheckingType.no
        autocapitalizationType = UITextAutocapitalizationType.words
        contentInset = UIEdgeInsets.zero
        textContainerInset = UIEdgeInsets(
            top:0,
            left:kInsetsHorizontal,
            bottom:0,
            right:kInsetsHorizontal)
        delegate = self
        self.controller = controller
    }
    
    //MARK: textView delegate
    
    func textView(_ textView:UITextView, shouldChangeTextIn range:NSRange, replacementText text:String) -> Bool
    {
        let currentText:NSString = textView.text as NSString
        let editedText:String = currentText.replacingCharacters(
            in:range,
            with:text)
        controller.changedText(text:editedText)
        
        return true
    }
}
