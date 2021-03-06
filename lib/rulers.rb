require "rulers/version"
require "rulers/array"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content_type' => 'text/html'}, []]
      end  

      if env["PATH_INFO"] == '/'
        klass, act = get_home(env)
        controller = klass.new(env)
        text = controller.send(act)
        return [200, {'Content_type' => 'text/html'}, [text]] 
      end
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, {'Content-Type' => 'text/html'}, [text]]
    end  
  end  

  class Controller
    def initialize(env)
      @env = env
    end
    
    def env
      @env
    end  
  end 
end    

