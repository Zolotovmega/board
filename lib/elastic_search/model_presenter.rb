module ElasticSearch
  class ModelPresenter

    def initialize(model, mapping)
      @model = model
      @mapping = mapping
    end

    def id
      @model.id
    end

    def document_type
      @model.class.model_name.tableize.singularize
    end

    def to_indexed_json
      @mapping.transform(@model).to_indexed_json
    end

  end
end
