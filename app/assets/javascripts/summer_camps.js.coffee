# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	changed_price = false
	if $('#summer_camp_is_all_day')[0].checked
		$('.time-fields').hide()
	
	$('#summer-camp-form').on 'change', '#summer_camp_price', (event) ->
		if $(this).val() != gon.summer_camp_price && summer_camp_price != 0
			alert(('The price enters differs from other camps this year. '+
				'Submitting this price will change all other camps this '  +
				'year to use this price as well.'))


	$('#summer-camp-form').on 'change', '#summer_camp_is_all_day', (event) ->
		if $(this)[0].checked
			$('.time-fields').hide()
		else
			$('.time-fields').show()
