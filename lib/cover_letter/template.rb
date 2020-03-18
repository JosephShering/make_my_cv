require 'mustache'

module CoverLetter
    class Template
        def initialize(data)
            template = File.open("./assets/template.html", "r").read
            @str = Mustache.render(template, data.to_hash)
        end
        
        def to_s
            return @str
        end
    end

end