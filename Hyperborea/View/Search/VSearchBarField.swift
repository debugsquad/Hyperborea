import UIKit

class VSearchBarField:UITextField, UITextFieldDelegate
{
    private weak var controller:CSearch!
    private let kFontMaxSize:CGFloat = 30
    private let kFontMinSize:CGFloat = 15
    
    init(controller:CSearch)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        textColor = UIColor.black
        tintColor = UIColor.black
        clearButtonMode = UITextFieldViewMode.always
        autocorrectionType = UITextAutocorrectionType.no
        autocapitalizationType = UITextAutocapitalizationType.sentences
        spellCheckingType = UITextSpellCheckingType.no
        borderStyle = UITextBorderStyle.none
        keyboardType = UIKeyboardType.alphabet
        keyboardAppearance = UIKeyboardAppearance.light
        returnKeyType = UIReturnKeyType.done
        placeholder = NSLocalizedString("VSearchBarField_placeholder", comment:"")
        delegate = self
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let maxHeight:CGFloat = controller.viewSearch.kBarMaxHeight
        let barTop:CGFloat = controller.viewSearch.viewBar.kFieldTop
        let usableMaxHeight:CGFloat = maxHeight - barTop
        let currentHeight:CGFloat = bounds.maxY
        let fontSize:CGFloat
        
        if currentHeight < usableMaxHeight
        {
            let deltaHeight:CGFloat = (usableMaxHeight - currentHeight) / 3.0
            let deltaFont:CGFloat = kFontMaxSize - deltaHeight
            
            if deltaFont > kFontMinSize
            {
                fontSize = deltaFont
            }
            else
            {
                fontSize = kFontMinSize
            }
        }
        else
        {
            fontSize = kFontMaxSize
        }
        
        font = UIFont.regular(size:fontSize)
        
        super.layoutSubviews()
    }
    
    //MARK: textField delegate
    
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        controller.viewSearch.viewBar.beginEditing()
    }
    
    func textFieldDidEndEditing(_ textField:UITextField)
    {
        controller.viewSearch.viewBar.endEditing()
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}
