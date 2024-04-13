class Service < ApplicationRecord
  belongs_to :api

  enum req_method: {GET: 0, POST: 1}
  enum service_family: {likes: 0, followers: 1, video_views: 2, comments: 3, custom_comments: 4}
end
