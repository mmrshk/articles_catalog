# frozen_string_literal: true

class NoticeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'notice_channel'
  end

  def unsubscribed; end
end
