require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe TasksController, type: :controller do
  render_views

  let!(:task1) { create(:task) }
  let!(:task2) { create(:task) }

  describe 'GET /tasks' do
    it "renders all tasks in JSON" do
      get :index

      expected_response = {
        tasks: [
          {
            id: task1.id,
            content: task1.content,
            completed: task1.completed,
            created_at: task1.created_at,
            updated_at: task1.updated_at 
          },
          {
            id: task2.id,
            content: task2.content,
            completed: task2.completed,
            created_at: task2.created_at,
            updated_at: task2.updated_at 
          }
        ]
      }

      expect(response.body).to eq(expected_response.to_json)
    end
  end

  describe 'POST /tasks' do
    it 'renders newly created task in JSON' do
      post :create, params: { task: { content: 'New Task' } }, format: :json

      expected_response = {
        task: {
          id: Task.last.id,
          content: 'New Task',
          completed: false,
          created_at: Task.last.created_at,
          updated_at: Task.last.updated_at
        }
      }

      expect(response.body).to eq(expected_response.to_json)
    end
  end

  describe 'DELETE /tasks/:id' do
    it "renders success status" do
      task = create(:task)

      delete :destroy, params: { id: task.id }

      expect(Task.count).to eq(0)
      expect(response.body).to eq({ success: true, status: 'Success' }.to_json)
    end
  end

  describe 'PUT /tasks/:id/mark_complete' do
    it "renders modified task" do
      task = create(:task)

      put :mark_complete, params: { id: task.id }, format: :json

      expect(Task.where(completed: true).count).to eq(1)

      task.reload
      expected_response = {
        task: {
          id: task.id,
          content: task.content,
          completed: true,
          created_at: task.created_at,
          updated_at: task.updated_at
        }
      }

      expect(response.body).to eq(expected_response.to_json)
    end
  end

  describe 'PUT /tasks/:id/mark_active' do
    it "renders modified task" do
      task = create(:task, completed: true)

      put :mark_active, params: { id: task.id }, format: :json

      expect(Task.where(completed: false).count).to eq(1)

      task.reload
      expected_response = {
        task: {
          id: task.id,
          content: task.content,
          completed: false,
          created_at: task.created_at,
          updated_at: task.updated_at
        }
      }

      expect(response.body).to eq(expected_response.to_json)
    end
  end
end
