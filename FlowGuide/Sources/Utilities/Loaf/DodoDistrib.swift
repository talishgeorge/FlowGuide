import UIKit

class FBButtonView: UIImageView {
    private let style: FBButtonStyle
    weak var delegate: FBButtonViewDelegate?
    var onTap: OnTap?
    
    init(style: FBButtonStyle) {
        self.style = style
        
        super.init(frame: CGRect())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Create button views for given button styles.
    static func createMany(_ styles: [FBButtonStyle]) -> [FBButtonView] {
        
        if !haveButtons(styles) { return [] }
        
        return styles.map { style in
            let view = FBButtonView(style: style)
            view.setup()
            return view
        }
    }
    
    static func haveButtons(_ styles: [FBButtonStyle]) -> Bool {
        let hasImages = !styles.filter({ $0.image != nil }).isEmpty
        let hasIcons = !styles.filter({ $0.icon != nil }).isEmpty
        
        return hasImages || hasIcons
    }
    
    func doLayout(onLeftSide: Bool) {
        precondition(delegate != nil, "Button view delegate can not be nil")
        translatesAutoresizingMaskIntoConstraints = false
        
        // Set button's size
        TegAutolayoutConstraints.width(self, value: style.size.width)
        TegAutolayoutConstraints.height(self, value: style.size.height)
        
        if let superview = superview {
            let alignAttribute = onLeftSide ? NSLayoutConstraint.Attribute.left : NSLayoutConstraint.Attribute.right
            
            let marginHorizontal = onLeftSide ? style.horizontalMarginToBar : -style.horizontalMarginToBar
            
            // Align the button to the left/right of the view
            TegAutolayoutConstraints.alignSameAttributes(self,
                                                         toItem: superview,
                                                         constraintContainer: superview,
                                                         attribute: alignAttribute,
                                                         margin: marginHorizontal)
            
            // Center the button verticaly
            TegAutolayoutConstraints.centerY(self, viewTwo: superview, constraintContainer: superview)
        }
    }
    
    func setup() {
        if let image = FBButtonView.image(style) { applyStyle(image) }
        setupTap()
    }
    
    /// Increase the hitsize of the image view if it's less than 44px for easier tapping.
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let oprimizedBounds = FBTouchTarget.optimize(bounds)
        return oprimizedBounds.contains(point)
    }
    
    /// Returns the image supplied by user or create one from the icon
    class func image(_ style: FBButtonStyle) -> UIImage? {
        if style.image != nil {
            return style.image
        }
        
        if let icon = style.icon {
            let bundle = Bundle(for: self)
            let imageName = icon.rawValue
            
            return UIImage(named: imageName, in: bundle, compatibleWith: nil)
        }
        
        return nil
    }
    
    private func applyStyle(_ imageIn: UIImage) {
        var imageToShow = imageIn
        if let tintColorToShow = style.tintColor {
            // Replace image colors with the specified tint color
            imageToShow = imageToShow.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            tintColor = tintColorToShow
        }
        
        layer.minificationFilter = CALayerContentsFilter.trilinear // make the image crisp
        image = imageToShow
        contentMode = UIView.ContentMode.scaleAspectFit
        
        // Make button accessible
        if let accessibilityLabelToShow = style.accessibilityLabel {
            isAccessibilityElement = true
            accessibilityLabel = accessibilityLabelToShow
            accessibilityTraits = UIAccessibilityTraits.button
        }
    }
    
    private func setupTap() {
        onTap = OnTap(view: self, gesture: UITapGestureRecognizer()) { [weak self] in
            self?.didTap()
        }
    }
    
    private func didTap() {
        self.delegate?.buttonDelegateDidTap(self.style)
        style.onTap?()
    }
}

protocol FBButtonViewDelegate: class {
    func buttonDelegateDidTap(_ buttonStyle: FBButtonStyle)
}

/// A closure that is called when a bar button is tapped
public typealias FBButtonOnTap = () -> Void

/**
 
 Coordinates the process of showing and hiding of the message bar.
 
 The instance is created automatically in the `FBLoaf` property of any UIView instance.
 It is not expected to be instantiated manually anywhere except unit tests.
 
 For example:
 
 let view = UIView()
 view.FBLoaf.info("Horses are blue?")
 
 */
public protocol FBLoafInterface: class {  
    /**
     Specify optional anchor for positioning the bar view.
     This can be an anchor from the safe area.
     */
    var topAnchor: NSLayoutYAxisAnchor? { get set }
    
    /**
     Specify optional anchor for positioning the bar view.
     This can be an anchor from the safe area.
     */
    var bottomAnchor: NSLayoutYAxisAnchor? { get set }
    
    /// Specify optional layout guide for positioning the bar view.
    @available(*, deprecated, message: "use topAnchor instead")
    var topLayoutGuide: UILayoutSupport? { get set }
    
    /// Specify optional layout guide for positioning the bar view.
    @available(*, deprecated, message: "use bottomAnchor instead")
    var bottomLayoutGuide: UILayoutSupport? { get set }
    
    /// Defines styles for the bar.
    var style: FBLoafStyle { get set }
    
    /// Changes the style preset for the bar widget.
    var preset: FBPresets { get set }
    
    /**
     
     Shows the message bar with *.success* preset. It can be used to indicate successful completion of an operation.
     
     - parameter message: The text message to be shown.
     
     */
    func success(_ message: String)
    
    /**
     
     Shows the message bar with *.Info* preset. It can be used for showing information messages that have neutral emotional value.
     
     - parameter message: The text message to be shown.
     
     */
    func info(_ message: String)
    
    /**
     
     Shows the message bar with *.warning* preset. It can be used for for showing warning messages.
     
     - parameter message: The text message to be shown.
     
     */
    func warning(_ message: String)
    
    /**
     
     Shows the message bar with *.warning* preset. It can be used for showing critical error messages
     
     - parameter message: The text message to be shown.
     
     */
    func error(_ message: String)
    
    /**
     
     Shows the message bar. Set `preset` property to change the appearance of the message bar, or use the shortcut methods: `success`, `info`, `warning` and `error`.
     
     - parameter message: The text message to be shown.
     
     */
    func show(_ message: String)
    
    /// Hide the message bar if it's currently shown.
    func hide()
}

/**
 
 Main class that coordinates the process of showing and hiding of the message bar.
 
 Instance of this class is created automatically in the `FBLoaf` property of any UIView instance.
 It is not expected to be instantiated manually anywhere except unit tests.
 
 For example:
 
 let view = UIView()
 view.FBLoaf.info("Horses are blue?")
 
 */
final class FBLoaf: FBLoafInterface, FBButtonViewDelegate {
    private weak var superview: UIView!
    private var hideTimer: MoaTimer?
    
    // Gesture handler that hides the bar when it is tapped
    var onTap: OnTap?
    
    /**
     Specify optional anchor for positioning the bar view.
     This can be an anchor from the safe area.
     */
    var topAnchor: NSLayoutYAxisAnchor?
    
    /**
     Specify optional anchor for positioning the bar view.
     This can be an anchor from the safe area.
     */
    var bottomAnchor: NSLayoutYAxisAnchor?
    
    /// Specify optional layout guide for positioning the bar view. Deprecated, use bottomAnchor instead.
    @available(*, deprecated, message: "use topAnchor instead")
    var topLayoutGuide: UILayoutSupport? {
        set { self.topAnchor = newValue?.bottomAnchor }
        get { return nil }
    }
    
    /// Specify optional layout guide for positioning the bar view. Deprecated, use bottomAnchor instead.
    @available(*, deprecated, message: "use bottomAnchor instead")
    var bottomLayoutGuide: UILayoutSupport? {
        set { self.bottomAnchor = newValue?.topAnchor }
        get { return nil }
    }
    
    /// Defines styles for the bar.
    var style = FBLoafStyle(parentStyle: FBPresets.defaultPreset.style)
    
    /// Creates an instance of FBLoaf class
    init(superview: UIView) {
        self.superview = superview
        
        FBLoafKeyboardListener.startListening()
    }
    
    /// Changes the style preset for the bar widget.
    var preset: FBPresets = FBPresets.defaultPreset {
        didSet {
            if preset != oldValue {
                style.parent = preset.style
            }
        }
    }
    
    /**
     
     Shows the message bar with *.success* preset. It can be used to indicate successful completion of an operation.
     
     - parameter message: The text message to be shown.
     
     */
    func success(_ message: String) {
        preset = .success
        show(message)
    }
    
    /**
     
     Shows the message bar with *.Info* preset. It can be used for showing information messages that have neutral emotional value.
     
     - parameter message: The text message to be shown.
     
     */
    func info(_ message: String) {
        preset = .info
        show(message)
    }
    
    /**
     
     Shows the message bar with *.warning* preset. It can be used for for showing warning messages.
     
     - parameter message: The text message to be shown.
     
     */
    func warning(_ message: String) {
        preset = .warning
        show(message)
    }
    
