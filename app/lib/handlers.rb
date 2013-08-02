Teacup.handler UINavigationBar, :backgroundImage do |image|
  UINavigationBar.appearance.setBackgroundImage(UIImage.imageNamed(image), forBarMetrics:UIBarMetricsDefault)
end

Teacup.handler UIBarButtonItem, :backgroundImage do |image|
  UIBarButtonItem.appearance.setBackgroundImage(UIImage.imageNamed(image), forState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
end
