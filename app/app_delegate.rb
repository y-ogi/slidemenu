class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    Teacup::Appearance.apply

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |w|
      w.rootViewController = RootController.alloc.initWithMainController(MainController.new, MenuController.new)
      w.makeKeyAndVisible
    end

    true
  end

end
