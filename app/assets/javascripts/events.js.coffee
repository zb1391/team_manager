# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	changed_price = false
	$('#event-form').on 'change', '#event_eventtype_id', (e) ->
		type = $(this).find("option:selected").text()
		if type == 'tournament'
			$('#event-form #event_end_date').parents('.row').show()
			$('#event-form #event_the_time').parents('.row').hide()
			$('#event-form #event_end_time').parents('.row').hide()
		else
			$('#event-form #event_end_date').parents('.row').hide()
			$('#event-form #event_the_time').parents('.row').show()
			$('#event-form #event_end_time').parents('.row').show()

	$('#event-form').submit (e) ->
		type = $('#event_eventtype_id option:selected').text()
		if type == 'tournament'
			$('#event-form #event_the_time').val('')
			$('#event-form #event_end_time').val('')
		else
			$('#event-form #event_end_date').val('')

