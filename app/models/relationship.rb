class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower, presence: true
  validates :followed, presence: true

  before_create :activity_follow
  before_destroy :activity_unfollow

  private

  def activity_follow
    Activity.create user: follower, target_id: followed.id, action: "follow"
  end

  def activity_unfollow
    Activity.create user: follower, target_id: followed.id, action: "unfollow"
  end
end
