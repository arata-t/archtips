class TestWorker
  include Sidekiq::Worker
  def perform(tip_params, tag_list)
    tip = TipTag.new(tip_params)
    tip.save(tag_list)
  end
end