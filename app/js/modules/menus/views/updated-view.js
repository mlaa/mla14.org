/* Update information view */

MLA14.module('Views.Updated', function(Updated, App, Backbone, Marionette, $, _, Templates) {

  Updated.ItemView = Backbone.Marionette.ItemView.extend({
    tagName: 'span',
    template: Templates['app/js/modules/menus/templates/updated.tmpl']
  });

}, JST);
