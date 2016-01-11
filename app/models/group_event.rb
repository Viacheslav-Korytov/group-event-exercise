class GroupEvent < ActiveRecord::Base
	validates :event_duration, numericality: { only_integer: true }, allow_blank: true
	validates :event_start, :event_end, :event_duration, :name, :description, :location, presence: true, if: "published"
	validate :at_least_one_field
	after_save :update_time
	before_update :save_previous
	after_update :recheck_time
	
	def destroy
		update_columns(deleted: true)
	end
	
private
	def at_least_one_field
		if [event_start.to_s, event_end.to_s, event_duration.to_s, name, description, location].reject(&:blank?).size == 0
			errors[:base] << ("Please choose at least one field.")
		end
	end
	
	def update_time
		ar = [event_start.nil?, event_end.nil?, (event_duration.nil? || event_duration.zero?)]
		case ar
		when [false, true, false]
			update_column( :event_end, event_start + event_duration.day)
		when [false, false, true]
			update_column( :event_duration, (event_end - event_start).to_i)
		when [true, false, false]
			update_column( :event_start, event_end - event_duration.day)
		else
		end
	end
	
	def recheck_time
		ar = [(@before_update.event_start != event_start), (@before_update.event_end != event_end), (@before_update.event_duration != event_duration)]
		case ar
		when [false, true, false]
			update_column( :event_duration, (event_end - event_start).to_i)
		when [false, false, true]
			update_column( :event_end, event_start + event_duration.day)
		when [true, false, false]
			update_column( :event_end, event_start + event_duration.day)
		end
	end
	
	def save_previous
		@before_update = GroupEvent.find(id)
	end
end
