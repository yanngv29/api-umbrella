local Contact = require "api-umbrella.web-app.models.contact"
local capture_errors_json_full = require("api-umbrella.web-app.utils.capture_errors").json_full
local json_params = require("lapis.application").json_params
local json_response = require "api-umbrella.web-app.utils.json_response"
local nillify_json_nulls = require "api-umbrella.utils.nillify_json_nulls"
local time = require "api-umbrella.utils.time"

local _M = {}

function _M.create(self)
  assert(Contact:authorized_deliver(_M.contact_params(self)))
  local response = {
    submitted = time.timestamp_to_iso8601(ngx.now()),
  }

  return json_response(self, response)
end

function _M.contact_params(self)
  local params = {}
  if self.params and self.params["contact"] then
    local input = self.params["contact"]
    params = nillify_json_nulls({
      name = input["name"],
      email = input["email"],
      api = input["api"],
      subject = input["subject"],
      message = input["message"],
    })
  end

  return params
end


return function(app)
  app:post("/api-umbrella/v1/contact(.:format)", capture_errors_json_full(json_params(_M.create)))
end