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
	carouselFade: (options) ->
		settings = $.extend
			test: null
			, options

		$elem = $(this)
		prev = null
		next = null
		cur = null
		curIndex = null
		slides = null

		getNext = () ->
			if curIndex == slides.length-1
				next = 0
				curIndex = 0
			else
				next = curIndex+1
				curIndex = curIndex+1

		fadeLoop = () ->
			setTimeout( () ->
				console.log('fading out')
				$(cur).fadeOut(1000, () ->
					cur = slides[next]
					getNext()
					console.log(next)
					showActive()
				)
			, 6000)

		showActive = () ->
			$(cur).fadeIn(4000, () ->
				fadeLoop()
			)

		this.initializeCarousel = () ->
			slides = $elem.find('.item')
			console.log(slides)
			cur = slides[0]
			curIndex = 0
			getNext()
			fadeLoop()


		return this.initializeCarousel()
