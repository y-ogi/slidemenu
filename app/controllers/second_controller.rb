class SecondController < UIViewController

  stylesheet :second

  layout do
    @button = subview(UIButton, :hi_button)
  end

  def viewDidLoad
    super

    self.title = "Second"
    self.view.stylename = :root

    @button.addTarget(self, action: :push_next, forControlEvents: UIControlEventTouchUpInside)

  end

  def delegate=(delegate)
    @delegate = WeakRef.new(delegate)
  end

  def push_next
    c = SecondController.new
    navigationController.pushViewController(c, animated: true)
  end

end
