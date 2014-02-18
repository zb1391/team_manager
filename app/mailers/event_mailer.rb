class EventMailer < ActionMailer::Base
  default from: "postmaster@sandbox56335.mailgun.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.new_event.subject
  #
  def new_event(player, event)
    @player=player
    @event = event
    mail(to: @player.email, subject: "#{event.eventtype.name} scheduled #{event.the_date}")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.changed_event.subject
  #
  def changed_event(player,oldevent,newevent)
    @player=player
    @event = newevent
    @oldevent = oldevent
    mail(to: @player.email, subject: "#{@oldevent.eventtype.name} on #{oldevent.the_date} has changed")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.destroyed_event.subject
  #
  def destroyed_event(player,event)
    @player=player
    @event = event
    mail(to: @player.email, subject: "Cancelled #{@event.eventtype.name} on #{event.the_date}")
  end
end
