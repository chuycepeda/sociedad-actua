# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#organization_town").chosen
    allow_single_deselect: true
    no_results_text: 'No se encontraron coincidencias.'
    width: '200px'
$ ->
  $("#organization_causes_interest").chosen
    allow_single_deselect: true
    no_results_text: 'No se encontraron coincidencias'
    width: '400px'