    /**
     
     Shows the message bar with *.warning* preset. It can be used for showing critical error messages
     
     - parameter message: The text message to be shown.
     
     */
    func error(_ message: String) {
        preset = .error
        show(message)
    }
    
    /**
     
     Shows the message bar. Set `preset` property to change the appearance of the message bar, or use the shortcut methods: `success`, `info`, `warning` and `error`.
     
     - parameter message: The text message to be shown.
     
     */
    func show(_ message: String) {
        removeExistingBars()
        setupHideTimer()
        
        let bar = SBToolbar(witStyle: style)
        setupHideOnTap(bar)
        bar.anchor = style.bar.locationTop ? topAnchor: bottomAnchor
        bar.buttonViewDelegate = self
        bar.show(inSuperview: superview, withMessage: message)
    }
    
    /// Hide the message bar if it's currently shown.
    func hide() {
        hideTimer?.cancel()
        
        toolbar?.hide({})
    }
    
    func listenForKeyboard() {
        
    }
    
    private var toolbar: SBToolbar? {
        superview.subviews.filter { $0 is SBToolbar }.map { ($0 as? SBToolbar)! }.first
    }
    
    private func removeExistingBars() {
        for view in superview.subviews {
            if let existingToolbar = view as? SBToolbar {
                existingToolbar.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Hiding after delay
    
    private func setupHideTimer() {
        hideTimer?.cancel()
        
        if style.bar.hideAfterDelaySeconds > 0 {
            hideTimer = MoaTimer.runAfter(style.bar.hideAfterDelaySeconds) { [weak self] _ in
                
                DispatchQueue.main.async {
                    self?.hide()
                }
            }
        }
    }
    
    // MARK: - Reacting to tap
    
    private func setupHideOnTap(_ toolbar: UIView) {
        onTap = OnTap(view: toolbar, gesture: UITapGestureRecognizer()) { [weak self] in
            self?.didTapTheBar()
        }
    }
    
    /// The bar has been tapped
    private func didTapTheBar() {
        style.bar.onTap?()
        
        if style.bar.hideOnTap {
            hide()
        }
    }
    
    // MARK: - FBLoafButtonViewDelegate
    
    func buttonDelegateDidTap(_ buttonStyle: FBButtonStyle) {
        if buttonStyle.hideOnTap {
            hide()
        }
    }
}
/**
 
 Contains information about the message that was displayed in message bar. Used in unit tests.
 
 */
struct FBLoafMockMessage {
    let preset: FBPresets
    let message: String
}

public class FBLoafMock: FBLoafInterface {
    /// This property is used in unit tests to verify which messages were displayed in the message bar.
    public var results = FBLoafMockResults()
    
    /**
     Specify optional anchor for positioning the bar view.
     This can be an anchor from the safe area.
     */
    public var topAnchor: NSLayoutYAxisAnchor?
    
    /**
     Specify optional anchor for positioning the bar view.
     This can be an anchor from the safe area.
     */
    public var bottomAnchor: NSLayoutYAxisAnchor?
    
    /// Specify optional layout guide for positioning the bar view. Deprecated, use bottomAnchor instead.
    @available(*, deprecated, message: "Use topAnchor instead")
    public var topLayoutGuide: UILayoutSupport? {
        set { self.topAnchor = newValue?.bottomAnchor }
        get { return nil }
    }
    
    /// Specify optional layout guide for positioning the bar view. Deprecated, use bottomAnchor instead.
    @available(*, deprecated, message: "Use bottomAnchor instead")
    public var bottomLayoutGuide: UILayoutSupport? {
        set { self.topAnchor = newValue?.bottomAnchor }
        get { return nil }
    }
    
    /// Defines styles for the bar.
    public var style = FBLoafStyle(parentStyle: FBPresets.defaultPreset.style)
    
    /// Creates an instance of FBLoafMock class
    public init() { }
    
    /// Changes the style preset for the bar widget.
    public var preset: FBPresets = FBPresets.defaultPreset {
        didSet {
            if preset != oldValue {
                style.parent = preset.style
            }
        }
    }
    
    /**
     
     Shows the message bar with *.success* preset. It can be used to indicate successful completion of an operation.
     
     - parameter message: The text message to be shown.
     
     */
    public func success(_ message: String) {
        preset = .success
        show(message)
    }
    
    /**
     
     Shows the message bar with *.Info* preset. It can be used for showing information messages that have neutral emotional value.
     
     - parameter message: The text message to be shown.
     
     */
    public func info(_ message: String) {
        preset = .info
        show(message)
    }
    
    /**
     
     Shows the message bar with *.warning* preset. It can be used for for showing warning messages.
     
     - parameter message: The text message to be shown.
     
     */
    public func warning(_ message: String) {
        preset = .warning
        show(message)
    }
    
    /**
     
     Shows the message bar with *.warning* preset. It can be used for showing critical error messages
     
     - parameter message: The text message to be shown.
     
     */
    public func error(_ message: String) {
        preset = .error
        show(message)
    }
    
    /**
     
     Shows the message bar. Set `preset` property to change the appearance of the message bar, or use the shortcut methods: `success`, `info`, `warning` and `error`.
     
     - parameter message: The text message to be shown.
     
     */
    public func show(_ message: String) {
        let mockMessage = FBLoafMockMessage(preset: preset, message: message)
        results.messages.append(mockMessage)
        results.visible = true
    }
    
    /// Hide the message bar if it's currently shown.
    public func hide() {
        results.visible = false
    }
}
/**
 
 Used in unit tests to verify the messages that were shown in the message bar.
 
 */
public struct FBLoafMockResults {
    /// An array of success messages displayed in the message bar.
    public var success: [String] {
        return messages.filter({ $0.preset == FBPresets.success }).map({ $0.message })
    }
    
    /// An array of information messages displayed in the message bar.
    public var info: [String] {
        return messages.filter({ $0.preset == FBPresets.info }).map({ $0.message })
    }
    
    /// An array of warning messages displayed in the message bar.
    public var warning: [String] {
        return messages.filter({ $0.preset == FBPresets.warning }).map({ $0.message })
    }
    
    /// An array of error messages displayed in the message bar.
    public var errors: [String] {
        return messages.filter({ $0.preset == FBPresets.error }).map({ $0.message })
    }
    
    /// Total number of messages shown.
    public var total: Int {
        return messages.count
    }
    
    /// Indicates whether the message is visible
    public var visible = false
    
    var messages = [FBLoafMockMessage]()
}

/// Collection of animation effects use for hiding the notification bar.
struct FBLoafAnimationsHide {
    /**
     
     Animation that rotates the bar around X axis in perspective with spring effect.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func rotate(_ view: UIView,
                       duration: TimeInterval?,
                       locationTop: Bool,
                       completed: @escaping FBLoafAnimationCompleted) {
        FBLoafAnimations.doRotate(duration,
                                  showView: false,
                                  view: view,
                                  completed: completed)
    }
    
    /**
     
     Animation that swipes the bar from to the left with fade-in effect.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func slideLeft(_ view: UIView,
                          duration: TimeInterval?,
                          locationTop: Bool,
                          completed: @escaping FBLoafAnimationCompleted) {
        FBLoafAnimations.doSlide(duration, right: false, showView: false, view: view, completed: completed)
    }
    
    /**
     
     Animation that swipes the bar to the right with fade-out effect.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func slideRight(_ view: UIView,
                           duration: TimeInterval?,
                           locationTop: Bool,
                           completed: @escaping FBLoafAnimationCompleted) {
        
        FBLoafAnimations.doSlide(duration, right: true, showView: false, view: view, completed: completed)
    }
    
    /**
     
     Animation that fades the bar out.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func fade(_ view: UIView,
                     duration: TimeInterval?,
                     locationTop: Bool,
                     completed: @escaping FBLoafAnimationCompleted) {
        
        FBLoafAnimations.doFade(duration, showView: false, view: view, completed: completed)
    }
    
    /**
     
     Animation that slides the bar vertically out of view.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func slideVertically(_ view: UIView,
                                duration: TimeInterval?,
                                locationTop: Bool,
                                completed: @escaping FBLoafAnimationCompleted) {
        
        FBLoafAnimations.doSlideVertically(duration,
                                         showView: false,
                                         view: view,
                                         locationTop: locationTop, completed: completed)
    }
}
/// Collection of animation effects use for showing and hiding the notification bar.
public enum FBLoafAnimations: String {
    /// Animation that fades the bar in/out.
    case fade = "Fade"
    
    /// Used for showing notification without animation.
    case noAnimation = "No animation"
    
    /// Animation that rotates the bar around X axis in perspective with spring effect.
    case rotate = "Rotate"
    
    /// Animation that swipes the bar to/from the left with fade effect.
    case slideLeft = "Slide left"
    
    /// Animation that swipes the bar to/from the right with fade effect.
    case slideRight = "Slide right"
    
    /// Animation that slides the bar in/out vertically.
    case slideVertically = "Slide vertically"
    
    /**
     
     Get animation function that can be used for showing notification bar.
     
     - returns: Animation function.
     
     */
    public var show: FBLoafAnimation {
        switch self {
        case .fade:
            return FBLoafAnimationsShow.fade
            
        case .noAnimation:
            return FBLoafAnimations.doNoAnimation
            
        case .rotate:
            return FBLoafAnimationsShow.rotate
            
        case .slideLeft:
            return FBLoafAnimationsShow.slideLeft
            
        case .slideRight:
            return FBLoafAnimationsShow.slideRight
            
        case .slideVertically:
            return FBLoafAnimationsShow.slideVertically
        }
    }
    
    /**
     
     Get animation function that can be used for hiding notification bar.
     
     - returns: Animation function.
     
     */
    public var hide: FBLoafAnimation {
        switch self {
        case .fade:
            return FBLoafAnimationsHide.fade
            
        case .noAnimation:
            return FBLoafAnimations.doNoAnimation
            
        case .rotate:
            return FBLoafAnimationsHide.rotate
            
        case .slideLeft:
            return FBLoafAnimationsHide.slideLeft
            
        case .slideRight:
            return FBLoafAnimationsHide.slideRight
            
        case .slideVertically:
            return FBLoafAnimationsHide.slideVertically
        }
    }
    
    /**
     
     A empty animator which is used when no animation is supplied.
     It simply calls the completion closure.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func doNoAnimation(_ view: UIView,
                              duration: TimeInterval?,
                              locationTop: Bool,
                              completed: FBLoafAnimationCompleted) {
        completed()
    }
    
    /// Helper function for fading the view in and out.
    static func doFade(_ duration: TimeInterval?,
                       showView: Bool,
                       view: UIView,
                       completed: @escaping FBLoafAnimationCompleted) {
        
        let actualDuration = duration ?? 0.5
        let startAlpha: CGFloat = showView ? 0 : 1
        let endAlpha: CGFloat = showView ? 1 : 0
        view.alpha = startAlpha
        UIView.animate(withDuration: actualDuration,
                       animations: {
                        view.alpha = endAlpha
        },
                       completion: { _ in
                        completed()
        }
        )
    }
    
    /// Helper function for sliding the view vertically
    static func doSlideVertically(_ duration: TimeInterval?,
                                  showView: Bool,
                                  view: UIView,
                                  locationTop: Bool,
                                  completed: @escaping FBLoafAnimationCompleted) {
        
        let actualDuration = duration ?? 0.5
        view.layoutIfNeeded()
        
        var distance: CGFloat = 0
        
        if locationTop {
            distance = view.frame.height + view.frame.origin.y
        } else {
            distance = UIScreen.main.bounds.height - view.frame.origin.y
        }
        
        let transform = CGAffineTransform(translationX: 0, y: locationTop ? -distance : distance)
        
        let start: CGAffineTransform = showView ? transform : CGAffineTransform.identity
        let end: CGAffineTransform = showView ? CGAffineTransform.identity : transform
        
        view.transform = start
        
        UIView.animate(withDuration: actualDuration,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: {
                        view.transform = end
        },
                       completion: { _ in
                        completed()
        }
        )
    }
    
    static weak var timer: MoaTimer?
    
    /// Animation that rotates the bar around X axis in perspective with spring effect.
    static func doRotate(_ duration: TimeInterval?, showView: Bool, view: UIView, completed: @escaping FBLoafAnimationCompleted) {
        
        let actualDuration = duration ?? 2.0
        let start: Double = showView ? Double(Double.pi / 2) : 0
        let end: Double = showView ? 0 : Double(Double.pi / 2)
        let damping = showView ? 0.85 : 3
        
        let myCALayer = view.layer
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/200.0
        myCALayer.transform = CATransform3DRotate(transform, CGFloat(end), 1, 0, 0)
        myCALayer.zPosition = 300
        
        SpringAnimationCALayer.animate(myCALayer,
                                       keypath: "transform.rotation.x",
                                       duration: actualDuration,
                                       usingSpringWithDamping: damping,
                                       initialSpringVelocity: 1,
                                       fromValue: start,
                                       toValue: end,
                                       onFinished: showView ? completed : nil)
        
        // Hide the bar prematurely for better looks
        timer?.cancel()
        if !showView {
            timer = MoaTimer.runAfter(0.3) { _ in
                completed()
            }
        }
    }
    
    /// Animation that swipes the bar to the right with fade-out effect.
    static func doSlide(_ duration: TimeInterval?,
                        right: Bool,
                        showView: Bool,
                        view: UIView,
                        completed: @escaping FBLoafAnimationCompleted) {
        
        let actualDuration = duration ?? 0.4
        let distance = UIScreen.main.bounds.width
        let transform = CGAffineTransform(translationX: right ? distance : -distance, y: 0)
        
        let start: CGAffineTransform = showView ? transform : CGAffineTransform.identity
        let end: CGAffineTransform = showView ? CGAffineTransform.identity : transform
        
        let alphaStart: CGFloat = showView ? 0.2 : 1
        let alphaEnd: CGFloat = showView ? 1 : 0.2
        
        view.transform = start
        view.alpha = alphaStart
        
        UIView.animate(withDuration: actualDuration,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                        view.transform = end
                        view.alpha = alphaEnd
        },
                       completion: { _ in
                        completed()
        }
        )
    }
}

/// Collection of animation effects use for showing the notification bar.
struct FBLoafAnimationsShow {
    /**
     
     Animation that rotates the bar around X axis in perspective with spring effect.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func rotate(_ view: UIView,
                       duration: TimeInterval?,
                       locationTop: Bool,
                       completed: @escaping FBLoafAnimationCompleted) {
        
        FBLoafAnimations.doRotate(duration, showView: true, view: view, completed: completed)
    }
    
    /**
     
     Animation that swipes the bar from the left with fade-in effect.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func slideLeft(_ view: UIView,
                          duration: TimeInterval?,
                          locationTop: Bool,
                          completed: @escaping FBLoafAnimationCompleted) {
        FBLoafAnimations.doSlide(duration, right: false, showView: true, view: view, completed: completed)
    }
    
    /**
     
     Animation that swipes the bar from the right with fade-in effect.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func slideRight(_ view: UIView,
                           duration: TimeInterval?,
                           locationTop: Bool,
                           completed: @escaping FBLoafAnimationCompleted) {
        FBLoafAnimations.doSlide(duration, right: true, showView: true, view: view, completed: completed)
    }
    
    /**
     
     Animation that fades the bar in.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func fade(_ view: UIView,
                     duration: TimeInterval?,
                     locationTop: Bool,
                     completed: @escaping FBLoafAnimationCompleted) {
        FBLoafAnimations.doFade(duration, showView: true, view: view, completed: completed)
    }
    
    /**
     
     Animation that slides the bar in/out vertically.
     
     - parameter view: View supplied for animation.
     - parameter completed: A closure to be called after animation completes.
     
     */
    static func slideVertically(_ view: UIView,
                                duration: TimeInterval?,
                                locationTop: Bool,
                                completed: @escaping FBLoafAnimationCompleted) {
        FBLoafAnimations.doSlideVertically(duration,
                                         showView: true,
                                         view: view,
                                         locationTop: locationTop,
                                         completed: completed)
    }
}

/// A closure that is called for animation of the bar when it is being shown or hidden.
public typealias FBLoafAnimation = (UIView,
    _ duration: TimeInterval?,
    _ locationTop: Bool,
    _ completed: @escaping FBLoafAnimationCompleted) -> Void

/// A closure that is called by the animator when animation has finished.
public typealias FBLoafAnimationCompleted = () -> Void

/**
 Creates a timer that executes code after delay.
 
 Usage
 
 var timer: MoaTimer.runAfter?
 ...
 
 func myFunc() {
 timer = MoaTimer.runAfter(0.010) { timer in
 ... code to run
 }
 }
 
 Canceling the timer
 
 Timer is Canceling automatically when it is deallocated. You can also cancel it manually:
 
 let timer = MoaTimer.runAfter(0.010) { timer in ... }
 timer.cancel()
 
 */
final class MoaTimer: NSObject {
    private let repeats: Bool
    private var timer: Timer?
    private var callback: ((MoaTimer) -> Void )?
    private init(interval: TimeInterval, repeats: Bool = false, callback: @escaping (MoaTimer) -> Void ) {
        self.repeats = repeats
        super.init()
        self.callback = callback
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(MoaTimer.timerFired(_:)),
                                     userInfo: nil, repeats: repeats)
    }
    
    /// Timer is cancelled automatically when it is deallocated.
    deinit {
        cancel()
    }
    
    /**
     
     Cancels the timer and prevents it from firing in the future.
     Note that timer is cancelled automatically whe it is deallocated.
     */
    func cancel() {
        timer?.invalidate()
        timer = nil
    }
    
    /**
     
     Runs the closure after specified time interval.
     - parameter interval: Time interval in milliseconds.
     :repeats: repeats When true, the code is run repeatedly.
     - returns: callback A closure to be run by the timer.
     
     */
    @discardableResult
    class func runAfter(_ interval: TimeInterval,
                        repeats: Bool = false,
                        callback: @escaping (MoaTimer) -> Void ) -> MoaTimer {
        
        return MoaTimer(interval: interval, repeats: repeats, callback: callback)
    }
    
    @objc func timerFired(_ timer: Timer) {
        self.callback?(self)
        if !repeats { cancel() }
    }
}

/**
 Adjusts the length (constant value) of the bottom layout constraint when keyboard shows and hides.
 */
@objc public class UnderKeyboardLayoutConstraint: NSObject {
    private weak var bottomLayoutConstraint: NSLayoutConstraint?
    private var keyboardObserver = UnderKeyboardObserver()
    private var initialConstraintConstant: CGFloat = 0
    private var minMargin: CGFloat = 10
    
    private var viewToAnimate: UIView?
    
    /// Creates an instance of the class
    public override init() {
        super.init()
        
        keyboardObserver.willAnimateKeyboard = { [weak self] height in
            self?.keyboardWillAnimate(height)
        }
        keyboardObserver.animateKeyboard = { [weak self] height in
            self?.animateKeyboard(height)
        }
        
        keyboardObserver.start()
    }
    
    deinit {
        stop()
    }
    
    /// Stop listening for keyboard notifications.
    public func stop() {
        keyboardObserver.stop()
    }
    
    /**
     
     Supply a bottom Auto Layout constraint. Its constant value will be adjusted by the height of the keyboard when it appears and hides.
     
     - parameter bottomLayoutConstraint: Supply a bottom layout constraint. Its constant value will be adjusted when keyboard is shown and hidden.
     
     - parameter view: Supply a view that will be used to animate the constraint. It is usually the superview containing the view with the constraint.
     
     - parameter minMargin: Specify the minimum margin between the keyboard and the bottom of the view the constraint is attached to. Default: 10.
     
     */
    public func setup(_ bottomLayoutConstraint: NSLayoutConstraint,
                      view: UIView,
                      minMargin: CGFloat = 10) {
        
        initialConstraintConstant = bottomLayoutConstraint.constant
        self.bottomLayoutConstraint = bottomLayoutConstraint
        self.minMargin = minMargin
        self.viewToAnimate = view
        
        // Keyboard is already open when setup is called
        if let currentKeyboardHeight = keyboardObserver.currentKeyboardHeight, currentKeyboardHeight > 0 {
            keyboardWillAnimate(currentKeyboardHeight)
        }
    }
    
    func keyboardWillAnimate(_ height: CGFloat) {
        guard let bottomLayoutConstraint = bottomLayoutConstraint else { return }
        if height > 0 {
            let newConstantValue = height + minMargin
            
            if newConstantValue > initialConstraintConstant {
                // Keyboard height is bigger than the initial constraint length.
                // Increase constraint length.
                bottomLayoutConstraint.constant = newConstantValue
            } else {
                // Keyboard height is NOT bigger than the initial constraint length.
                // Show the initial constraint length.
                bottomLayoutConstraint.constant = initialConstraintConstant
            }
            
        } else {
            bottomLayoutConstraint.constant = initialConstraintConstant
        }
    }
    
    func animateKeyboard(_ height: CGFloat) {
        guard let viewToAnimate = viewToAnimate else { return }
        
        // Check if view is shown, otherwise layoutIfNeeded() will crash
        if viewToAnimate.window != nil {
            viewToAnimate.layoutIfNeeded()
        }
    }
}

/**
 Detects appearance of software keyboard and calls the supplied closures that can be used for changing the layout and moving view from under the keyboard.
 */
public final class UnderKeyboardObserver: NSObject {
    public typealias AnimationCallback = (_ height: CGFloat) -> Void
    
    let notificationCenter: NotificationCenter
    
    /// Function that will be called before the keyboard is shown and before animation is started.
    public var willAnimateKeyboard: AnimationCallback?
    
    /// Function that will be called inside the animation block. This can be used to call `layoutIfNeeded` on the view.
    public var animateKeyboard: AnimationCallback?
    
    /// Current height of the keyboard. Has value `nil` if unknown.
    public var currentKeyboardHeight: CGFloat?
    
    /// Creates an instance of the class
    public override init() {
        notificationCenter = NotificationCenter.default
        super.init()
    }
    
    deinit {
        stop()
    }
    
    /// Start listening for keyboard notifications.
    public func start() {
        stop()
        
        notificationCenter.addObserver(self, selector: #selector(UnderKeyboardObserver.keyboardNotification(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(UnderKeyboardObserver.keyboardNotification(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Stop listening for keyboard notifications.
    public func stop() {
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notification
    
    @objc func keyboardNotification(_ notification: Notification) {
        let isShowing = notification.name == UIResponder.keyboardWillShowNotification
        
        if let userInfo = (notification as NSNotification).userInfo,
            let height = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            
            let correctedHeight = isShowing ? height : 0
            willAnimateKeyboard?(correctedHeight)
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: UIView.AnimationOptions(rawValue: animationCurveRawNSN.uintValue),
                           animations: { [weak self] in
                            self?.animateKeyboard?(correctedHeight)
                },
                           completion: nil
            )
            
            currentKeyboardHeight = correctedHeight
        }
    }
}

class SpringAnimationCALayer {
    // Animates layer with spring effect.
    class func animate(_ layer: CALayer,
                       keypath: String,
                       duration: CFTimeInterval,
                       usingSpringWithDamping: Double,
                       initialSpringVelocity: Double,
                       fromValue: Double,
                       toValue: Double,
                       onFinished: (() -> Void)?) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(onFinished)
        
        let animation = create(keypath, duration: duration,
                               usingSpringWithDamping: usingSpringWithDamping,
                               initialSpringVelocity: initialSpringVelocity,
                               fromValue: fromValue, toValue: toValue)
        
        layer.add(animation, forKey: keypath + " spring animation")
        CATransaction.commit()
    }
    
    // Creates CAKeyframeAnimation object
    class func create(_ keypath: String,
                      duration: CFTimeInterval,
                      usingSpringWithDamping: Double,
                      initialSpringVelocity: Double,
                      fromValue: Double,
                      toValue: Double) -> CAKeyframeAnimation {
        
        let dampingMultiplier = Double(10)
        let velocityMultiplier = Double(10)
        
        let values = animationValues(fromValue, toValue: toValue,
                                     usingSpringWithDamping: dampingMultiplier * usingSpringWithDamping,
                                     initialSpringVelocity: velocityMultiplier * initialSpringVelocity)
        
        let animation = CAKeyframeAnimation(keyPath: keypath)
        animation.values = values
        animation.duration = duration
        
        return animation
    }
    
    class func animationValues(_ fromValue: Double,
                               toValue: Double,
                               usingSpringWithDamping: Double,
                               initialSpringVelocity: Double) -> [Double] {
        
        let numOfPoints = 1000
        var values = [Double](repeating: 0.0, count: numOfPoints)
        
        let distanceBetweenValues = toValue - fromValue
        
        for point in (0..<numOfPoints) {
            let x = Double(point) / Double(numOfPoints)
            let valueNormalized = animationValuesNormalized(x,
                                                            usingSpringWithDamping: usingSpringWithDamping,
                                                            initialSpringVelocity: initialSpringVelocity)
            let value = toValue - distanceBetweenValues * valueNormalized
            values[point] = value
        }
        
        return values
    }
    
    private class func animationValuesNormalized(_ x: Double,
                                                 usingSpringWithDamping: Double,
                                                 initialSpringVelocity: Double) -> Double {
        
        return pow(M_E, -usingSpringWithDamping * x) * cos(initialSpringVelocity * x)
    }
}

/**
 
 Calling tap with closure.
 
 */
class OnTap: NSObject {
    var closure: () -> Void
    
    init(view: UIView, gesture: UIGestureRecognizer, closure: @escaping () -> Void ) {
        self.closure = closure
        super.init()
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        gesture.addTarget(self, action: #selector(OnTap.didTap(_:)))
    }
    
    @objc func didTap(_ gesture: UIGestureRecognizer) {
        closure()
    }
}

class TegAutolayoutConstraints {
    class func centerX(_ viewOne: UIView,
                       viewTwo: UIView,
                       constraintContainer: UIView) -> [NSLayoutConstraint] {
        
        return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: false)
    }
    
    @discardableResult
    class func centerY(_ viewOne: UIView,
                       viewTwo: UIView,
                       constraintContainer: UIView) -> [NSLayoutConstraint] {
        
        return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: true)
    }
    
    private class func center(_ viewOne: UIView,
                              viewTwo: UIView,
                              constraintContainer: UIView,
                              vertically: Bool = false) -> [NSLayoutConstraint] {
        
        let attribute = vertically ? NSLayoutConstraint.Attribute.centerY : NSLayoutConstraint.Attribute.centerX
        let constraint = NSLayoutConstraint(
            item: viewOne,
            attribute: attribute,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: viewTwo,
            attribute: attribute,
            multiplier: 1,
            constant: 0)
        
        constraintContainer.addConstraint(constraint)
        
        return [constraint]
    }
    
    @discardableResult
    class func alignSameAttributes(_ item: AnyObject,
                                   toItem: AnyObject,
                                   constraintContainer: UIView,
                                   attribute: NSLayoutConstraint.Attribute,
                                   margin: CGFloat = 0) -> [NSLayoutConstraint] {
        
        let constraint = NSLayoutConstraint(
            item: item,
            attribute: attribute,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: toItem,
            attribute: attribute,
            multiplier: 1,
            constant: margin)
        
        constraintContainer.addConstraint(constraint)
        
        return [constraint]
    }
    
    class func alignVerticallyToAnchor(_ item: AnyObject,
                                       onTop: Bool,
                                       anchor: NSLayoutYAxisAnchor,
                                       margin: CGFloat = 0) -> [NSLayoutConstraint] {
        let constraint = onTop ? anchor.constraint(equalTo: item.topAnchor) : anchor.constraint(equalTo: item.bottomAnchor)
        constraint.constant = margin
        constraint.isActive = true
        
        return [constraint]
    }
    
    class func aspectRatio(_ view: UIView, ratio: CGFloat) {
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: view,
            attribute: NSLayoutConstraint.Attribute.height,
            multiplier: ratio,
            constant: 0)
        view.addConstraint(constraint)
    }
    
