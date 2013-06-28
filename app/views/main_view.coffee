class App.MainView extends Mozart.View
  templateName: 'app/templates/main_view'

  afterRender: =>
    App.mainController.loadCountries()
