class NavigationController < UINavigationController

  stylesheet :navigation

  def viewDidLoad

    # create the button
    inner_button = subview(UIButton, :left_button)
    inner_button.addTarget(self, action: :toggle_menu, forControlEvents: UIControlEventTouchUpInside)
    @left_button = UIBarButtonItem.alloc.initWithCustomView(inner_button)

    self.toolbar.items = [@left_button]

  end

  def delegate=(delegate)
    @delegate = delegate
  end

  def toggle_menu
    @delegate.toggle_menu
  end

  def setViewControllers(viewControllers, animated:animated)
    super viewControllers, animated

    viewControllers[0].navigationItem.leftBarButtonItem = @left_button

  end

end