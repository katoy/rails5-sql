module MemosDoc
 # we need the DSL, right?
 extend Apipie::DSL::Concern

 api :GET, '/memos', 'List memos'
 def index
  # Nothing here, it's just a stub
 end

 api :GET, '/memos/:id', 'Show memos'
 param :id, Fixnum, :desc => "User ID", :required => true
 error 404, "Missing"
 error 500, "Server crashed for some <%= reason %>", :meta => {:anything => "you can think of"}
 meta :author => {:name => 'John', :surname => 'Doe'}

 def show
  # Nothing here, it's just a stub
 end

 api :POST, '/memos', 'Create memos'
 def create
  # Nothing here, it's just a stub
 end
end
