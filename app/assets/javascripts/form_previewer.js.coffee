$.fn.extend
	# Extension to display a preivew of what the form's inputs
	# will end up looking like on the site
	# This should be used on an input element
	# ---------------------
	# Arguments
	# previewField - the selector of the html element that will be updated
	# triggerEvent - the type of event that will trigger the display to change
	# options      - a hash of options
	# ----------------------
	# options
	# formatter    - a function to handle custom displays of the input data
	# defaultVal   - what to display when the input is null
	formPreviewer: (previewField, triggerEvent, options) ->
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
			# update the previewField's val to the changed val
			$elem.on triggerEvent, () ->
				previewField.text(settings.formatter($elem))

		this.formPreviewerInitialize = () ->
			createListener()

		return this.formPreviewerInitialize()
