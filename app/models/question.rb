class Question < ActiveRecord::Base
    has_many :choices
    belongs_to :correct_choice, class_name: 'Choice'
end
