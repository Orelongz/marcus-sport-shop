module CanUseCombinedMediaConcern
  extend ActiveSupport::Concern

  included do
    has_many :url_media_files, as: :url_media_able, dependent: :delete_all

    accepts_nested_attributes_for :url_media_files

    def media_urls
      url_media_files.pluck(:url)
    end
  end
end
