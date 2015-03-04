$ = jQuery

$ ->
	html_string = """
		<div class="nested-attributes">
			<div class="row">
				<div class="col-xs-6">
					<label>TYPE</label>
					<input class="form-control" id="list_item_TERM" name="list_item_TERM" type="text"></input>
				</div>
				<div class="col-xs-1">
					<br />
					<a href="#" class="remove_list_item">x</a>
				</div>
			</div>
		</div>
	"""
	regexp1 = new RegExp('TERM','g')
	regexp2 = new RegExp('TYPE','g')

	$('#home-page-panel-form').submit((e)->
		# remove items that were x'd out
		$('.home-panel').find(':hidden').remove()
		# extract the paragraph and dl to string
		html = $('#paragraph')[0].outerHTML
		html = html+$('dl')[0].outerHTML

		# write to hidden attribute
		$('#home_page_panel_html').val(html)
	)

	$('#home_page_panel_title').formPreviewer($('#title'), 'keyup')
	$('#home_page_panel_additional_link_text').formPreviewer($('#display_link'),'keyup')
	$('#home_page_panel_p').formPreviewer($('#paragraph'), 'keyup', defaultVal: '')
	
	$('#home-page-panel-form').on 'click', '.hide_p', (e) ->
		e.preventDefault()
		$('#paragraph').hide()

	$('#home-page-panel-form').on 'click', '.show_p', (e)->
		e.preventDefault()
		$('#paragraph').show()

	$('.list-items').children('.nested-attributes').each((index)->
		inputField = $(this).find('input')
		remover = $(this).find('.remove_list_item')
		displayItemString = inputField.attr('data-type')+'[data-id="'+index+'"]'
		console.log(displayItemString)
		displayItem = $(displayItemString)
		inputField.dynamicFormPreviewer(remover, displayItem, 'keyup')
	)



	# Listeners to add dt's and dd's
	$('#add_term').click (e) ->
		e.preventDefault()
		time = new Date().getTime()
		$('.list-items').append(html_string.replace(regexp1,time).replace(regexp2,'dt'))
		preview_string = "<dt data-id='"+time+"'>ENTER TEXT</dt>"
		$('.display_list_items dl').append(preview_string)
		newPreview = $('.display_list_items dl').children().last()
		newItem = $('.list-items').find('input').last()
		remover = newItem.parent().parent().find('.remove_list_item')
		newItem.dynamicFormPreviewer(remover, newPreview, 'keyup')


	$('#add_definition').click (e) ->
		e.preventDefault()
		time = new Date().getTime()
		$('.list-items').append(html_string.replace(regexp1,time).replace(regexp2,'dd'))
		preview_string = "<dd data-id='"+time+"'>ENTER TEXT</dd>"
		$('.display_list_items dl').append(preview_string)
		newPreview = $('.display_list_items dl').children().last()
		newItem = $('.list-items').find('input').last()
		remover = newItem.parent().parent().find('.remove_list_item')
		newItem.dynamicFormPreviewer(remover, newPreview, 'keyup')

	$('#home-page-panel-form').on('click', '.remove_list_item', (e) ->
		e.preventDefault()
		$(this).parent().parent().hide()
	)

