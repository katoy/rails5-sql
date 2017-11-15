module Sub::TypesDoc
 # we need the DSL, right?
 extend Apipie::DSL::Concern

 api :GET, '/sub/types/some_operation', 'List types'
 def some_operation
  # Nothing here, it's just a stub
 end
end
