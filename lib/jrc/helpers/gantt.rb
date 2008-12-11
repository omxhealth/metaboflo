# Redmine - project management software
# Copyright (C) 2006-2008  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

module Jrc
  module Helpers
    
    # Simple class to handle gantt chart data
    class Gantt
      attr_reader :year_from, :month_from, :date_from, :date_to, :zoom, :months, :events

      def initialize(options={})
        options = options.dup
        @events = []

        if options[:year] && options[:year].to_i > 0 # User passed in a specific year
          @year_from = options[:year].to_i
          if options[:month] && options[:month].to_i >= 1 && options[:month].to_i <= 12 # User passed in a specific month
            @month_from = options[:month].to_i
          else
            @month_from = 1
          end
        else # User passed in no date, so default to today
          @month_from ||= Date.today.month
          @year_from ||= Date.today.year
        end

        zoom = (options[:zoom]).to_i
        @zoom = (zoom > 0 && zoom < 5) ? zoom : 2    
        months = (options[:months]).to_i
        @months = (months > 0 && months < 25) ? months : 6

        @date_from = Date.civil(@year_from, @month_from, 1)
        @date_to = (@date_from >> @months) - 1
      end

      def events=(e)
        @events = e.sort { |x,y| x.start_date <=> y.start_date }
      end
      
      # Return the parameters in a hash used to access the current date and zoom level
      def params
        { :zoom => zoom, :year => year_from, :month => month_from, :months => months }
      end

      def params_previous
        { :year => (date_from << months).year, :month => (date_from << months).month, :zoom => zoom, :months => months }
      end

      def params_next
        { :year => (date_from >> months).year, :month => (date_from >> months).month, :zoom => zoom, :months => months }
      end
    end
  end

end
