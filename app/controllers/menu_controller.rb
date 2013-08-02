class MenuController < UIViewController

  stylesheet :menu

  layout do
    @table = subview(UITableView, :table)
  end

  def viewDidLoad
    super

    @table.dataSource = self
    @table.delegate = self

    @data = [
        {
            :title => nil,
            :data => [
                {
                    :title => "Home",
                    :block => lambda {
                      @delegate.main_controller = MainController.new
                      @delegate.toggle_menu
                    }
                },
                {
                    :title => "Second",
                    :block => lambda {
                      @delegate.main_controller = SecondController.new
                      @delegate.toggle_menu
                    }
                }
            ]
        }
    ]

  end

  def delegate=(delegate)
    @delegate = WeakRef.new(delegate)
  end

  # UITableView Delegate
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)

    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    @data[indexPath.section][:data][indexPath.row][:block].call

  end

  # UITableView DataSource
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    # set the value
    cell.textLabel.text = @data[indexPath.section][:data][indexPath.row][:title]

    # put your data in the cell
    cell

  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data[section][:data].count
  end

  def numberOfSections
    @data.count
  end

end