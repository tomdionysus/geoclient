App.Country = Mozart.Model.create
  modelName: 'Country'

App.Country.attributes
  'code_alpha_2':'string'
  'code_alpha_3':'string'
  'code_numeric':'string'
  'default_currency_code':'string'
  'default_language_code':'string'
  'name':'string'

App.Country.index 'code_alpha_2'