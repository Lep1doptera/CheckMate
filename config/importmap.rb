# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "embla-carousel" # @8.6.0
pin "chart.js/auto", to: "https://ga.jspm.io/npm:chart.js@4.5.0/auto/auto.js"
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4

