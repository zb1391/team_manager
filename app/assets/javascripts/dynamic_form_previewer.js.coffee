$.fn.extend
	# Extension to display a preivew of what the form's dynamically created inputs
	# these inputs
	# Should be used on the link that dynamically creates the input fields
	# ---------------------
	# Arguments
	# remover      - the selector of link that when clicks hides the input element
	# previewField - the selector of the html element that will be updated
	# triggerEvent - the type of event that will trigger the display to change
	# options      - a hash of options
	# ----------------------
	# options
	# formatter    - a function to handle custom displays of the input data
	# defaultVal   - what to display when the input is null
	dynamicFormPreviewer: (remover, previewField, triggerEvent, options) ->
		defaultFormatter = (elem) ->
			if !elem.val()
				return settings.defaultVal
			return elem.val()

		settings = $.extend
			test: null,
			formatter: defaultFormatter,
			defaultVal: 'EMPTY_VALUE'
			, options

		$elem = $(this)

		createListener = () ->
			remover.on 'click', () ->
				console.log('clicked')
				previewField.hide()

		this.dynamicFormPreviewerInitialize = () ->
			# listen for when the remove link is clicked
			createListener()
			# call formPreviewer
			$elem.formPreviewer(previewField, triggerEvent, settings)

		return this.dynamicFormPreviewerInitialize()
