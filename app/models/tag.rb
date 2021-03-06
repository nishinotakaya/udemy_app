# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :board_tag_relations, dependent: :delete_all #destoryメソットで消すときになる
  has_many :boards, through: :board_tag_relations #一つのタグが複数の掲示板を持ち、throughはboard_tag_relationsを関連付けてboardと関連付ける
end
