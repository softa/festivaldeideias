# coding: utf-8
class User < ActiveRecord::Base

  include Rails.application.routes.url_helpers


  # User has many types of services (facebook, twitter and so on)
  has_many :services
  has_many :ideas
  has_many :colaborations, :through => :ideas
  validates_presence_of :name, :email
  attr_accessible :name, :email

  before_create :updates_notifications_read_at

  def updates_notifications_read_at
    self.notifications_read_at = Time.now
  end

  def self.create_from_hash!(hash)
    self.create(:name => hash['info']['name'], :email => hash['info']['email'])
  end

  def new_notifications_count
    Idea.new_collaborations(self).where(["created_at > ?", self.notifications_read_at]).size + 
    Idea.collaborations_status_changed(self).where(["updated_at > ?", self.notifications_read_at]).size + 
    Idea.collaborated_idea_changed(self).where(["updated_at > ?", self.notifications_read_at]).size
  end

  def notifications
    Idea.new_collaborations(self).map do |i|
      "<a href='#{category_idea_path(i.parent.category, i.parent.id)}'>#{i.user.name} quer colaborar com a sua ideia \"#{i.parent.title}\"</a>"
    end +
    Idea.collaborations_status_changed(self).map do |i|
      "<a href='#{category_idea_path(i.parent.category, i.parent.id)}'>A sua colaboração para a ideia \"#{i.parent.title}\" foi #{i.accepted ? "aceita" : "rejeitada"}.</a>"
    end +
    Idea.collaborated_idea_changed(self).map do |i|
      "<a href='#{category_idea_path(i.category, i.id)}'>A ideia \"#{i.title}\" a qual você colaborou foi atualizada.</a>"
    end
  end
end

