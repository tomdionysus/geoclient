class App.MainController extends Mozart.Controller

  init: =>
    @set 'regions', App.Region
    @set 'countries', App.Country
    @set 'subdivisions', App.Subdivision

    @set 'currentCountry', false
    @set 'currentSubdivisions', false
    @set 'currentSubdivision', false
    @bind 'change:currentCountry', @loadSubdivisions

    @host = "http://localhost:9292"

    @http = Mozart.HTTP.create()

  loadCountries: =>
    @http.get("#{@host}/countries", {
      callbacks:
        success: @loadCountrySuccess
        error: @loadCountryError
    })

  loadCountrySuccess: (data) =>
    unless data?
      console.log("loadCountrySuccess: No data returned")
      return

    for country in data
      inst = @countries.findByAttributes({code_alpha_2:country.code_alpha_2})
      if inst.length == 0
        inst = @countries.createFromValues(country)
      else
        inst = inst[0]
        inst.copyFrom(country)
        inst.save()

  loadSubdivisions: =>
    @http.get("#{@host}//subdivisions?country_code_alpha_2="+@currentCountry.code_alpha_2, {
      callbacks:
        success: @loadSubdivisionsSuccess
        error: @loadSubdivisionsError
    })

  loadSubdivisionsSuccess: (data) =>
    unless data?
      console.log("loadSubdivisionsSuccess: No data returned")
      return

    for subdivision in data
      inst = @subdivisions.findByAttributes({code:subdivision.code})
      if inst.length == 0
        inst = @subdivisions.createFromValues(subdivision)
      else
        inst = inst[0]
        inst.copyFrom(subdivision)
        inst.save()

    subs = App.Subdivision.findByAttribute('country_code_alpha_2',@currentCountry.code_alpha_2)
    @set 'currentSubdivisions', if subs? and subs.length>0 then subs else false

  selectCountry: (source, data) =>
    if data?.country?
      @set 'currentCountry', data.country
    else
      @set 'currentCountry', false

    @set 'currentSubdivision', false

  selectSubdivsion: (source, data) =>
    if data?.subdivision?
      @set 'currentSubdivision', data.subdivision
    else
      @set 'currentSubdivision', false
