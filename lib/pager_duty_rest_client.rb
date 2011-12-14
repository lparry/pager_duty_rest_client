require 'net/http'
require 'json'
require 'pager_duty_rest_client/version'
begin
  require 'net/https'
rescue LoadError
  puts "net/https was not found on your system, ssl support will not work without it"
end

class PagerDutyRestClient

  RootCA = '/etc/ssl/certs'

  def initialize(org_name, username, password, options = {})
    @options = {:https => false}.merge(options)
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

  def get_incidents_data(extra_args = {})
    path = "/api/v1/incidents"
    authenticated_get(path, extra_args)
  end

  def get_incidents_count(extra_args = {})
    path = "/api/v1/incidents/count"
    authenticated_get(path, extra_args)
  end

  private

  def use_https?
    !!@options[:https]
  end

  def protocol
    use_https? ? "https" : "http"
  end

  def authenticated_get(path, form_data)
    url = URI.parse("#{protocol}://#{@org_name}.pagerduty.com#{path}")

    req = Net::HTTP::Get.new(url.path)
    req.basic_auth @username, @password
    req.set_form_data(form_data, ';')

    http = Net::HTTP.new(url.host, url.port)
    configure_ssl(http) if use_https?
    res = http.start {|http| http.request(req) }

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      JSON.parse(res.body)
    else
      res.error!
    end

  end

  def configure_ssl(http)
    http.use_ssl = true

    if File.directory? RootCA
      http.ca_path = RootCA
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.verify_depth = 5
    else
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end

  def pagerduty_time_string(time)
    time.getutc.strftime("%Y-%m-%dT%H:%M+0")
  end
end
