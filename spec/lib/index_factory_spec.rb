# encoding: UTF-8

require 'spec_helper'

describe ElasticSearch::Factories::IndexFactory do
  describe 'items' do
    it 'Создаёт индекс, если его нет' do
      tire_index_mock = mock('TireIndex')
      tire_index_mock.should_receive(:create).and_return(true)
      items_index = ElasticSearch::Factories::IndexFactory.items(tire_index_mock)
    end
  end
end
