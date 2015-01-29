# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$('#organization-form').on 'change', '.use_organization_info', (event) ->
		console.log($(this))
		if $(this).is(':checked')
			contact = $('#organization_contact_name').val()
			email = $('#organization_email').val()
			phone = $('#organization_phone').val()
			if !!contact && !!email && !!phone
				$(this).siblings('.club_coach_name').val(contact)
				$(this).siblings('.club_coach_email').val(email)
				$(this).siblings('.club_coach_cell').val(phone)
			else
				alert('Please fill in all organization info before using this checkbox')
				$(this).attr('checked', false)
		else
			$(this).siblings('.club_coach_name').val('')
			$(this).siblings('.club_coach_email').val('')
			$(this).siblings('.club_coach_cell').val('')