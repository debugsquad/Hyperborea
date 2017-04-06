import UIKit

class VSearchContentCellTranslations:VSearchContentCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private let kLabelMarginHorizontal:CGFloat = 10
    private let kLabelBottom:CGFloat = -40
    private let kImageSize:CGFloat = 55
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        self.label = label
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.topToBottom(
            view:label,
            toView:imageView)
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self,
            constant:kLabelBottom)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMarginHorizontal)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.size(
            view:imageView,
            constant:kImageSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CSearch)
    {
        guard
            
            let translations:MSearchTranslations = controller.modelEntry?.translations
        
        else
        {
            return
        }
        
        label.attributedText = translations.attributedString
        imageView.image = translations.language?.imageOn
    }
}
