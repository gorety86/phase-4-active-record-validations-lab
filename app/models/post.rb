class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w[Fiction Non-Fiction] }
    validate :sufficiently_clickbait_title
    

    private
  
    def sufficiently_clickbait_title
      return if title.blank?
  
      clickbait_keywords = ['Won\'t Believe', 'Secret', /^Top \d+$/, 'Guess']
      unless clickbait_keywords.any? { |keyword| keyword.match?(title) }
        errors.add(:title, 'must be clickbait-y')
      end
    end
end
