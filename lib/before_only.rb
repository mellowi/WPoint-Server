# From: http://blog.alastairdawson.com/2010/07/27/a-sinatra-before-only-filter/
module Sinatra
  module BeforeOnlyFilter
    def before_only(routes, &block)
      before do
        routes.map!{|x| x = x.gsub(/\*/, '\w+')}
        routes_regex = routes.map{|x| x = x.gsub(/\//, '\/')}
        instance_eval(&block) if routes_regex.any? {|route| (request.path =~ /^#{route}$/) != nil}
      end
    end
  end
  register BeforeOnlyFilter
end
