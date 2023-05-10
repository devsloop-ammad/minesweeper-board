# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  describe 'GET #index' do
    it "gets the latest 10 boards when 'all' parameter is not present" do
      latest_boards = create_list(:board, 10, created_at: Time.current)
      get :index
      expect(assigns(:boards)).to match_array(latest_boards)
    end

    it "gets all boards when 'all' parameter is present" do
      all_boards = create_list(:board, 20, created_at: Time.current)
      get :index, params: { all: true }
      expect(assigns(:boards)).to match_array(all_boards)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:board) }

      it 'creates a new board' do
        expect do
          post :create, params: { board: valid_attributes }
        end.to change(Board, :count).by(1)
      end

      it 'assigns a newly created board as @board' do
        post :create, params: { board: valid_attributes }
        expect(assigns(:board)).to be_a(Board)
        expect(assigns(:board)).to be_persisted
      end

      it 'redirects to the created board' do
        post :create, params: { board: valid_attributes }
        expect(response).to redirect_to(board_path(Board.last.id))
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:board, name: nil) }

      it 'assigns a newly created but unsaved board as @board' do
        post :create, params: { board: invalid_attributes }
        expect(assigns(:board)).to be_a_new(Board)
      end

      it "re-renders the 'new' template" do
        post :create, params: { board: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #show' do
    it 'gets the requested board' do
      board = create(:board)
      get :show, params: { id: board.id }
      expect(assigns(:board)).to eq(board)
    end
  end
end
