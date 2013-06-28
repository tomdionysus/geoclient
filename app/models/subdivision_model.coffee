App.Subdivision = Mozart.Model.create
  modelName: 'Subdivision'

App.Subdivision.attributes
  'code':'string'
  'name':'string'
  'category':'string'
  'parent_code':'string'
  'timezone_code':'string'
  'country_code_alpha_2':'string'

App.Subdivision.index 'country_code_alpha_2'