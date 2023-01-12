# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers', preload: true
pin 'bootstrap', to: 'https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js', preload: true
pin '@popperjs/core', to: 'https://unpkg.com/@popperjs/core@2.11.2/dist/esm/index.js', preload: true # use unpkg.com as ga.jspm.io contains a broken popper package
pin 'jquery', to: 'jquery.min.js', preload: true
pin 'jquery_ujs', to: 'jquery_ujs.js', preload: true
pin 'jquery-validation', to: 'https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js', preload: true

