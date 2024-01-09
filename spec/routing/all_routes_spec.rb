require 'rails_helper'

RSpec.describe 'Route definition', type: :routing do
  it 'of POST /tasks' do
    expect(post: '/tasks').to route_to(controller: 'tasks', action: 'create')
  end

  it 'of GET /tasks' do
    expect(get: '/tasks').to route_to(controller: 'tasks', action: 'index')
  end

  it 'of DELETE /tasks/:id' do
    expect(delete: '/tasks/:id').to route_to(controller: 'tasks', action: 'destroy', id: ':id')
  end

  it 'of PUT /tasks/:id/mark_complete' do
    expect(put: '/tasks/:id/mark_complete').to route_to(controller: 'tasks', action: 'mark_complete', id: ':id')
  end

  it 'of PUT /tasks/:id/mark_active' do
    expect(put: '/tasks/:id/mark_active').to route_to(controller: 'tasks', action: 'mark_active', id: ':id')
  end
end
