require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #new' do
    it 'レスポンスコードが200であること' do
      get new_user_url
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq 302
      end

      it 'ユーザーが登録されること' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it 'マイページにリダイレクトすること' do
        post users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to mypage_path
      end
    end

    context 'パラメータが不正な場合' do
      it '新規登録ページにリダイレクトすること' do
        post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response).to redirect_to new_user_path
      end

      it 'ユーザーが登録されないこと' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end

      it 'エラーのフラッシュメッセージが表示されること' do
        post users_url, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(flash[:error_messages]).to be_present
      end
    end
  end
end
