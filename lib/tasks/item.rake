namespace :item do
  desc 'get items'
  task :get => :environment do
    Rails.logger.info "start rake item:get #{Time.now}"

    Feed.all.each do |feed|
      feed.update_items!
    end

    Rails.logger.info "end rake item:get #{Time.now}"
  end
end
