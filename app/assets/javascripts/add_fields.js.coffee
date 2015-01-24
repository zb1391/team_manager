# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$('form').on('click', '.add_fields', (event)->
		console.log('fick you')
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'),'g')
		$(this).before($(this).data('fields').replace(regexp,time))
		event.preventDefault()
	)

	$('form').on('click', '.remove_nested_attribute', (event) ->
		$(this).siblings('._destroy').val('1')
		$(this).parent().hide()
		event.preventDefault()

	)