# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ = jQuery

$ ->
	# hide the name if is invitational or one day shootout
	if $('#tournament_tournament_type_id option:selected').text() != 'Other'
		$('#tournament-form .form-panel .tournament_name').hide()

	# hide the end date if one day shootout
	if $('#tournament_tournament_type_id option:selected').text() == 'One Day Shootout'
		$('#tournament-form .form-panel .tournament_end_date').hide()

	$('#tournament_tournament_type_id').on 'change', () ->
		if $(this).find('option:selected').text() != 'Other'
			$('#tournament-form .form-panel .tournament_name').hide()
			# $('#tournament-form .form-panel #tournament_name').val('')
		else
			$('#tournament-form .form-panel .tournament_name').show()

		if $('#tournament_tournament_type_id option:selected').text() == 'One Day Shootout'
			$('#tournament-form .form-panel #tournament_end_date_container').hide()
		else
			$('#tournament-form .form-panel #tournament_end_date_container').show()

