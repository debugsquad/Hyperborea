import UIKit

class VSearchContentCellTranslations:VSearchContentCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private let kLabelMarginHorizontal:CGFloat = 10
    private let kLabelBottom:CGFloat = -40
    private let kImageHeight:CGFloat = 30
    
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
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        addSubview(imageView)
        addSubview(label)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
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
        NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func config(controller:CSearch)
    {
        label.attributedText = controller.modelEntry?.translations?.attributedString
    }
}
