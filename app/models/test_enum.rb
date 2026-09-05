class TestEnum < ApplicationRecord
  enum status: { pending: 0, active: 1, archived: 2 }
end
