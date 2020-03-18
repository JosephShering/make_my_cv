require 'toml'


module CoverLetter
    class Data

        def initialize(uri)
            @hash = {}
            get_personal_info

            toml_str = File.open("./assets/data/jobs/#{uri}.toml", "r").read
            data = TOML::Parser.new(toml_str).parsed
            @hash.update(data)
            @hash["date"] = Time.now.strftime("%m/%d/%Y")
        end

        def to_hash
            @hash
        end

        def self.blank
            TOML::Generator.new({
                :company => "",
                :source => "",
                :title => "",
                :experience => "",
                :points => [""]
            }).body
        end


        private

        def get_personal_info
            uri = "./assets/data/info.toml"

            unless File.exists?(uri)
                raise Thor::Error, "#{uri} not found in project, run cv init to init project"
            end
            toml_str = File.open(uri, "r").read
            data = TOML::Parser.new(toml_str).parsed


            @hash.update(data)
        end
    end
end