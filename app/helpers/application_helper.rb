module ApplicationHelper

		def error_messages_for(object)
			render(:partial => 'application/error_messages', :locals => {:object => object})
			#render the partial, which displays the error messages for all the objects (subjects, pages, sections ..etc)
		end 


		def status_tag(boolean, options={})
			options[:true_text] ||= ''
			options[:false_text] ||= ''

			if boolean
				content_tag(:span, options[:true_text], :class => 'status true')
			else
				content_tag(:span, options[:false_text], :class => 'status false')
			end
		end
end

# it will first be empty, but if you go to the element, you can see it says eith status true or false, then you can style them with colors or images 
# since we are using it in all of the helpers, we want to put it in the application_helper