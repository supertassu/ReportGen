# http://tassu.me
require 'colorize'
require 'redcarpet'
require 'yaml'
require 'open-uri'
require 'ReportGen/version'

# ReportGen generates beautiful websites using Report HTML
# theme (http://tassu.me/report-theme) and Markdown.
module ReportGen
  if ARGV.size.zero?
    puts 'Usage: reportgen <file>'.colorize(:red)
    exit 0
  end

  filename = ARGV[0]
  unless File.exist?(filename)
    puts 'File not found'.colorize(:red)
    exit 0
  end

  unless File.exist?('report.yml')
    puts 'Config not found'.colorize(:red)
    exit 0
  end

  config = YAML.load_file('report.yml')

  markdown = ''
  file = File.open(filename, 'r')
  while (line = file.gets)
    markdown += line
  end
  file.close

  markdownparser = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)

  template = open('http://tassu.me/report-theme/template.html').read

  template.sub! '{ TITLE }', config['title']
  template.sub! '{ TEXT1 }', config['first']['name']
  template.sub! '{ DESC1 }', config['first']['desc']
  template.sub! '{ TEXT2 }', config['second']['name']
  template.sub! '{ DESC2 }', config['second']['desc']
  template.sub! '{ TEXT3 }', config['third']['name']
  template.sub! '{ DESC3 }', config['third']['desc']
  template.sub! '{ TEXT4 }', config['fourth']['name']
  template.sub! '{ DESC4 }', config['fourth']['desc']
  template.sub! '{ CONTENTS }', markdownparser.render(markdown)

  begin
    file = File.open(filename + '.html', 'w')
    file.write(template)
  rescue IOError => e
    puts "Couldn't save the file.".colorize(:red)
    raise e
  ensure
    file.close unless file.nil?
  end

end
