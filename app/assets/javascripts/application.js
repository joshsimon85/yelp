// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
// require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap

$(function() {
  const App = {
    viewFullText: function(e) {
      e.preventDefault();

      const $a = $(e.target);
      const $truncText = $a.parent();
      const $fullText = $truncText.next('.full-text');

      $truncText.hide();
      $fullText.show();
    },

    viewTruncText: function(e) {
      e.preventDefault();

      const $a = $(e.target);
      const $fullText = $a.parent();
      const $truncText = $fullText.prev('.truncated');

      $fullText.hide();
      $truncText.show();
    },
    bindEvents: function() {
      $('[data-toggle="tooltip"]').tooltip();
      $('.businesses, .business').on('click', 'a.full-text-link', this.viewFullText.bind(this));
      $('.businesses, .business').on('click', 'a.show-less-link', this.viewTruncText.bind(this));
    },
    init: function() {
      this.bindEvents();
      return this;
    }
  };

  const app = Object.create(App).init();
});
