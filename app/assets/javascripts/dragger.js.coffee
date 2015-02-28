$ = jQuery

$ ->
	$("#draggable").draggable()

	$('#admin_nav').on 'click', (e) ->
		e.preventDefault()
		$('#search-modal').modal()
		$('#admin-search #redirect_to').focus()
		$('#admin-search #redirect_to').autocomplete(
			source: gon.admin_routes
			minLength: 2
			
			focus: (event, ui) ->
				$('#admin-search #redirect_to').val(ui.item.label)
				return false
			select: ( event, ui) ->
				$('#redirect_to').val(ui.item.label)
				$('#redirect_path').val(ui.item.value)
				return false
			messages:
				noResults: '',
				results: () ->
		)