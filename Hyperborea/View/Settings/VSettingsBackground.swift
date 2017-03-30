import UIKit

class VSettingsBackground:UIView
{
    private let model:MSettingsBackground
    weak var timer:Timer?
    
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
    
    func timerTick(sender timer:Timer)
    {
        model.tick()
    }
}
