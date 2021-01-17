class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { in: 1..250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }


    validate :clickbait

    CLICKBAIT_PATTERNS = [
      /Won't Believe/i,
      /Secret/i,
      /Top [0-9]*/i,
      /Guess/i
    ]
  
    def clickbait
      if CLICKBAIT_PATTERNS.none? {|pattern| pattern.match(self.title)}
        self.errors.add(:title, "is not clickbait enough")
      end
    end
  end