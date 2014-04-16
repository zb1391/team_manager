    require "instagram"

    Instagram.configure do |config|

    config.client_id = ENV["INST_CLIENT_ID"]

    config.access_token = ENV["INST_ACC_TOK"]

    end