    class func fillParent(_ view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool = false) {
        var marginFormat = ""
        
        if margin != 0 {
            marginFormat = "-\(margin)-"
        }
        
        var format = "|\(marginFormat)[view]\(marginFormat)|"
        
        if vertically {
            format = "V:" + format
        }
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
                                                         options: [], metrics: nil,
                                                         views: ["view": view])
        parentView.addConstraints(constraints)
    }
    
    @discardableResult
    class func viewsNextToEachOther(_ views: [UIView],
                                    constraintContainer: UIView,
                                    margin: CGFloat = 0,
                                    vertically: Bool = false) -> [NSLayoutConstraint] {
        
        if views.count < 2 { return []  }
        var constraints = [NSLayoutConstraint]()
        for (index, view) in views.enumerated() {
            if index >= views.count - 1 { break }
            let viewTwo = views[index + 1]
            constraints += twoViewsNextToEachOther(view, viewTwo: viewTwo,
                                                   constraintContainer: constraintContainer,
                                                   margin: margin,
                                                   vertically: vertically)
        }
        return constraints
    }
    
    class func twoViewsNextToEachOther(_ viewOne: UIView,
                                       viewTwo: UIView,
                                       constraintContainer: UIView,
                                       margin: CGFloat = 0,
                                       vertically: Bool = false) -> [NSLayoutConstraint] {
        var marginFormat = ""
        if margin != 0 {
            marginFormat = "-\(margin)-"
        }
        var format = "[viewOne]\(marginFormat)[viewTwo]"
        
        if vertically {
            format = "V:" + format
        }
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
                                                         options: [], metrics: nil,
                                                         views: [ "viewOne": viewOne, "viewTwo": viewTwo ])
        constraintContainer.addConstraints(constraints)
        return constraints
    }
    
    class func equalWidth(_ viewOne: UIView,
                          viewTwo: UIView,
                          constraintContainer: UIView) -> [NSLayoutConstraint] {
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "[viewOne(==viewTwo)]",
                                                         options: [],
                                                         metrics: nil,
                                                         views: ["viewOne": viewOne, "viewTwo": viewTwo])
        constraintContainer.addConstraints(constraints)
        return constraints
    }
    
    @discardableResult
    class func height(_ view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
        return widthOrHeight(view, value: value, isWidth: false)
    }
    
    @discardableResult
    class func width(_ view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
        return widthOrHeight(view, value: value, isWidth: true)
    }
    
    private class func widthOrHeight(_ view: UIView,
                                     value: CGFloat,
                                     isWidth: Bool) -> [NSLayoutConstraint] {
        let attribute = isWidth ? NSLayoutConstraint.Attribute.width : NSLayoutConstraint.Attribute.height
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: attribute,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: value)
        view.addConstraint(constraint)
        return [constraint]
    }
}

