class Hotel < ActiveRecord::Base
  belongs_to :user
  # has_many :ratings
  # mount_uploader :photo, PhotoUploader

  validates_associated :user
  validates_presence_of :title

end
