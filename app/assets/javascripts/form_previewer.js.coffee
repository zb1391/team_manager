$.fn.extend
	formPreviewer: (previewField, triggerEvent, defaultVal, options) ->
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
			console.log('trying to listen for changes')
			# update the previewField's val to the changed val
			$elem.on triggerEvent, () ->
				console.log('it changed')
				previewField.text(settings.formatter($elem))

		this.formPreviewerInitialize = () ->
			console.log('in initialize')
			createListener()

		return this.formPreviewerInitialize()
