Refinery::Core.configure do |config|


  # Add extra tags to the wymeditor whitelist e.g. = {'tag' => {'attributes' => {'1' => 'href'}}} or just {'tag' => {}}
  config.wymeditor_whitelist_tags = {'video' => {'attributes' => {'1' => 'poster', '2' => 'width', '3' => 'height', '4' => 'source', '5' => 'controls'} }}
  # Register extra javascript for backend
  config.register_javascript "refinery/admin/wymeditor_monkeypatch.js"

  #Register extra stylesheet for backend (optional options)
  #config.register_stylesheet "custom", :media => 'screen'
end


