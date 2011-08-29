# PagerDutyRestClient

Quick and dirty class for talking to the PagerDuty REST api.

## Examples

### instantiation:
    client = PagerDutyRestClient.new('orgname', 'user@orgname.com', 'password')

### get_schedule_data:

    client.get_schedule_data('ZZZ9ZZ', Time.now, Time.now)
    # => {"total"=>1, "entries"=>[{"end"=>"2011-08-28T23:29:00Z", "start"=>"2011-08-28T23:29:00Z", "user"=>{"name"=>"Bob Fakename", "id"=>"AAA1AAA", "email"=>"bob@orgname.com"}}]}

    client.get_schedule_data('ZZZ9ZZ', Time.now, Time.now, :overflow => true)
    # => {"total"=>1, "entries"=>[{"end"=>"2011-08-29T10:00:00Z", "start"=>"2011-08-21T09:59:00Z", "user"=>{"name"=>"Bob Fakename", "id"=>"AAA1AAA", "email"=>"bob@orgname.com"}}]}

### get_incident_count:

    client.get_incidents_count
    # => {"total"=>72}

### get_incident_data:

    client.get_incidents_data('since'=>'2011-08-29T11:41+10')
    # => {"incidents"=>[{"assigned_to_user"=>nil, "last_status_change_on"=>"2011-08-29T02:15:39Z", "trigger_summary_data"=>nil, "trigger_details_html_url"=>"http://orgname.pagerduty.com/incidents/OMGCODE/log_entries/OMGINCIDNET", "created_on"=>"2011-08-29T02:07:37Z", "service"=>{"name"=>"Stuff Broked!", "id"=>"INCIDENTID", "html_url"=>"http://orgname.pagerduty.com/services/WOWOMG"}, "last_status_change_by"=>nil, "html_url"=>"http://orgname.pagerduty.com/incidents/OMGWOW", "status"=>"resolved", "incident_number"=>42, "incident_key"=>"Swanky Key"}], "total"=>1, "limit"=>100}

## Contributing to PagerDutyRestClient

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Lucas Parry. See LICENSE.txt for
further details.

