module Sub::ItemsDoc
 # we need the DSL, right?
 extend Apipie::DSL::Concern

 api :GET, '/sub/items', 'List items'
 def some_operation
  # Nothing here, it's just a stub
 end

end
