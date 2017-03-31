import UIKit

class VSettingsBackground:UIView
{
    private let model:MSettingsBackground
    weak var timer:Timer?
    private let kTimerInterval:TimeInterval = 0.02
    
    init()
    {
        model = MSettingsBackground()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
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
    
    //MARK: public
    
    func startTimer()
    {
        timer?.invalidate()
        model.loadInitial()
        
        DispatchQueue.main.async
        { [weak self] in
            
            guard
                
                let strongSelf:VSettingsBackground = self
            
            else
            {
                return
            }
            
            strongSelf.timer = Timer.scheduledTimer(
                timeInterval:strongSelf.kTimerInterval,
                target:strongSelf,
                selector:#selector(strongSelf.actionTick(sender:)),
                userInfo:nil,
                repeats:true)
        }
    }
}