public class FBLoafColor {
    /**
     
     Creates a UIColor object from a string.
     
     - parameter rgba: a RGB/RGBA string representation of color. It can include optional alpha value. Example: "#cca213" or "#cca21312" (with alpha value).
     
     - returns: UIColor object.
     
     */
    public class func fromHexString(_ rgba: String) -> UIColor {
        var red: CGFloat   = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat  = 0.0
        var alpha: CGFloat = 1.0
        
        if !rgba.hasPrefix("#") {
            print("Warning: FBLoafColor.fromHexString, # character missing")
            return UIColor()
        }
        
        let index = rgba.index(rgba.startIndex, offsetBy: 1)
        let hex = String(rgba.suffix(from: index))
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        
        if !scanner.scanHexInt64(&hexValue) {
            print("Warning: FBLoafColor.fromHexString, error scanning hex value")
            return UIColor()
        }
        
        if hex.count == 6 {
            red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
            blue  = CGFloat(hexValue & 0x0000FF) / 255.0
        } else if hex.count == 8 {
            red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
            alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
        } else {
            print("Warning: FBLoafColor.fromHexString, invalid rgb string, length should be 7 or 9")
            return UIColor()
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
/// Defines styles related to the bar view in general.
public class FBLoafBarStyle {
    
    /// The parent style is used to get the property value if the object is missing one.
    var parent: FBLoafBarStyle?
    
    init(parentStyle: FBLoafBarStyle? = nil) {
        self.parent = parentStyle
    }
    
    /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
    public func clear() {
        _animationHide = nil
        _animationHideDuration = nil
        _animationShow = nil
        _animationShowDuration = nil
        _backgroundColor = nil
        _borderColor = nil
        _borderWidth = nil
        _cornerRadius = nil
        _debugMode = nil
        _hideAfterDelaySeconds = nil
        _hideOnTap = nil
        _locationTop = nil
        _marginToSuperview = nil
        _onTap = nil
    }
    
    // -----------------------------
    
    private var _animationHide: FBLoafAnimation?
    
    /// Specify a function for animating the bar when it is hidden.
    public var animationHide: FBLoafAnimation {
        get {
            return (_animationHide ?? parent?.animationHide) ?? FBLoafBarDefaultStyles.animationHide
        }
        
        set {
            _animationHide = newValue
        }
    }
    
    // ---------------------------
    
    private var _animationHideDuration: TimeInterval?
    
    /// Duration of hide animation. When nil it uses default duration for selected animation function.
    public var animationHideDuration: TimeInterval? {
        get {
            return (_animationHideDuration ?? parent?.animationHideDuration) ??
                FBLoafBarDefaultStyles.animationHideDuration
        }
        
        set {
            _animationHideDuration = newValue
        }
    }
    
    // ---------------------------
    
    private var _animationShow: FBLoafAnimation?
    
    /// Specify a function for animating the bar when it is shown.
    public var animationShow: FBLoafAnimation {
        get {
            return (_animationShow ?? parent?.animationShow) ?? FBLoafBarDefaultStyles.animationShow
        }
        
        set {
            _animationShow = newValue
        }
    }
    
    // ---------------------------
    
    private var _animationShowDuration: TimeInterval?
    
    /// Duration of show animation. When nil it uses default duration for selected animation function.
    public var animationShowDuration: TimeInterval? {
        get {
            return (_animationShowDuration ?? parent?.animationShowDuration) ??
                FBLoafBarDefaultStyles.animationShowDuration
        }
        
        set {
            _animationShowDuration = newValue
        }
    }
    
    // ---------------------------
    
    private var _backgroundColor: UIColor?
    
    /// Background color of the bar.
    public var backgroundColor: UIColor? {
        get {
            return _backgroundColor ?? parent?.backgroundColor ?? FBLoafBarDefaultStyles.backgroundColor
        }
        
        set {
            _backgroundColor = newValue
        }
    }
    
    // -----------------------------
    
    private var _borderColor: UIColor?
    
    /// Color of the bar's border.
    public var borderColor: UIColor? {
        get {
            return _borderColor ?? parent?.borderColor ?? FBLoafBarDefaultStyles.borderColor
        }
        
        set {
            _borderColor = newValue
        }
    }
    
    // -----------------------------
    
    private var _borderWidth: CGFloat?
    
    /// Border width of the bar.
    public var borderWidth: CGFloat {
        get {
            return _borderWidth ?? parent?.borderWidth ?? FBLoafBarDefaultStyles.borderWidth
        }
        
        set {
            _borderWidth = newValue
        }
    }
    
    // -----------------------------
    
    private var _cornerRadius: CGFloat?
    
    /// Corner radius of the bar view.
    public var cornerRadius: CGFloat {
        get {
            return _cornerRadius ?? parent?.cornerRadius ?? FBLoafBarDefaultStyles.cornerRadius
        }
        
        set {
            _cornerRadius = newValue
        }
    }
    
    // -----------------------------
    
    private var _debugMode: Bool?
    
    /// When true it highlights the view background for spotting layout issues.
    public var debugMode: Bool {
        get {
            return _debugMode ?? parent?.debugMode ?? FBLoafBarDefaultStyles.debugMode
        }
        
        set {
            _debugMode = newValue
        }
    }
    
    // ---------------------------
    
    private var _hideAfterDelaySeconds: TimeInterval?
    
    /**
     
     Hides the bar automatically after the specified number of seconds.
     If nil the bar is kept on screen.
     
     */
    public var hideAfterDelaySeconds: TimeInterval {
        get {
            return _hideAfterDelaySeconds ?? parent?.hideAfterDelaySeconds ??
                FBLoafBarDefaultStyles.hideAfterDelaySeconds
        }
        
        set {
            _hideAfterDelaySeconds = newValue
        }
    }
    private var _hideOnTap: Bool?
    
    /// When true the bar is hidden when user taps on it.
    public var hideOnTap: Bool {
        get {
            return _hideOnTap ?? parent?.hideOnTap ??
                FBLoafBarDefaultStyles.hideOnTap
        }
        
        set {
            _hideOnTap = newValue
        }
    }
    
    private var _locationTop: Bool?
    
    /// Position of the bar. When true the bar is shown on top of the screen.
    public var locationTop: Bool {
        get {
            return _locationTop ?? parent?.locationTop ?? FBLoafBarDefaultStyles.locationTop
        }
        
        set {
            _locationTop = newValue
        }
    }
    
    private var _marginToSuperview: CGSize?
    
    /// Margin between the bar edge and its superview.
    public var marginToSuperview: CGSize {
        get {
            return _marginToSuperview ?? parent?.marginToSuperview ??
                FBLoafBarDefaultStyles.marginToSuperview
        }
        
        set {
            _marginToSuperview = newValue
        }
    }
    private var _onTap: FBLoafBarOnTap?
    
    /// Supply a function that will be called when user taps the bar.
    public var onTap: FBLoafBarOnTap? {
        get {
            return _onTap ?? parent?.onTap ?? FBLoafBarDefaultStyles.onTap
        }
        
        set {
            _onTap = newValue
        }
    }
}
/**
 
 Defines the style presets for the bar.
 
 */
public enum FBPresets {
    /// A styling preset used for indicating successful completion of an operation. Usually styled with green color.
    case success
    
    /// A styling preset for showing information messages, neutral in color.
    case info
    
    /// A styling preset for showing warning messages. Can be styled with yellow/orange colors.
    case warning
    
    /// A styling preset for showing critical error messages. Usually styled with red color.
    case error
    
    /// The preset is used by default for the bar if it's not set by the user.
    static let defaultPreset = FBPresets.success
    
    /// The preset cache.
    private static var styles = [FBPresets: FBLoafStyle]()
    
    /// Returns the style for the preset
    public var style: FBLoafStyle {
        var style = FBPresets.styles[self]
        
        if style == nil {
            style = FBPresets.makeStyle(forPreset: self)
            FBPresets.styles[self] = style
        }
        
        precondition(style != nil, "Failed to create style")
        
        return style ?? FBLoafStyle()
    }
    
    /// Reset alls preset styles to their initial states.
    public static func resetAll() {
        styles = [:]
    }
    
    /// Reset the preset style to its initial state.
    public func reset() {
        FBPresets.styles.removeValue(forKey: self)
    }
    
    private static func makeStyle(forPreset preset: FBPresets) -> FBLoafStyle {
        
        let style = FBLoafStyle()
        
        switch preset {
        case .success:
            style.bar.backgroundColor = FBLoafColor.fromHexString("#00CC03C9")
            
        case .info:
            style.bar.backgroundColor = FBLoafColor.fromHexString("#0057FF96")
            
        case .warning:
            style.bar.backgroundColor = FBLoafColor.fromHexString("#CEC411DD")
            
        case .error:
            style.bar.backgroundColor = FBLoafColor.fromHexString("#FF0B0BCC")
        }
        
        return style
    }
}

/**
 
 Default styles for the bar button.
 Default styles are used when individual element styles are not set.
 
 */
public struct FBLoafButtonDefaultStyles {
    
    /// Revert the property values to their defaults
    public static func resetToDefaults() {
        accessibilityLabel = _accessibilityLabel
        hideOnTap = _hideOnTap
        horizontalMarginToBar = _horizontalMarginToBar
        icon = _icon
        image = _image
        onTap = _onTap
        size = _size
        tintColor = _tintColor
    }
    
    private static let _accessibilityLabel: String? = nil
    
    /**
     
     This text is spoken by the device when it is in accessibility mode. It is recommended to always set the accessibility label for your button. The text can be a short localized description of the button function, for example: "Close the message", "Reload" etc.
     
     */
    public static var accessibilityLabel = _accessibilityLabel
    private static let _hideOnTap = false
    
    /// When true it hides the bar when the button is tapped.
    public static var hideOnTap = _hideOnTap
    private static let _horizontalMarginToBar: CGFloat = 10
    
    /// Margin between the bar edge and the button
    public static var horizontalMarginToBar = _horizontalMarginToBar
    private static let _icon: FBLoafIcons? = nil
    
    /// When set it shows one of the default FBLoaf icons. Use `image` property to supply a custom image. The color of the image can be changed with `tintColor` property.
    public static var icon = _icon
    private static let _image: UIImage? = nil
    /// Custom image for the button. One can also use the `icon` property to show one of the default FBLoaf icons. The color of the image can be changed with `tintColor` property.
    public static var image = _image
    private static let _onTap: FBButtonOnTap? = nil
    /// Supply a function that will be called when user taps the button.
    public static var onTap = _onTap
    private static let _size = CGSize(width: 25, height: 25)
    /// Size of the button.
    public static var size = _size
    private static let _tintColor: UIColor? = nil
    /// Replaces the color of the image or icon. The original colors are used when nil.
    public static var tintColor = _tintColor
}

/// Defines styles for the bar button.
public class FBButtonStyle {
    
    /// The parent style is used to get the property value if the object is missing one.
    var parent: FBButtonStyle?
    
    init(parentStyle: FBButtonStyle? = nil) {
        self.parent = parentStyle
    }
    
    /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
    public func clear() {
        _accessibilityLabel = nil
        _hideOnTap = nil
        _horizontalMarginToBar = nil
        _icon = nil
        _image = nil
        _onTap = nil
        _size = nil
        _tintColor = nil
    }
    
    // -----------------------------
    
    private var _accessibilityLabel: String?
    
    /**
     
     This text is spoken by the device when it is in accessibility mode. It is recommended to always set the accessibility label for your button. The text can be a short localized description of the button function, for example: "Close the message", "Reload" etc.
     
     */
    public var accessibilityLabel: String? {
        get {
            return _accessibilityLabel ?? parent?.accessibilityLabel ?? FBLoafButtonDefaultStyles.accessibilityLabel
        }
        
        set {
            _accessibilityLabel = newValue
        }
    }
    
    // -----------------------------
    
    private var _hideOnTap: Bool?
    
    /// When true it hides the bar when the button is tapped.
    public var hideOnTap: Bool {
        get {
            return _hideOnTap ?? parent?.hideOnTap ?? FBLoafButtonDefaultStyles.hideOnTap
        }
        
        set {
            _hideOnTap = newValue
        }
    }
    private var _horizontalMarginToBar: CGFloat?
    
    /// Horizontal margin between the bar edge and the button.
    public var horizontalMarginToBar: CGFloat {
        get {
            return _horizontalMarginToBar ?? parent?.horizontalMarginToBar ??
                FBLoafButtonDefaultStyles.horizontalMarginToBar
        }
        
        set {
            _horizontalMarginToBar = newValue
        }
    }
    private var _icon: FBLoafIcons?
    
    /// When set it shows one of the default FBLoaf icons. Use `image` property to supply a custom image. The color of the image can be changed with `tintColor` property.
    public var icon: FBLoafIcons? {
        get {
            return _icon ?? parent?.icon ?? FBLoafButtonDefaultStyles.icon
        }
        
        set {
            _icon = newValue
        }
    }
    
    private var _image: UIImage?
    
    /// Custom image for the button. One can also use the `icon` property to show one of the default FBLoaf icons. The color of the image can be changed with `tintColor` property.
    public var image: UIImage? {
        get {
            return _image ?? parent?.image ?? FBLoafButtonDefaultStyles.image
        }
        
        set {
            _image = newValue
        }
    }
    private var _onTap: FBButtonOnTap?
    /// Supply a function that will be called when user taps the button.
    public var onTap: FBButtonOnTap? {
        get {
            return _onTap ?? parent?.onTap ?? FBLoafButtonDefaultStyles.onTap
        }
        
        set {
            _onTap = newValue
        }
    }
    private var _size: CGSize?
    
    /// Size of the button.
    public var size: CGSize {
        get {
            return _size ?? parent?.size ?? FBLoafButtonDefaultStyles.size
        }
        
        set {
            _size = newValue
        }
    }
    private var _tintColor: UIColor?
    
    /// Replaces the color of the image or icon. The original colors are used when nil.
    public var tintColor: UIColor? {
        get {
            return _tintColor ?? parent?.tintColor ?? FBLoafButtonDefaultStyles.tintColor
        }
        
        set {
            _tintColor = newValue
        }
    }
}
/// Combines various styles for the toolbar element.
public class FBLoafStyle {
    
    /// The parent style is used to get the property value if the object is missing one.
    var parent: FBLoafStyle? {
        didSet {
            changeParent()
        }
    }
    
    init(parentStyle: FBLoafStyle? = nil) {
        self.parent = parentStyle
    }
    
    private func changeParent() {
        bar.parent = parent?.bar
        label.parent = parent?.label
        leftButton.parent = parent?.leftButton
        rightButton.parent = parent?.rightButton
    }
    
    /**
     
     Reverts all the default styles to their initial values. Usually used in setUp() function in the unit tests.
     
     */
    public static func resetDefaultStyles() {
        FBLoafBarDefaultStyles.resetToDefaults()
        FBLoafLabelDefaultStyles.resetToDefaults()
        FBLoafButtonDefaultStyles.resetToDefaults()
    }
    
    /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
    public func clear() {
        bar.clear()
        label.clear()
        leftButton.clear()
        rightButton.clear()
    }
    
    /**
     
     Styles for the bar view.
     
     */
    public lazy var bar: FBLoafBarStyle = self.initBarStyle()
    
    private func initBarStyle() -> FBLoafBarStyle {
        return FBLoafBarStyle(parentStyle: parent?.bar)
    }
    
    /**
     
     Styles for the text label.
     
     */
    public lazy var label: FBLoafLabelStyle = self.initLabelStyle()
    
    private func initLabelStyle() -> FBLoafLabelStyle {
        return FBLoafLabelStyle(parentStyle: parent?.label)
    }
    
    /**
     
     Styles for the left button.
     
     */
    public lazy var leftButton: FBButtonStyle = self.initLeftButtonStyle()
    
    private func initLeftButtonStyle() -> FBButtonStyle {
        return FBButtonStyle(parentStyle: parent?.leftButton)
    }
    
    /**
     
     Styles for the right button.
     
     */
    public lazy var rightButton: FBButtonStyle = self.initRightButtonStyle()
    
    private func initRightButtonStyle() -> FBButtonStyle {
        return FBButtonStyle(parentStyle: parent?.rightButton)
    }
}

/// Defines styles related to the text label.
public class FBLoafLabelStyle {
    
    /// The parent style is used to get the property value if the object is missing one.
    var parent: FBLoafLabelStyle?
    
    init(parentStyle: FBLoafLabelStyle? = nil) {
        self.parent = parentStyle
    }
    
    /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
    public func clear() {
        _color = nil
        _font = nil
        _horizontalMargin = nil
        _numberOfLines = nil
        _shadowColor = nil
        _shadowOffset = nil
    }
    
    // -----------------------------
    
    private var _color: UIColor?
    
    /// Color of the label text.
    public var color: UIColor {
        get {
            return _color ?? parent?.color ?? FBLoafLabelDefaultStyles.color
        }
        
        set {
            _color = newValue
        }
    }
    
    // -----------------------------
    
    private var _font: UIFont?
    
    /// Color of the label text.
    public var font: UIFont {
        get {
            return _font ?? parent?.font ?? FBLoafLabelDefaultStyles.font
        }
        
        set {
            _font = newValue
        }
    }
    
    // -----------------------------
    
    private var _horizontalMargin: CGFloat?
    
    /// Margin between the bar/button edge and the label.
    public var horizontalMargin: CGFloat {
        get {
            return _horizontalMargin ?? parent?.horizontalMargin ??
                FBLoafLabelDefaultStyles.horizontalMargin
        }
        
        set {
            _horizontalMargin = newValue
        }
    }
    
    // -----------------------------
    
    private var _numberOfLines: Int?
    
    /// The maximum number of lines in the label.
    public var numberOfLines: Int {
        get {
            return _numberOfLines ?? parent?.numberOfLines ??
                FBLoafLabelDefaultStyles.numberOfLines
        }
        
        set {
            _numberOfLines = newValue
        }
    }
    
    // -----------------------------
    
    private var _shadowColor: UIColor?
    
    /// Color of text shadow.
    public var shadowColor: UIColor? {
        get {
            return _shadowColor ?? parent?.shadowColor ?? FBLoafLabelDefaultStyles.shadowColor
        }
        
        set {
            _shadowColor = newValue
        }
    }
    
    private var _shadowOffset: CGSize?
    
    /// Text shadow offset.
    public var shadowOffset: CGSize {
        get {
            return _shadowOffset ?? parent?.shadowOffset ?? FBLoafLabelDefaultStyles.shadowOffset
        }
        
        set {
            _shadowOffset = newValue
        }
    }
}

/**
 
 Default styles for the text label.
 Default styles are used when individual element styles are not set.
 
 */
public struct FBLoafLabelDefaultStyles {
    
    /// Revert the property values to their defaults
    public static func resetToDefaults() {
        color = _color
        font = _font
        horizontalMargin = _horizontalMargin
        numberOfLines = _numberOfLines
        shadowColor = _shadowColor
        shadowOffset = _shadowOffset
    }
    private static let _color = UIColor.white
    /// Color of the label text.
    public static var color = _color
    
    private static let _font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    
    /// Font of the label text.
    public static var font = _font
    
    private static let _horizontalMargin: CGFloat = 10
    
    /// Margin between the bar/button edge and the label.
    public static var horizontalMargin = _horizontalMargin
    
    private static let _numberOfLines: Int = 3
    
    /// The maximum number of lines in the label.
    public static var numberOfLines = _numberOfLines
    
    private static let _shadowColor: UIColor? = nil
    
    /// Color of text shadow.
    public static var shadowColor = _shadowColor
    
    private static let _shadowOffset = CGSize(width: 0, height: 1)
    
    /// Text shadow offset.
    public static var shadowOffset = _shadowOffset
}

/**
 
 Default styles for the bar view.
 Default styles are used when individual element styles are not set.
 
 */
public struct FBLoafBarDefaultStyles {
    
    /// Revert the property values to their defaults
    public static func resetToDefaults() {
        animationHide = _animationHide
        animationHideDuration = _animationHideDuration
        animationShow = _animationShow
        animationShowDuration = _animationShowDuration
        backgroundColor = _backgroundColor
        borderColor = _borderColor
        borderWidth = _borderWidth
        cornerRadius = _cornerRadius
        debugMode = _debugMode
        hideAfterDelaySeconds = _hideAfterDelaySeconds
        hideOnTap = _hideOnTap
        locationTop = _locationTop
        marginToSuperview = _marginToSuperview
        onTap = _onTap
    }
    
    private static let _animationHide: FBLoafAnimation = FBLoafAnimationsHide.rotate
    
    /// Specify a function for animating the bar when it is hidden.
    public static var animationHide: FBLoafAnimation = _animationHide
    
    private static let _animationHideDuration: TimeInterval? = nil
    
    /// Duration of hide animation. When nil it uses default duration for selected animation function.
    public static var animationHideDuration: TimeInterval? = _animationHideDuration
    
    private static let _animationShow: FBLoafAnimation = FBLoafAnimationsShow.rotate
    
    /// Specify a function for animating the bar when it is shown.
    public static var animationShow: FBLoafAnimation = _animationShow
    
    private static let _animationShowDuration: TimeInterval? = nil
    
    /// Duration of show animation. When nil it uses default duration for selected animation function.
    public static var animationShowDuration: TimeInterval? = _animationShowDuration
    
    private static let _backgroundColor: UIColor? = nil
    
    /// Background color of the bar.
    public static var backgroundColor = _backgroundColor
    
    private static let _borderColor: UIColor? = nil
    
    /// Color of the bar's border.
    public static var borderColor = _borderColor
    
    private static let _borderWidth: CGFloat  = 1 / UIScreen.main.scale
    
    /// Border width of the bar.
    public static var borderWidth = _borderWidth
    
    private static let _cornerRadius: CGFloat = 20
    
    /// Corner radius of the bar view.
    public static var cornerRadius = _cornerRadius
    
    private static let _debugMode = false
    
    /// When true it highlights the view background for spotting layout issues.
    public static var debugMode = _debugMode
    
    private static let _hideAfterDelaySeconds: TimeInterval = 0
    
    /**
     
     Hides the bar automatically after the specified number of seconds.
     The bar is kept on screen indefinitely if the value is zero.
     
     */
    public static var hideAfterDelaySeconds = _hideAfterDelaySeconds
    
    private static let _hideOnTap = false
    
    /// When true the bar is hidden when user taps on it.
    public static var hideOnTap = _hideOnTap
    
    private static let _locationTop = true
    
    /// Position of the bar. When true the bar is shown on top of the screen.
    public static var locationTop = _locationTop
    
    private static let _marginToSuperview = CGSize(width: 5, height: 5)
    
    /// Margin between the bar edge and its superview.
    public static var marginToSuperview = _marginToSuperview
    private static let _onTap: FBLoafBarOnTap? = nil
    /// Supply a function that will be called when user taps the bar.
    public static var onTap = _onTap
    
}

class SBToolbar: UIView {
    var anchor: NSLayoutYAxisAnchor?
    var style: FBLoafStyle
    weak var buttonViewDelegate: FBButtonViewDelegate?
    private var didCallHide = false
    
    convenience init(witStyle style: FBLoafStyle) {
        self.init(frame: CGRect())
        
        self.style = style
    }
    
    override init(frame: CGRect) {
        style = FBLoafStyle()
        
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(inSuperview parentView: UIView, withMessage message: String) {
        
        if superview != nil { return } // already being shown
        
        parentView.addSubview(self)
        applyStyle()
        layoutBarInSuperview()
        
        let buttons = createButtons()
        
        createLabel(message, withButtons: buttons)
        
        style.bar.animationShow(self, style.bar.animationShowDuration, style.bar.locationTop, {})
    }
    
    func hide(_ onAnimationCompleted: @escaping () -> Void ) {
        // Respond only to the first hide() call
        if didCallHide { return }
        didCallHide = true
        
        style.bar.animationHide(self, style.bar.animationHideDuration,
                                style.bar.locationTop, { [weak self] in
                                    
                                    self?.removeFromSuperview()
                                    onAnimationCompleted()
        })
    }
    
    // MARK: - Label
    
    private func createLabel(_ message: String, withButtons buttons: [UIView]) {
        let label = UILabel()
        
        label.font = style.label.font
        label.text = message
        label.textColor = style.label.color
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = style.label.numberOfLines
        
        if style.bar.debugMode {
            label.backgroundColor = UIColor.red
        }
        
        if let shadowColor = style.label.shadowColor {
            label.shadowColor = shadowColor
            label.shadowOffset = style.label.shadowOffset
        }
        
        addSubview(label)
        layoutLabel(label, withButtons: buttons)
    }
    
    private func layoutLabel(_ label: UILabel, withButtons buttons: [UIView]) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Stretch the label vertically
        TegAutolayoutConstraints.fillParent(label,
                                            parentView: self,
                                            margin: style.label.horizontalMargin,
                                            vertically: true)
        
        if buttons.isEmpty {
            if let superview = superview {
                // If there are no buttons - stretch the label to the entire width of the view
                TegAutolayoutConstraints.fillParent(label,
                                                    parentView: superview,
                                                    margin: style.label.horizontalMargin,
                                                    vertically: false)
            }
        } else {
            layoutLabelWithButtons(label, withButtons: buttons)
        }
    }
    
    private func layoutLabelWithButtons(_ label: UILabel, withButtons buttons: [UIView]) {
        if buttons.count != 2 { return }
        
        let views = [buttons[0], label, buttons[1]]
        
        if let superview = superview {
            TegAutolayoutConstraints.viewsNextToEachOther(views,
                                                          constraintContainer: superview,
                                                          margin: style.label.horizontalMargin,
                                                          vertically: false)
        }
    }
    
    // MARK: - Buttons
    
    private func createButtons() -> [FBButtonView] {
        precondition(buttonViewDelegate != nil, "Button view delegate can not be nil")
        let buttonStyles = [style.leftButton, style.rightButton]
        
        let buttonViews = FBButtonView.createMany(buttonStyles)
        
        for (index, button) in buttonViews.enumerated() {
            addSubview(button)
            button.delegate = buttonViewDelegate
            button.doLayout(onLeftSide: index == 0)
            
            if style.bar.debugMode {
                button.backgroundColor = UIColor.yellow
            }
        }
        
        return buttonViews
    }
    
    // MARK: - Style the bar
    
    private func applyStyle() {
        backgroundColor = style.bar.backgroundColor
        layer.cornerRadius = style.bar.cornerRadius
        layer.masksToBounds = true
        
        if let borderColor = style.bar.borderColor, style.bar.borderWidth > 0 {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = style.bar.borderWidth
        }
    }
    
    private func layoutBarInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            // Stretch the toobar horizontally to the width if its superview
            TegAutolayoutConstraints.fillParent(self,
                                                parentView: superview,
                                                margin: style.bar.marginToSuperview.width,
                                                vertically: false)
            var verticalMargin = style.bar.marginToSuperview.height
            verticalMargin = style.bar.locationTop ? -verticalMargin : verticalMargin
            var verticalConstraints = [NSLayoutConstraint]()
            
            if let anchor = anchor {
                // Align the top/bottom edge of the toolbar with the top/bottom anchor
                // (a tab bar, for example)
                verticalConstraints = TegAutolayoutConstraints.alignVerticallyToAnchor(self,
                                                                                       onTop: style.bar.locationTop,
                                                                                       anchor: anchor,
                                                                                       margin: verticalMargin)
            } else {
                // Align the top/bottom of the toolbar with the top/bottom of its superview
                verticalConstraints = TegAutolayoutConstraints.alignSameAttributes(superview,
                                                                                   toItem: self,
                                                                                   constraintContainer: superview,
                                                                                   attribute: style.bar.locationTop ? NSLayoutConstraint.Attribute.top : NSLayoutConstraint.Attribute.bottom,
                                                                                   margin: verticalMargin)
            }
            setupKeyboardEvader(verticalConstraints)
        }
    }
    
