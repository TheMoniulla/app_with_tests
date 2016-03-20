require 'rails_helper'

describe User::ExpensesController do
  render_views

  let(:user) { create(:user) }

  context 'user not logged in' do
    describe '#index' do
      let(:call_request) { get :index }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#new' do
      let(:call_request) { get :new }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#show' do
      let(:expense) { create(:expense) }
      let(:call_request) { get :show, id: expense.id }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#edit' do
      let(:call_request) { get :edit, id: expense.id }
      let(:expense) { create(:expense) }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#create' do
      let(:expense) { create(:expense) }
      let(:call_request) { post :create, expense: attributes }
      let(:attributes) { attributes_for(:expense, name: 'name', user: user) }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#update' do
      let!(:expense) { create(:expense, name: 'name', user: user) }
      let(:call_request) { put :update, expense: attributes, id: expense.id }
      let(:attributes) { {name: 'test'} }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end

    describe '#destroy' do
      let(:call_request) { delete :destroy, id: expense.id }
      let!(:expense) { create(:expense) }

      it "doesn't allow to access action" do
        call_request
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  context 'user logged in' do
    before { sign_in(user) }

    describe '#index' do
      let(:call_request) { get :index }
      let!(:expense) { create(:expense, user: user) }

      context 'after request' do
        before { call_request }
        it { is_expected.to render_template 'index' }
        it { expect(controller.expenses).to eq [expense] }
      end
    end

    describe '#new' do
      let(:call_request) { get :new }

      context 'after request' do
        before { call_request }

        it { is_expected.to render_template 'new' }
        it { expect(controller.expense.persisted?).to be false }
      end
    end

    describe '#show' do
      let(:call_request) { get :show, id: expense.id }

      context 'expense for logged in user' do
        let!(:expense) { create(:expense, user: user) }

        context 'after request' do
          before { call_request }

          it { is_expected.to render_template 'show' }
          it { expect(controller.expense).to eq expense }
        end
      end

      context 'expense not for logged in user' do
        let(:expense) { create(:expense) }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to user_expenses_path }
        end
      end
    end

    describe '#edit' do
      let(:call_request) { get :edit, id: expense.id }

      context 'expense for logged in user' do
        let(:expense) { create(:expense, user: user) }

        context 'after request' do
          before { call_request }

          it { is_expected.to render_template 'edit' }
          it { expect(controller.expense).to eq expense }
        end
      end

      context 'expense not for logged in user' do
        let(:expense) { create(:expense) }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to user_expenses_path }
        end
      end
    end

    describe '#create' do
      let(:call_request) { post :create, expense: attributes }

      context 'a request has valid params' do
        let(:attributes) do
          attributes_for(:expense, name: 'name', user: user)
        end

        it { expect { call_request }.to change { Expense.count }.by(1) }

        context 'after request' do
          before { call_request }
          let(:expense) { Expense.last }

          it { is_expected.to redirect_to user_expenses_path }
          it { expect(expense.name).to eq 'name' }
          it { expect(expense.description).to eq 'description' }
        end
      end

      context 'a request has invalid params' do
        let(:attributes) { attributes_for(:expense, name: nil) }
        it { expect { call_request }.not_to change { Expense.count } }

        context 'after request' do
          before { call_request }
          it { is_expected.to render_template 'new' }
        end
      end
    end

    describe '#update' do
      let!(:expense) { create(:expense, name: 'name', user: user, photo: nil) }
      let(:call_request) { put :update, expense: attributes, id: expense.id }

      context 'a request has valid params' do
        let(:attributes) { {name: 'test'} }

        it { expect { call_request }.to change { expense.reload.name }.from('name').to('test') }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to user_expenses_path }
        end

        context 'when there is a photo' do
          let(:file) do
            extend ActionDispatch::TestProcess
            fixture_file_upload('images/apple.png', 'image/png')
          end
          let(:attributes) { {photo: file} }

          it { expect { call_request }.to change { expense.reload.photo_file_name }.from(nil).to('apple.png') }
        end
      end

      context 'a request has invalid params' do
        let(:attributes) { {name: nil} }

        it { expect { call_request }.not_to change { expense.reload.name } }

        context 'after request' do
          before { call_request }

          it { is_expected.to render_template 'edit' }
        end
      end
    end

    describe '#destroy' do
      let(:call_request) { delete :destroy, id: expense.id, user: user }

      context 'expense for logged in user' do
        let!(:expense) { create(:expense, user: user) }

        it { expect { call_request }.to change { Expense.count }.by(-1) }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to user_expenses_path }
        end
      end

      context 'expense not for logged in user' do
        let!(:expense) { create(:expense) }

        it { expect { call_request }.not_to change { Expense.count } }

        context 'after request' do
          before { call_request }

          it { is_expected.to redirect_to user_expenses_path }
        end
      end
    end

    describe 'expose expenses_categories' do
      it { expect(controller.expenses_categories).to eq ExpensesCategory.all }
    end

    describe '#import' do
      let(:expenses_import) { ExpensesImport.new }
      before do
        create(:currency, name: 'PLN')
        create(:shop, name: 'Rik')
        create(:expenses_category, name: 'Toys')
      end

      context 'file is correct' do
        let(:file) do
          extend ActionDispatch::TestProcess
          fixture_file_upload('files/expenses.ods', 'application/vnd.oasis.opendocument.spreadsheet')
        end


        before do
          allow(file).to receive(:original_filename).and_return('expenses.ods')
          allow(file).to receive(:path).and_return([Rails.root, 'spec/fixtures/files/expenses.ods'].join('/'))
        end

        let(:call_request) { post :import, expenses_import: {file: file} }

        it 'creates expenses' do
          expect { call_request }.to change { Expense.count }.by 2
        end

        it 'redirects to user_expenses_path' do
          call_request
          expect(response).to redirect_to(user_expenses_path)
        end
      end

      context 'file is incorrect' do
        let(:file) do
          extend ActionDispatch::TestProcess
          fixture_file_upload('files/expenses_wrong.ods', 'application/vnd.oasis.opendocument.spreadsheet')
        end

        before do
          allow(file).to receive(:original_filename).and_return('expenses_wrong.ods')
          allow(file).to receive(:path).and_return([Rails.root, 'spec/fixtures/files/expenses_wrong.ods'].join('/'))
        end

        let(:call_request) { post :import, expenses_import: {file: file} }

        it 'does not creates expenses' do
          expect { call_request }.not_to change { Expense.count }
        end

        it 'redirects to user_expenses_path' do
          call_request
          expect(response).to redirect_to(user_expenses_path)
        end

        it 'displays error massage' do
          call_request
          expect(flash[:alert]).to eq "Validation failed: Price value can't be blank"
        end
      end

      context 'when file is missing' do
        before { post :import, expenses_import: {file: nil} }

        it 'redirects to user_expenses_path' do
          expect(response).to redirect_to(user_expenses_path)
        end

        it 'displays error massage' do
          expect(flash[:alert]).to eq 'You have to upload file.'
        end
      end
    end
  end
end
