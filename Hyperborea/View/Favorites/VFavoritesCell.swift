import UIKit

class VFavoritesCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var imageView:UIImageView!
    private let kLabelRight:CGFloat = -10
    private let kImageWidth:CGFloat = 32
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:17)
        label.numberOfLines = 2
        self.label = label
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        NSLayoutConstraint.equalsVertical(
            view:imageView,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.width(
            view:imageView,
            constant:kImageWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:imageView)
        NSLayoutConstraint.rightToRight(
            view:label,
            toView:self,
            constant:kLabelRight)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected
        {
            backgroundColor = UIColor.hyperBlue
            label.textColor = UIColor.white
        }
        else
        {
            backgroundColor = UIColor.white
            label.textColor = UIColor.black
        }
    }
    
    private func loadSquare(languageRaw:Int16)
    {
        let language:MLanguage = MLanguage.language(rawValue:languageRaw)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.imageView.image = language.imageSquare
        }
    }
    
    //MARK: public
    
    func config(model:MFavoritesItem)
    {
        label.text = model.word
        hover()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadSquare(languageRaw:model.languageRaw)
        }
    }
}
