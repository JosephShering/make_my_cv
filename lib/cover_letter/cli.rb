require 'thor'
require 'toml'
require 'cover_letter/data'
require 'cover_letter/template'

module CoverLetter
    class CLI < Thor
        package_name "Cover Letter Generator"
        desc 'render [DATA_FILE]', 'Render new cover letter to the console'
        method_option :save, :aliases => "-f", :desc => 'Save output to file'
        def render(data_file)
            data = CoverLetter::Data.new(data_file)
            template = CoverLetter::Template.new(data)
            if options.save?
                File.open("./assets/cover_letters/#{data_file}.txt", "w") do |file|
                    file.write(template.to_s)
                end
            else
                puts template.to_s
            end
        end

        desc 'gen [DATA_FILE]', 'Generates a new blank job toml file for you to edit'
        def gen(data_file)
            uri = "./assets/data/jobs/#{data_file}.toml"
            if File.exist?(uri)
                return
            end

            file = File.open(uri, "w")
            file.write(CoverLetter::Data.blank)
        end

        desc 'init', 'Creates a personal information TOML file for you to fill in'
        def init()
            File.open("./assets/data/info.toml", "w") do |file|
                toml_str = TOML::Generator.new({
                    :name => "",
                    :email => "",
                    :number => "",
                    :city => "Denver, CO"
                }).body
                file.write(toml_str)
            end
        end


        def self.exit_on_failure?
            true
        end
    end
end