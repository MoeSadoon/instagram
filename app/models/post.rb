class Post < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "500x500>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :user

  # def self.build_with_user(params, user)
  #   post = self.new(params, user_id: user.id)
  # end

  def destroy_for_user(post)
    if post.user_id == current_user.id
      post.destroy
      return true
    end
    false
  end

end