    // Moves the message bar from under the keyboard
    private func setupKeyboardEvader(_ verticalConstraints: [NSLayoutConstraint]) {
        if let bottomConstraint = verticalConstraints.first,
            let superview = superview,
            !style.bar.locationTop {
            FBLoafKeyboardListener.underKeyboardLayoutConstraint.setup(bottomConstraint, view: superview)
        }
    }
}

/**
 
 Collection of icons included with FBLoaf library.
 
 */
public enum FBLoafIcons: String {
    /// Icon for closing the bar.
    case close = "Close"
    
    /// Icon for reloading.
    case reload = "Reload"
}
private var sabAssociationKey: UInt8 = 0

/**
 
 UIView extension for showing a notification widget.
 
 let view = UIView()
 view.FBLoaf.show("Hello World!")
 
 */
public extension UIView {
    /**
     
     Message bar extension.
     Call `FBLoaf.show`, `FBLoaf.success`, FBLoaf.error` functions to show a notification widget in the view.
     
     let view = UIView()
     view.FBLoaf.show("Hello World!")
     
     */
    var popup: FBLoafInterface {
        get {
            if let value = objc_getAssociatedObject(self, &sabAssociationKey) as? FBLoafInterface {
                return value
            } else {
                let popup = FBLoaf(superview: self)
                
                objc_setAssociatedObject(self,
                                         &sabAssociationKey, popup,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                
                return popup
            }
        }
        
        set {
            objc_setAssociatedObject(self, &sabAssociationKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

/**
 
 Start listening for keyboard events. Used for moving the message bar from under the keyboard when the bar is shown at the bottom of the screen.
 
 */
struct FBLoafKeyboardListener {
    static let underKeyboardLayoutConstraint = UnderKeyboardLayoutConstraint()
    
    static func startListening() {
        // Just access the static property to make it initialize itself lazily if it hasn't been already.
        underKeyboardLayoutConstraint.isAccessibilityElement = false
    }
}
/**
 
 Helper function to make sure bounds are big enought to be used as touch target.
 The function is used in pointInside(point: CGPoint, withEvent event: UIEvent?) of UIImageView.
 
 */
struct FBTouchTarget {
    static func optimize(_ bounds: CGRect) -> CGRect {
        let recommendedHitSize: CGFloat = 44
        
        var hitWidthIncrease: CGFloat = recommendedHitSize - bounds.width
        var hitHeightIncrease: CGFloat = recommendedHitSize - bounds.height
        
        if hitWidthIncrease < 0 { hitWidthIncrease = 0 }
        if hitHeightIncrease < 0 { hitHeightIncrease = 0 }
        
        let extendedBounds: CGRect = bounds.insetBy(dx: -hitWidthIncrease / 2,
                                                    dy: -hitHeightIncrease / 2)
        return extendedBounds
    }
}

/// A closure that is called when a bar is tapped
public typealias FBLoafBarOnTap = () -> Void
