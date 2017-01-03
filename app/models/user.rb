class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable, :lockable

  belongs_to :site

  has_one :photo_file, class_name: 'StoredFile::Photo', as: :attachable
  accepts_nested_attributes_for :photo_file, allow_destroy: true

  has_many :tasks, foreign_key: 'assigned_to_id'
  has_many :samples, foreign_key: 'collected_by_id'

  scope :administrators,  -> { where(rank: 'Administrator') }
  scope :superusers,  -> { where(rank: 'Superuser') }
  scope :users, -> { where(rank: 'User') }

  def superuser?
    rank == 'Superuser'
  end

  def administrator?
    rank == 'Administrator'
  end

  def user?
    rank == 'User'
  end

  def to_s
    self.email
  end
end
