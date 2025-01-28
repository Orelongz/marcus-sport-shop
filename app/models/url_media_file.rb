class UrlMediaFile < ApplicationRecord
  belongs_to :url_media_able, polymorphic: true
end

# == Schema Information
#
# Table name: url_media_files
#
#  id                  :bigint           not null, primary key
#  url                 :string
#  url_media_able_type :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  url_media_able_id   :bigint
#
# Indexes
#
#  index_url_media_files_on_url_media_able  (url_media_able_type,url_media_able_id)
#
