# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ = jQuery

$ ->

	# Hide season if one day shootout
	if $('#display_tournament_tournament_type_id').data('name') != 'Invitational'
		$('#season-container').hide()

	$('#display-tournament-form').submit () ->
		if $('#display-tournament-form .form-panel #display_tournament_active').is(':checked')
			alert("Warning - This tournament's information will be used on the Leagues and Tournament Pages. Please choose a different tournament if you do not want to use this information. If no tournaments are chosen default information will be displayed.")


	$('#display_tournament_price').formPreviewer($('#view-price'), 
		'keyup', 
		formatter: (elem) ->
			return '$'+elem.val())
	$('#display_tournament_season').formPreviewer($('#view-season-header'),'change')

	$('#display_tournament_season').formPreviewer($('#view-season-p'),'change')

	$('#display_tournament_genders').formPreviewer($('#view-gender'),
		'change',
		formatter: (elem) ->
			if elem.val() == 'Both'
				return 'Boys and Girls'
			else
				return elem.val()
		)
	$('#display_tournament_guaranteed_games').formPreviewer($('#view-guaranteed_games'), 
		'keyup')

	$('#display_tournament_min_grade').formPreviewer($('#view-min_grade'),'change')
	$('#display_tournament_max_grade').formPreviewer($('#view-max_grade'),'change')


	$('#display-tournament-form .nested-attributes').each((index) ->
		if index == 0
			$(this).find('.remove_nested_attribute').hide()
		selectField = $(this).find('select')
		removeLink = $(this).find('.remove_nested_attribute')
		selectField.dynamicFormPreviewer(
			selectField.siblings('.remove_nested_attribute'),
			$('dd[data-id=\"'+index+'\"'),
			'change',
			formatter: (elem) ->
				return elem.find('option:selected').text()
		)
	)
	# $('#display_tournament_display_tournament_locations_attributes_0_location_id').dynamicFormPreviewer(
	# 	$('#display_tournament_display_tournament_locations_attributes_0_location_id').siblings('.remove_nested_attribute'),
	# 	$('dd[data-id="0"]'),
	# 	'change',
	# 	formatter: (elem) ->
	# 		return elem.find('option:selected').text()
	# 	)

	$('#display-tournament-form .dynamic_preview_creator').dynamicFormPreviewerCreator(
		'nested-attributes',
		$('#locations-preview-container'),
		'remove_nested_attribute',
		'change',
		formatter: (elem) ->
			return elem.find('option:selected').text()		
		)







