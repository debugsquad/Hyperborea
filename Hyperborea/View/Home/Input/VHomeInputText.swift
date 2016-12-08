import UIKit

class VHomeInputText:UITextView, UITextViewDelegate
{
    private weak var controller:CHome!
    let kMaxHeight:CGFloat = 86
    private let kInsetsHorizontal:CGFloat = 15
    private let kMaxFontSize:CGFloat = 25
    
    convenience init(controller:CHome)
    {
        self.init()
        
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
    /*
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let percent:CGFloat = height / kMaxHeight
        let fontSize:CGFloat = percent * kMaxFontSize
        font = UIFont.regular(size:fontSize)
        
        super.layoutSubviews()
    }*/
    
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
