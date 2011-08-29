require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'time'

describe PagerDutyRestClient do
  subject {PagerDutyRestClient.new('orgname', 'user@orgname.com', 'password')}

  context 'get_schedule_data' do

    it "hits the right url" do
      subject.should_receive(:authenticated_get).with('/api/v1/schedules/code/entries', instance_of(Hash))
      subject.get_schedule_data('code', Time.now, Time.now)
    end

    it "correctly converts the dates to UTC" do
      time1          = Time.parse '2011-08-29T12:56+10'
      expected_time1 = '2011-08-29T02:56+0'
      time2          = Time.parse '2011-08-29T22:56-10'
      expected_time2 = '2011-08-30T08:56+0'

      subject.should_receive(:authenticated_get).with(instance_of(String), 'since' => expected_time1, 'until' => expected_time2)
      subject.get_schedule_data('code', time1, time2)
    end

    it "passes through extra arguments" do
      subject.should_receive(:authenticated_get).with(instance_of(String), hash_including(:overflow => true))
      subject.get_schedule_data('code', Time.now, Time.now, :overflow => true)
    end
  end

  context 'get_incidents_count' do
    it "hits the right url" do
      subject.should_receive(:authenticated_get).with('/api/v1/incidents/count', instance_of(Hash))
      subject.get_incidents_count
    end

    it "passes through extra arguments" do
      subject.should_receive(:authenticated_get).with(instance_of(String), hash_including('since' => '2011-08-29'))
      subject.get_incidents_count('since' => '2011-08-29')
    end
  end

  context 'get_incidents_data' do
    it "hits the right url" do
      subject.should_receive(:authenticated_get).with('/api/v1/incidents', instance_of(Hash))
      subject.get_incidents_data
    end

    it "passes through extra arguments" do
      subject.should_receive(:authenticated_get).with(instance_of(String), hash_including('since' => '2011-08-29'))
      subject.get_incidents_data('since' => '2011-08-29')
    end
  end
end
