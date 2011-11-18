module crawley

    class CustomHash

        def initialize hash
            @commands = hash
        end
        
        def get cmd_name
                    
            cmd = @commands[cmd_name]
            
            if cmd.nil?
                exit_with_error "Unrecognized command [" + cmd_name + "]" 
            end
            
            cmd
        end
    end

    def exit_with_error msg="Error Fatal"
        puts msg
        exit
    end
end
