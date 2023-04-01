// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import Tagify from 'tagify';
window.Tagify = Tagify
import notifier from './notifier/index'
window.notifier = notifier
