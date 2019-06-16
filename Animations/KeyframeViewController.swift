import UIKit

class KeyframeViewController: UIViewController {
    
    @IBOutlet var planeImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Key Frame Animations"
    }
    
    func animatePlane() {
        //Store planes center value
        let originalCenter = planeImageView.center
        // Create Key frame animation
        UIView.animateKeyframes(
            withDuration: 1.5, //Whole keyframe animation lasts 1.5 seconds
            delay: 0.0,
            animations: {
                //1) Move plane right/up
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.25,  // Make this keyframe last 25% of the duration
                    animations: {
                        self.planeImageView.center.x += 80.0  //Move plane 80 points right using center property
                        self.planeImageView.center.y -= 10.0  //Move plane 80 points up using center property
                })
                //2) Rotate Plane, in a trailing closure! (after 0.4)
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                    //Note the relativeStart time - We want to slightly overlap with the last animation
                    self.planeImageView.transform = CGAffineTransform(rotationAngle: -.pi / 8)  //rotates plane
                }
                //3) Move plane right and off screen while fading out, in a trailing closure
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                    // Animation starts at 25% of the way in, and lasts for 25% of the total animation
                    self.planeImageView.center.x += 100.0 //Plane right 100 points
                    self.planeImageView.center.y -= 50.0  //Plane up 50 points
                    self.planeImageView.alpha = 0.0  // Plane fades out
                }
                //4) Set plane just left off the screen
                UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                    self.planeImageView.transform = .identity  //Use identity to reset the transform
                    self.planeImageView.center = CGPoint(x: 0.0, y: originalCenter.y)  //Reset places center position
                }
                //5) Move plane back to original position and fade in
                UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                    self.planeImageView.alpha = 1.0
                    self.planeImageView.center = originalCenter
                }
        }, completion: nil)
    }
    
    @IBAction func animatePlaneButtonTapped(_ sender: UIButton) {
        animatePlane()
        //secondPlaneAnimation()
    }
    
}
