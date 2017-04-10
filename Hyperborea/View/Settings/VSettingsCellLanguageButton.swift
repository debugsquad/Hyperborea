import UIKit

class VSettingsCellLanguageButton:UIButton
{
    init(imageOn:UIImage, imageOff:UIImage)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            imageOn.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.selected)
        setImage(
            imageOn.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        setImage(
            imageOn.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.focused)
        setImage(
            imageOff.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        imageView!.clipsToBounds = true
        imageView!.contentMode = UIViewContentMode.center
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
