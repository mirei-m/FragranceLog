Capybara.register_driver :remote_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox')
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-extensions')
  options.add_argument('--disable-dev-tools')
  options.add_argument('--no-first-run')
  options.add_argument('--window-size=1920,1080')
  options.add_argument('--disable-background-timer-throttling')
  options.add_argument('--disable-renderer-backgrounding')
  options.add_argument('--disable-backgrounding-occluded-windows')
  options.add_argument('--memory-pressure-off')
  options.add_argument('--max_old_space_size=4096')

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: ENV['SELENIUM_DRIVER_URL'],
    capabilities: options
  )
end

Capybara.configure do |config|
  config.default_max_wait_time = 10
  config.server_host = IPSocket.getaddress(Socket.gethostname)
  config.server_port = 4445
end
