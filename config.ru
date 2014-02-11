require 'rubygems'
require 'sinatra'
require './app'

Sass::Script::Number.precision = 8

run Sinatra::Application
