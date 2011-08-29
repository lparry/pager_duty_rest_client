require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'time'

describe PagerDutyRestClient do
  subject {PagerDutyRestClient.new('orgname', 'user@orgname.com', 'password')}

  let(:time1) { Time.parse '2011-08-29T12:56+10' }
  let(:expected_time1) { '2011-08-29T02:56+0' }
  let(:time2) { Time.parse '2011-08-29T22:56-10' }
  let(:expected_time2) { '2011-08-30T08:56+0' }

  it "correctly converts the dates to UTC" do
    subject.should_receive(:authenticated_get).with('/api/v1/schedules/code/entries', {'since' => expected_time1, 'until' => expected_time2})
    subject.get_schedule_data('code', time1, time2)
  end
end
