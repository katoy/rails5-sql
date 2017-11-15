module TagsDoc
 # we need the DSL, right?
 extend Apipie::DSL::Concern

 api :GET, '/tags', 'List tags'
 def index
  # Nothing here, it's just a stub
 end

 api :GET, '/tags/:id', 'Show tag'
 def show
  # Nothing here, it's just a stub
 end

 api :POST, '/tags', 'Create tag'
 def create
  # Nothing here, it's just a stub
 end
end
