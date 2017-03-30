import UIKit

class VSettingsBackground:UIView
{
    private let model:MSettingsBackground
    weak var timer:Timer?
    private let kTimerInterval:TimeInterval = 0.01
    
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
            selector:#selector(timerTick(sender:)),
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
    
    func timerTick(sender timer:Timer)
    {
        model.tick()
    }
}
