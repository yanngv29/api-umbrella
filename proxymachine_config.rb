require File.expand_path("../config/environment", __FILE__)

# Define a ProxyMachine proxy server with our logic stored in the
# {#AuthProxy::Proxy} class.
require "auth_proxy/proxy"
proxy(&AuthProxy::Proxy.proxymachine_router)
