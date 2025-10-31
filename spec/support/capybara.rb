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


# CI環境用のドライバー設定
Capybara.register_driver :remote_chrome_ci do |app|
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

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: ENV['SELENIUM_DRIVER_URL'] || 'http://localhost:4444/wd/hub',
    capabilities: options
  )
end

if ENV['CI']
  # CI環境（GitHub Actions）用の設定
  Capybara.configure do |config|
    config.default_max_wait_time = 15
    config.server_host = '127.0.0.1'
    config.server_port = 3000
  end
else
  # ローカル環境（Docker）用の設定
  Capybara.configure do |config|
    config.default_max_wait_time = 10
    config.server_host = IPSocket.getaddress(Socket.gethostname)
    config.server_port = 4445
    Capybara.app_host = "http://#{Capybara.server_host}:4445"
  end
end
