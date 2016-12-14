import UIKit

class VHomeWordsShare:UIButton
{
    private weak var controller:CHome?
    private weak var model:RModelHomeEntriesItem?
    private weak var spinner:VSpinner!
    private weak var image:UIImageView!
    private weak var label:UILabel!
    private let kImageWidth:CGFloat = 20
    private let kLabelWidth:CGFloat = 100
    private let kLabelTop:CGFloat = 4
    private let kImageLeft:CGFloat = 7
    private let kImageRight:CGFloat = 2
    private let kExportMaxWidth:CGFloat = 600
    private let kExportMargin:CGFloat = 30
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let spinner:VSpinner = VSpinner()
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
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageWidth,
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelWidth])
        
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
        let imageRect:CGRect = CGRect(x:0, y:0, width:500, height:500)
        
        UIGraphicsBeginImageContext(imageRect.size)
        
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
            
            else
        {
            return
        }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(imageRect)/*
         model.attributedString.draw(
         with:imageRect,
         options:model.options,
         context:nil)*/
        
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
            activity.popoverPresentationController!.sourceView = viewHome
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
    
    private func deactivate()
    {
        isUserInteractionEnabled = false
        spinner.startAnimating()
        image.isHidden = true
    }
    
    private func activate()
    {
        isUserInteractionEnabled = true
        spinner.stopAnimating()
        image.isHidden = false
    }
    
    //MARK: public
    
    func config(controller:CHome, model:RModelHomeEntriesItem)
    {
        self.controller = controller
        self.model = model
        activate()
    }
}
