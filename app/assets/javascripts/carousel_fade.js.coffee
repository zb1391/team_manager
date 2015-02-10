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
			test: null,
			carouselControl: null
			, options

		$elem = $(this)
		prev = null
		next = null
		cur = null
		curIndex = null
		slides = null

		timeout = null

		getNext = () ->
			if curIndex == slides.length-1
				next = 0
				curIndex = 0
			else
				next = curIndex+1
				curIndex = curIndex+1

		getPrev = () ->
			if curIndex == 0
				next = slides.length-1
				curIndex = slides.length-1
			else
				next = curIndex-1
				curIndex = curIndex-1

		fadeLoop = () ->
			timeout = setTimeout( () ->
				console.log('fading out')
				slide(1)
			, 6000)

		slide = (direction) ->
			if settings.carouselControl?
				settings.carouselControl.hide()
			$(cur).fadeOut(1000, () ->
				if direction > 0
					getNext()
				else
					getPrev()
				
				cur = slides[next]
				showActive()
			)
		showActive = () ->
			$(cur).fadeIn(4000, () ->
				if settings.carouselControl?
					settings.carouselControl.show()
				fadeLoop()
			)

		addListeners = () ->
			if settings.carouselControl?
				settings.carouselControl.find('.glyphicon-chevron-right').click (e) ->
					settings.carouselControl.find('.glyphicon-pause').show()
					settings.carouselControl.find('.glyphicon-play').hide()
					clearTimeout(timeout)
					slide(1)
				settings.carouselControl.find('.glyphicon-chevron-left').click (e) ->
					settings.carouselControl.find('.glyphicon-pause').show()
					settings.carouselControl.find('.glyphicon-play').hide()
					clearTimeout(timeout)
					slide(-1)
				settings.carouselControl.find('.glyphicon-pause').click (e) ->
					clearTimeout(timeout)
					$(this).hide()
					settings.carouselControl.find('.glyphicon-play').show()
				settings.carouselControl.find('.glyphicon-play').click (e) ->
					fadeLoop()
					$(this).hide()
					settings.carouselControl.find('.glyphicon-pause').show()


		this.initializeCarousel = () ->
			addListeners()
			slides = $elem.find('.item')
			cur = slides[0]
			curIndex = 0
			fadeLoop()


		return this.initializeCarousel()
