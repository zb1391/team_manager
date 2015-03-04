$.fn.extend  
  # filters out previously selected options from all other associated selects
  # adds them back when they change
  # selectedFilters - if we are in the form and there is a validation error, keep the list of selected items
  #                 - to preserve functionality
  # selectClass     - the class identifier of the select we want to maniupate
  # removeClass     - the class identifer of the remove link next to each select
  # parentClass     - the div ancestor of select, typically the topmost container in the nested attribute partial (.row)
  filteredSelects: (selectedFilters, selectClass, removeClass, parentClass, options) ->
    settings = $.extend
      dummy: null
      , options

    $elem = $(this)

    # get a list of all options from the beginning
    allOptions = $elem.find(selectClass).first().find('option')

    # get a deep copy of the original select and its div container
    newFieldAttr = $elem.children(parentClass).first().clone(true)

    previousValue = undefined     # global to keep track of which option was selected for we delete it
    currentSelect = undefined     # global to keep track of which select was just deleted
    selectInput = undefined       # $(currentSelect)

    # hide the first select's remove link, it should always be present
    $elem.find(removeClass).first().remove()

    # Functions for Adding/Removing Elements from Filter Array
    removeFromSelectedFilters = (toRemove) ->
      selectedFilters = $.grep(selectedFilters,(value) ->
        return value != toRemove
    )

    # Return a list of which options should be in a given select dropdown
    # exceptThisOption - the select's value - we always want to keep this
    removeSelectOptions = (exceptThisOption) ->
      newOptions = $.grep(allOptions, (curOption) ->
        shouldNotRemove = true
        i = 0
        while i<selectedFilters.length
          # Remove from list if there is a match AND the current select does not have a current_value
          if selectedFilters[i] == $(curOption).val() && selectedFilters[i] != exceptThisOption && $(curOption).val() != ''
            shouldNotRemove = false
          i++
        return shouldNotRemove
      )
      return newOptions

    # Iterates over each select in form and filters the options
    # based on what is currently selected by others
    filterEachSelectDropdown = (exceptThisSelect) ->
      all_selects = $(selectClass)
      i = 0
      while i<all_selects.length
        if $(exceptThisSelect).attr('id') != $(all_selects[i]).attr('id')
          # remember which option they had selected
          selected_val = $(all_selects[i]).val()

          # filter all options besides the one they had selected
          newOptions = removeSelectOptions(selected_val)

          # clear all options - this also clears the selected option value
          $(all_selects[i]).empty()

          # append newOptions to the select
          $(all_selects[i]).append($(newOptions).clone(true))

          # reassign the selected value
          $(all_selects[i]).val(selected_val)
        i++

    setDataFields = () ->
      select = $(newFieldAttr).find('select')
      newOptions = removeSelectOptions()
      $(select).empty()
      $(select).append($(newOptions).clone(true))

      # this is what i want to do
      # remove all values from all inputs
      # the data field to this new thing
      html = $(newFieldAttr)[0].outerHTML

      $elem.find('.add_fields').data('fields', html)
      $elem.find('.add_fields').data('id', '0')

    addListener = () ->
    # Listen to changes to any request to complete
    # remove the selected from the global list so a different select cant choose the same one
    $elem.on('click', selectClass, () ->
      currentSelect = this
      previousValue = $(this).val()
      selectInput = $(this)
      selectInput.change (event) ->
        if selectInput.val() != ""
          if previousValue != ""
            removeFromSelectedFilters(previousValue)
          selectedFilters.push(selectInput.val())
        else
          removeFromSelectedFilters(previousValue)

        filterEachSelectDropdown(currentSelect)
        setDataFields()
    )

    # Listen for when the user clicks the remove button
    $elem.on('click', removeClass, (e) ->
      previousValue = $(this).closest(parentClass).find('select').val()
      $(this).closest(parentClass).remove()
      removeFromSelectedFilters(previousValue)
      filterEachSelectDropdown()
      setDataFields()
      e.preventDefault()
    )

    this.filter_initialize = () ->
      addListener()
      filterEachSelectDropdown()
      setDataFields()
      this

    return this.filter_initialize()