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
	dynamicFormPreviewerCreator: (inputContainerClass,dynamicPreviewFieldContainer, removerClass,triggerEvent, options) ->
		defaultFormatter = (elem) ->
			if !elem.val()
				return settings.defaultVal
			return elem.val()

		settings = $.extend
			test: null,
			formatter: defaultFormatter,
			defaultVal: 'EMPTY_VALUE',
			elementType: null
			, options

		$elem = $(this)

		createNewInput = () ->
			time = new Date().getTime()
			regexp = new RegExp($elem.data('id'),'g')
			$elem.before($elem.data('fields').replace(regexp,time))
			return time

		createListener = () ->
			console.log('creating listener')
			console.log($elem)
			$elem.on 'click', (event) ->

				event.preventDefault()
				
				# create the new input element
				newId = createNewInput()

				# get the newly created element
				newInput = $elem.siblings('.'+inputContainerClass).last()
				console.log(newInput)
				
				# get the last created element in the dynamicPreviewFieldContainer
				lastPreviewElem = dynamicPreviewFieldContainer.children().last()
				oldId = lastPreviewElem.data('id')
				console.log(oldId)

				# replace the old id with the new id
				lastPreviewElemHTML = lastPreviewElem.prop('outerHTML')
				console.log(lastPreviewElemHTML)
				regexp1 = new RegExp('data-id=\"'+oldId+'\"','g')

				# create a new element in the dynamicPreviewFieldContainer with the new id
				# newId = newInput.data('id')
				newPreviewElemHTML = lastPreviewElemHTML.replace(regexp1, 'data-id=\"'+newId+'\"')
				
				# replace the element type if the option is specified
				if settings.elementType?
					regexElement1 = new RegExp('<(.*?)>')
					regexElement2 = new RegExp('<\/(.*?)>')
					newPreviewElemHTML = newPreviewElemHTML.replace(regexElement1,settings.elementType)
					newPreviewElemHTML = newPreviewElemHTML.replace(regexElement2, settings.elementType)
				
				dynamicPreviewFieldContainer.append(newPreviewElemHTML)


				# get the newly created preview element and set text to '' 
				newPreviewElem = dynamicPreviewFieldContainer.children().last()
				newPreviewElem.text('')
				newPreviewElem.show()
				
				# get the remove link for the new input
				remover = newInput.find('.'+removerClass)

				newInput.dynamicFormPreviewer(
					remover,
					dynamicPreviewFieldContainer.children().last(),
					triggerEvent,
					settings)

		this.dynamicFormPreviewerCreatorInitialize = () ->
			createListener()

		return this.dynamicFormPreviewerCreatorInitialize()
