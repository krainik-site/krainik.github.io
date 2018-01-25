# -*- coding: utf-8 -*-

require 'rubygems'
require 'bundler/setup'
require 'psych'
require 'erb'

MainLocale = :ua
Suffix = "demo_"
TemplateName = 'index.erb'
LocalizationFile = 'index.yaml'

data = Psych.safe_load(IO.read(LocalizationFile), symbolize_names: true)
content = IO.read(TemplateName)
[MainLocale, :us].each do |locale|
  IO.write("#{Suffix}index_#{locale}.html", ERB.new(content).result_with_hash(c: data[locale]))
end

FileUtils.mv "#{Suffix}index_#{MainLocale}.html", "#{Suffix}index.html"
