import UIKit

///CABasicAnimation keypaths take strings, so we created this enum to avoid typing strings everytimeK
enum KeyPath {
    static let backgroundColor = "backgroundColor"
    static let opacity = "opacity"
    static let position = "position"
    static let positionX = "position.x"
    static let positionY = "position.y"
    static let shadowOffset = "shadowOffset"
    static let shadowOpacity = "shadowOpacity"
    static let transformRotation = "transform.rotation"
    static let transformScale = "transform.scale"
}

class CASpringViewController: UIViewController {

    @IBOutlet var teslaLogo: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    let teslaCarImageView = UIImageView(image: UIImage(named: "teslax2"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateLogo()
        animateTextFieldsAndButton()
        animateCarAcrossView()
    }
    
    /// CASpringAnimations
    func animateTextFieldsAndButton() {
        // Create Animation with Springs
        let flyRight = CASpringAnimation(keyPath: KeyPath.positionX)
        flyRight.damping = 250
        flyRight.mass = 50
        flyRight.stiffness = 800
        flyRight.initialVelocity = 1.0
        flyRight.duration = flyRight.settlingDuration
        
        flyRight.fromValue = -view.bounds.size.width/2
        flyRight.toValue = view.bounds.size.width/2
        // Easeout at the end of the transition
        flyRight.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        flyRight.fillMode = CAMediaTimingFillMode.backwards
        
        // 2 Add Animation to the layer
        emailTextField.layer.add(flyRight, forKey: nil)
        flyRight.beginTime = CACurrentMediaTime() + 0.3 // cascade effect
        passwordTextField.layer.add(flyRight, forKey: nil)
        flyRight.beginTime = CACurrentMediaTime() + 0.6 // cascade effect
        loginButton.layer.add(flyRight, forKey: nil)
    }
    
    /// Group Animations: multiple animations at once.
    func animateLogo() {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        groupAnimation.beginTime = CACurrentMediaTime() + 0.5
        groupAnimation.duration = 1.5  //lasts this long
        groupAnimation.fillMode = CAMediaTimingFillMode.backwards
        //Scales from 350% to 100%:
        let scaleDown = CABasicAnimation(keyPath: KeyPath.transformScale)
        scaleDown.fromValue = 3.5
        scaleDown.toValue = 1.0
        //Button rotates:
        let rotate = CABasicAnimation(keyPath: KeyPath.transformRotation)
        rotate.fromValue = CGFloat.pi  ///  / 4
        rotate.toValue = 0
        //Button fades from 0% to 100%
        let fade = CABasicAnimation(keyPath: KeyPath.opacity)
        fade.fromValue = 0.0
        fade.toValue = 1.0
        //Put all 3 animations in the group animation
        groupAnimation.animations = [scaleDown, rotate, fade]
        teslaLogo.layer.add(groupAnimation, forKey: nil)
    }
    
    /// Animate image across screen
    func animateCarAcrossView() {
        teslaCarImageView.frame = CGRect(x: 0.0, y: loginButton.center.y + 200.0,  width: view.frame.size.width, height: 190)
        // Info label will be 30 points under login button
        view.insertSubview(teslaCarImageView, belowSubview: loginButton)
        let flyLeft = CABasicAnimation(keyPath: KeyPath.positionX)
        flyLeft.fromValue = teslaCarImageView.layer.position.x + view.frame.size.width
        //Label stops in the center:
        flyLeft.toValue = teslaCarImageView.layer.position.x
        flyLeft.duration = 4.0
        teslaCarImageView.layer.add(flyLeft, forKey: nil)
        let fadeLabelIn = CABasicAnimation(keyPath: KeyPath.opacity)
        fadeLabelIn.fromValue = 0.0
        fadeLabelIn.toValue = 1.0
        fadeLabelIn.duration = 5.0
        teslaCarImageView.layer.add(fadeLabelIn, forKey: nil)
    }

}
