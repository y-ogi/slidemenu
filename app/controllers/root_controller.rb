class RootController < UIViewController

  stylesheet :root

  layout :root do
    @main_container = subview(UIView, :main_container)
    @menu_container = subview(UIView, :menu_container)
  end

  def initWithMainController(main_controller, menu_controller)

    @main_controller = main_controller
    @menu_controller = menu_controller

    self

  end

  def viewDidLoad
    super

    setup_controllers
    setup_gesture

  end

  def setup_controllers

    # create navigation controller
    @navigation_controller = NavigationController.new
    @navigation_controller.view.frame = @main_container.bounds
    @navigation_controller.delegate = self
    @navigation_controller.setViewControllers([@main_controller], false)

    @main_container.addSubview(@navigation_controller.view)
    self.addChildViewController(@navigation_controller)
    @navigation_controller.didMoveToParentViewController(self)

    # create menu controller
    @menu_controller.view.frame = @menu_container.bounds
    @menu_controller.delegate = self

    @menu_container.addSubview(@menu_controller.view)
    self.addChildViewController(@menu_controller)
    @menu_controller.didMoveToParentViewController(self)

  end

  def main_controller=(c)
    @main_controller = c
    @navigation_controller.setViewControllers([c], false)
  end

  def setup_gesture
    @panned_recognizer = @menu_container.whenPanned do |recognizer|
      position = recognizer.translationInView(view)
      case(recognizer.state)
        when UIGestureRecognizerStateBegan
          @last_position = position
        when UIGestureRecognizerStateChanged
          delta = [position.x - @last_position.x, position.y - @last_position.y]

          if move_menu(delta)
            @last_position = position
          end

        when UIGestureRecognizerStateEnded
          @last_position = nil
          slide_menu(@menu_container.frame.origin.x.abs < @menu_container.frame.size.width / 2)
      end
    end
    @panned_recognizer.maximumNumberOfTouches = 1
    @panned_recognizer.minimumNumberOfTouches = 1

  end

  def move_menu(delta)
    frame = @menu_container.frame
    frame.origin.x = frame.origin.x + delta[0]

    if frame.origin.x < frame.size.width * -1 or frame.origin.x > 0
      return false
    end

    scale = ( frame.origin.x.abs / frame.size.width) * 0.1 + 0.9
    @main_container.transform = CGAffineTransformMakeScale(scale, scale)

    # if the value is valid, then move the menu container view
    @menu_container.frame = frame

    true
  end

  def slide_menu(open)
    if open
      UIView.animateWithDuration(
          0.3,
          animations: lambda {
            #@main_container.stylename = :main_container_open
            @menu_container.stylename = :menu_container_open
            @main_container.transform = CGAffineTransformMakeScale(0.90, 0.90)
          },
          completion:lambda {|finished|
          }
      )
    else
      UIView.animateWithDuration(
          0.3,
          animations: lambda {
            #@main_container.stylename = :main_container
            @menu_container.stylename = :menu_container
            @main_container.transform = CGAffineTransformMakeScale(1.0, 1.0)
          },
          completion:lambda {|finished|
          }
      )
    end

  end

  def toggle_menu
    isOpen = @menu_container.stylename == :menu_container_open
    slide_menu(!isOpen)
  end


end
