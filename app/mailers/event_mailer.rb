class EventMailer < ActionMailer::Base
  ActionMailer::Base.smtp_settings = {
    :port =>           '587',
    :address =>        'smtp.mandrillapp.com',
    :user_name =>      ENV['MANDRILL_USERNAME'],
    :password =>       ENV['MANDRILL_APIKEY'],
    :domain =>         'heroku.com',
    :authentication => :plain
}

ActionMailer::Base.delivery_method = :smtp
  default from: ENV['DWN_TWN_ADDR']


  def new_team_event(team,event)
    @event = event
    @team = team
    emails = ""
    team.players.each do |player|
      emails += "#{player.email},#{player.parent_email},#{player.parent_email2},"
    end

    mail(to: team.coach.email, bcc: emails, subject: "#{event.eventtype.name} scheduled #{event.the_date}")

  end

  def changed_team_event(team,newevent,oldevent)
    @event = newevent
    @oldevent = oldevent
    @team = team
    emails = ""
    team.players.each do |player|
      emails += "#{player.email},#{player.parent_email},#{player.parent_email2},"
    end

    mail(to: team.coach.email, bcc: emails, subject: "#{@event.eventtype.name} scheduled #{@event.the_date}")

  end

   def destroyed_team_event(team,event)
    @event = event
    @team = team
    emails = ""
    team.players.each do |player|
      emails += "#{player.email},#{player.parent_email},#{player.parent_email2},"
    end

    mail(to: team.coach.email, bcc: emails, subject: "#{event.eventtype.name} scheduled #{event.the_date}")

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.new_event.subject
  #
  def new_event(player, event)
    @player=player
    @event = event
    emails = "#{player.email},#{player.parent_email},#{player.parent_email2}"
    mail(to: emails, subject: "#{event.eventtype.name} scheduled #{event.the_date}")
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
    emails = "#{player.email},#{player.parent_email},#{player.parent_email2}"
    mail(to: emails, subject: "#{@oldevent.eventtype.name} on #{oldevent.the_date} has changed")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.destroyed_event.subject
  #
  def destroyed_event(player,event)
    @player=player
    @event = event
    emails = "#{player.email},#{player.parent_email},#{player.parent_email2}"
    mail(to: emails, subject: "Cancelled #{@event.eventtype.name} on #{event.the_date}")
  end

  def new_player(player)
    @player = player
    emails = "#{player.email},#{player.parent_email},#{player.parent_email2}"
    mail(to: emails, subject: "Registration Complete!")
  end
end
