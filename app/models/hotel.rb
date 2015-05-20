class Hotel < ActiveRecord::Base
  belongs_to :user
  has_many :ratings, dependent: :destroy
  accepts_nested_attributes_for :ratings
  # mount_uploader :photo, PhotoUploader

  validates_associated :user
  validates :ratings, presence: true
  validates_presence_of :title

end
