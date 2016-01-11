require 'rails_helper'

RSpec.describe GroupEvent, type: :model do

	it "should run for a whole number of days" do
		expect(GroupEvent.create( { event_start: Time.now, event_duration: 10 })).to be_valid
	end
	it "should not run in case of not whole number of days" do
		expect(GroupEvent.create( { event_start: Time.now, event_duration: 5.5 })).not_to be_valid
	end
	describe "it has attributes to set and update the start, end or duration of the event (and calculate the other value)" do
		it "calculates end from start and duration" do
			group_event = GroupEvent.create!( { event_start: Time.now, event_duration: 10 } )
			expect(group_event.event_end).to eq(Time.now.to_date + 10.days)
		end
		it "calculates duration from start and end" do
			group_event = GroupEvent.create!( { event_start: Time.now, event_end: Time.now + 2.days } )
			expect(group_event.event_duration).to eq(2)
		end
		it "calculates start from end and duration" do
			group_event = GroupEvent.create!( { event_end: Time.now + 3.days, event_duration: 2 } )
			expect(group_event.event_start).to eq(Time.now.to_date + 1.day)
		end
		it "re-calculates event duration when changed only event end" do
			group_event = GroupEvent.create!( { event_start: Time.now, event_duration: 15 } )
			group_event.update!( { event_end: Time.now + 20.days } )
			expect(group_event.event_end).to eq(Time.now.to_date + 20.days)
			expect(group_event.event_duration).to eq(20)
		end
		it "re-calculates event end when changed only event duration" do
			group_event = GroupEvent.create!( { event_start: Time.now, event_duration: 15 } )
			group_event.update!( { event_duration: 20 } )
			expect(group_event.event_end).to eq(Time.now.to_date + 20.days)
			expect(group_event.event_duration).to eq(20)
		end
		it "re-calculates event end when changed only event start" do
			group_event = GroupEvent.create!( { event_start: Time.now, event_duration: 15 } )
			group_event.update!( { event_start: Time.now + 5.days } )
			expect(group_event.event_end).to eq(Time.now.to_date + 20.days)
			expect(group_event.event_duration).to eq(15)
		end
	end
	it "can be saved with only a subset of fields before published" do
		expect(GroupEvent.create( { name: "Event" })).to be_valid
	end
	it "can be published if all of the fields are present" do
		expect(GroupEvent.create( { event_start: Time.now, event_end: Time.now + 2.days, event_duration: 2, name: "Event", description: "Test Event", location: "Any", published: true })).to be_valid
	end
	it "can be published by update if all of the fields are present" do
		group_event = GroupEvent.create!( { event_start: Time.now, event_end: Time.now + 2.days, event_duration: 2, name: "Event", description: "Test Event", location: "Any" } )
		group_event.update!( { published: true } )
		expect(group_event.published).to eq(true)
	end
	it "should be kept in the database and marked as deleted after destoying" do
		group_event = GroupEvent.create!( { event_start: Time.now, event_duration: 10 } )
		expect { group_event.destroy }.to change(GroupEvent, :count).by(0)
		expect(group_event.deleted).to eq(true)
	end
end
