require 'net/http'
require 'json'
require 'pager_duty_rest_client/version'

class PagerDutyRestClient

  def initialize(org_name, username, password)
    @org_name = org_name
    @username = username
    @password = password
  end

  def get_schedule_data(code, from, to, extra_args = {})
    path = "/api/v1/schedules/#{code}/entries"
    form_data = {
      'since' => pagerduty_time_string(from),
      'until' => pagerduty_time_string(to)
    }.merge(extra_args)
    authenticated_get(path, form_data)
  end

  private

  def authenticated_get(path, form_data)
    url = URI.parse("http://#{@org_name}.pagerduty.com#{path}")
    req = Net::HTTP::Get.new(url.path)
    req.basic_auth @username, @password
    req.set_form_data(form_data, ';')
    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      JSON.parse(res.body)
    else
      res.error!
    end

  end

  def pagerduty_time_string(time)
    time.getutc.strftime("%Y-%m-%dT%H:%M+0")
  end
end
