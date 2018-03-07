class Gallery < ApplicationRecord

#Method is for where i have written a Business logic
#Created by Varun
#Date = 7-3-18

	def self.gallery_visit params
		begin
			self.transaction do
				final_hash = {}
				final_result = {}
			    File.read(params[:log_file].tempfile).each_line do |line|
			    	line_to_arr = line.strip.split(' ')
			    	if line_to_arr.size > 2
				    	unless final_hash.include? line_to_arr[1]
				    		in_out_hash = {}
				    		in_out_hash[line_to_arr[0]] = {line_to_arr[2]=>line_to_arr[3]}
				    		final_hash[line_to_arr[1]] = in_out_hash 
				    	else
				    		if final_hash[line_to_arr[1]].include? line_to_arr[0]
				    			unless final_hash[line_to_arr[1]][line_to_arr[0]].include? line_to_arr[2]
				    				final_hash[line_to_arr[1]][line_to_arr[0]][line_to_arr[2]] = line_to_arr[3]
				    			end	
				    		else
				    			final_hash[line_to_arr[1]][line_to_arr[0]] = {line_to_arr[2]=>line_to_arr[3]}		
				    		end	
				    	end
				    end		
			    end				    	
			    #raw_hash = {"0"=>{"0"=>{"I"=>"540", "O"=>"560"}, "1"=>{"I"=>"540", "O"=>"560"}}}
			    
			    final_hash.map do |data|
					calculate_time = 0
					data[1].map do |time_data|
						time_duration   = time_data[1]["O"].to_i - time_data[1]["I"].to_i
						calculate_time += time_duration	
					end
					final_result[data[0].to_i] = {'visitor_total'=>data[1].size, 'minute_average_visit'=>(calculate_time/data[1].size)}
			    end
			    final_result
			end	
		rescue => e
			debugger
			errors.add(:base, e.message)
			false
		end
	end

end
