class Document < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  INTEGER      = 'integer'
  FLOAT        = 'float'
  STRING       = 'string'
  NOT_ANALYZED = 'not_analyzed'

  index_name 'threed'
  document_type 'threed'

  mappings do
    indexes :id, type: STRING, index: NOT_ANALYZED, store: true, include_in_all: false
    indexes :title, type: STRING, analyzer: 'snowball', include_in_all: true, boost: 5
    indexes :keywords, type: STRING, analyzer: 'snowball', include_in_all: true, boost: 5
    indexes :summary, type: STRING, analyzer: 'snowball', include_in_all: true, boost: 2
    indexes :body, type: STRING, analyzer: 'snowball', include_in_all: true, boost: 1
  end

  def as_indexed_json(options={})
    {}.tap do |doc|
      doc[:id]      = self.id.to_s
      doc[:title] = self.title
      doc[:keywords] = self.keywords
      doc[:summary] = self.summary
      doc[:body] = self.body
    end
  end
end
