# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ = jQuery

$ ->
	# hide the name if is invitational
	if $('#tournament-form .form-panel #tournament_is_invitational').is(':checked')
		$('#tournament-form .form-panel .tournament_name').hide()

	$('#tournament-form .form-panel #tournament_is_invitational').on 'change', () ->
		if this.checked
			$('#tournament-form .form-panel .tournament_name').hide()
			# $('#tournament-form .form-panel #tournament_name').val('')
		else
			$('#tournament-form .form-panel .tournament_name').show()


	$('#tournament-form').submit () ->
		if $('#tournament-form .form-panel #tournament_display_info').is(':checked')
			alert("Warning - This tournament's information will be used on the Leagues and Tournament Pages. Please choose a different tournament if you do not want to use this information. If no tournaments are chosen default information will be displayed.")
