Teacup::Stylesheet.new :root do

  style :shadow,
    layer: {
        shadowColor: UIColor.blackColor,
        shadowOffset: [0, 0],
        shadowRadius: 4.0
    }

  style :menu_container,
    left: -250, top: 0, height: '100%', width: 250,
    backgroundColor: UIColor.grayColor

  style :menu_container_open,
    left: 0, top: 0, height: '100%', width: 250,
    backgroundColor: UIColor.grayColor

  style :main_container, extends: :shadow,
    left: 0, top: 0, height: '100%', width: '100%',
    backgroundColor: UIColor.blackColor

  style :main_container_open, extends: :main_container,
    left: '80%', top: 0, height: '100%', width: '100%'

end