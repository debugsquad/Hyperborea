import UIKit

class VSettingsBackground:UIView
{
    private let model:MSettingsBackground
    weak var timer:Timer?
    private let kTimerInterval:TimeInterval = 0.05
    
    init()
    {
        model = MSettingsBackground()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        timer = Timer.scheduledTimer(
            timeInterval:kTimerInterval,
            target:self,
            selector:#selector(actionTick(sender:)),
            userInfo:nil,
            repeats:true)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        timer?.invalidate()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        model.maxWidth = width
        model.maxHeight = height
        
        super.layoutSubviews()
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
            
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        model.draw(context:context)
    }
    
    //MARK: actions
    
    func actionTick(sender timer:Timer)
    {
        model.tick()
        setNeedsDisplay()
    }
}
