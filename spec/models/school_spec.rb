# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           default(""), not null
#  lat        :decimal(10, 7)   default(0.0)
#  lng        :decimal(10, 7)   default(0.0)
#

require 'rails_helper'

RSpec.describe School, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
