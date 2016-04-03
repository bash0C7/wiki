Wiki::App.controllers :pages do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :show do
    @file = params[:q]

    repo = Rugged::Repository.new('/Users/bash/Documents/wiki')
    oid = Rugged::Blob.from_workdir repo, @file
    markdown = Rugged::Object.lookup(repo, oid).content
    markdown.force_encoding("utf-8")

    processor = Qiita::Markdown::Processor.new
    @result = processor.call(markdown)
    render :show
  end

end
