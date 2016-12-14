import UIKit

class VHomeWordsShare:UIButton
{
    private weak var controller:CHome?
    private weak var model:RModelHomeEntriesItem?
    private weak var spinner:UIActivityIndicatorView!
    private weak var image:UIImageView!
    private weak var label:UILabel!
    private let kImageWidth:CGFloat = 20
    private let kLabelWidth:CGFloat = 100
    private let kLabelTop:CGFloat = 4
    private let kImageLeft:CGFloat = 7
    private let kImageRight:CGFloat = 2
    private let kSpinnerWidth:CGFloat = 70
    private let kTitleFontSize:CGFloat = 40
    private let kExportMaxWidth:CGFloat = 600
    private let kExportMaxHeight:CGFloat = 12000
    private let kExportMargin:CGFloat = 30
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(
            self,
            action:#selector(self.actionShare(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let spinner:UIActivityIndicatorView = UIActivityIndicatorView(
            activityIndicatorStyle:UIActivityIndicatorViewStyle.gray)
        spinner.isUserInteractionEnabled = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.stopAnimating()
        self.spinner = spinner
        
        let image:UIImageView = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        image.image = #imageLiteral(resourceName: "assetHomeShare").withRenderingMode(
            UIImageRenderingMode.alwaysTemplate)
        self.image = image
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:14)
        label.text = NSLocalizedString("VHomeWordsShare", comment:"")
        self.label = label
        
        addSubview(image)
        addSubview(label)
        addSubview(spinner)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint(
            item:image,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:image,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:image,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:kImageLeft)
        let layoutImageWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:image,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kImageWidth)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:kLabelTop)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:image,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:kImageRight)
        let layoutLabelWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:label,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kLabelWidth)
        
        let layoutSpinnerTop:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:0)
        let layoutSpinnerBottom:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:0)
        let layoutSpinnerLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        let layoutSpinnerWidth:NSLayoutConstraint = NSLayoutConstraint(
            item:spinner,
            attribute:NSLayoutAttribute.width,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:kSpinnerWidth)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageWidth,
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelWidth,
            layoutSpinnerTop,
            layoutSpinnerBottom,
            layoutSpinnerLeft,
            layoutSpinnerWidth])
        
        hover()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
    
    //MARK: actions
    
    func actionShare(sender button:UIButton)
    {
        guard
            
            let model:RModelHomeEntriesItem = self.model
            
        else
        {
            return
        }
        
        deactivate()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.share(model:model)
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            image.tintColor = UIColor.black
            label.textColor = UIColor.black
        }
        else
        {
            image.tintColor = UIColor.genericBlue
            label.textColor = UIColor.genericBlue
        }
    }
    
    private func share(model:RModelHomeEntriesItem)
    {
        guard
            
            let title:String = controller?.viewHome.viewWords.model?.word
        
        else
        {
            activate()
            return
        }
        
        let titleCount:Int = title.characters.count
        let firstLetter:String = String(title[title.startIndex]).uppercased()
        let remainRange:Range = Range(uncheckedBounds:(
            lower:title.index(title.startIndex, offsetBy:1),
            upper:title.index(title.startIndex, offsetBy:titleCount)))
        let remain:String = title[remainRange].lowercased()
        let attributes:[String:Any] = [
            NSFontAttributeName:UIFont.bold(size:kTitleFontSize),
            NSForegroundColorAttributeName:UIColor.black]
        
        let titleComposite:String = "\(firstLetter)\(remain)\n"
        let titleString:NSAttributedString = NSAttributedString(
            string:titleComposite,
            attributes:attributes)
        
        let completeString:NSMutableAttributedString = NSMutableAttributedString()
        completeString.append(titleString)
        completeString.append(model.attributedString)
        
        let exportMargin2:CGFloat = kExportMargin + kExportMargin
        let stringWidth:CGFloat = kExportMaxWidth - exportMargin2
        let maxSize:CGSize = CGSize(
            width:stringWidth,
            height:kExportMaxHeight)
        let stringHeight:CGFloat = ceil(completeString.boundingRect(
            with:maxSize,
            options:model.options,
            context:nil).size.height)
        let completeHeight:CGFloat = stringHeight + exportMargin2
        let imageRect:CGRect = CGRect(
            x:0,
            y:0,
            width:kExportMaxWidth,
            height:completeHeight)
        let textRect:CGRect = CGRect(
            x:kExportMargin,
            y:kExportMargin,
            width:stringWidth,
            height:stringHeight)
        
        UIGraphicsBeginImageContext(imageRect.size)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
        else
        {
            return
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(imageRect)
         completeString.draw(
         with:textRect,
         options:model.options,
         context:nil)
        
        guard
            
            let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
        else
        {
            UIGraphicsEndImageContext()
            return
        }
        
        UIGraphicsEndImageContext()
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[image],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = self.image
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.present(activity, animated:true)
            self?.activate()
        }
    }
    
    private func deactivate()
    {
        isUserInteractionEnabled = false
        spinner.startAnimating()
        image.isHidden = true
        label.isHidden = true
    }
    
    private func activate()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.isUserInteractionEnabled = true
            self?.spinner.stopAnimating()
            self?.image.isHidden = false
            self?.label.isHidden = false
        }
    }
    
    //MARK: public
    
    func config(controller:CHome, model:RModelHomeEntriesItem)
    {
        self.controller = controller
        self.model = model
        activate()
    }
}
