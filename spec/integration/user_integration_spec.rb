require 'spec_helper'


describe 'User' do
  def fill_out_common_user_fields
    fill_in 'user_firstname', with: 'test_firstname'
    fill_in 'user_lastname', with: 'test_lastname'
    select 'weiblich', :from => 'user_gender'
    fill_in 'user_birthday', with: '31.12.1990'
    fill_in 'user_password', with: '123456789'
    fill_in 'user_zipcode', with: '12345'
    fill_in 'user_city', with: 'NYC'
    fill_in 'user_password_confirmation', with: '123456789'
    click_on 'Weiter'
  end

  def user_sign_up
    visit '/users/sign_up'
    within '#new_user' do
      fill_in 'user_email', with: 'test@test.test'
      fill_out_common_user_fields
    end
  end

  describe 'sign up' do
    it "creates a new user" do
      expect{
        user_sign_up
      }.to change(User, :count).by(1)
    end

    it "should redirect to survey after sign_up" do
      user_sign_up
      current_path.should eq '/survey'
    end

    describe "invitations" do
      it "should be possible to signup as invited user" do
        user = User.invite!(email: 'test@example.com') do |u|
          u.skip_invitation = true
        end
        visit accept_user_invitation_url(:invitation_token => user.raw_invitation_token)
        within '#edit_user' do
          fill_out_common_user_fields
        end
        expect( current_path ).to eq '/survey'
      end

      it "should have an other DiscussionsUser name than Unbekannt" do
        discussion = F.create(:discussion)
        user = User.invite!(email: 'test@example.com') do |u|
          u.skip_invitation = true
        end
        discussion.users << user
        discussion.save
        visit accept_user_invitation_url(:invitation_token => user.raw_invitation_token)
        within '#edit_user' do
          fill_out_common_user_fields
        end
        discussions_user = user.discussions_users.first
        expect( discussions_user.name ).not_to eq "Unbekannt"
      end
    end


  end

  describe 'log in' do
    let!(:user){ F.create(:user_with_survey) }

    it 'shows the profile link' do
      visit '/users/sign_in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: '123456789'
      click_button "Anmelden"
      expect( page ).to have_link "Profil"
    end
  end

  context '[signed in]' do
    let!(:user){ F.create(:user_with_survey) }

    before do
      login_as(user, scope: :user)
    end

    it '/ redirects to profile page' do
      visit root_path
      expect( current_path ).to eq "/profile"
    end

    describe "user is proband" do
      describe "profile page" do
        it "should not have new discussion link" do
          expect( page ).not_to have_link "Neue Diskussion erstellen"
        end

        it "should not have new company link" do
          expect( page ).not_to have_link "Neuen Kunden anlegen"
        end

        describe "new Discussion" do
          before do
            @discussion = F.create(:discussion)
            @discussion.users << user
            visit "/profile"
          end

          it "should have confirm discussion link" do
            expect( page ).to have_link("Zusagen")
          end

          it "should have join discussion link after accept discussion" do
            click_link "Zusagen"
            expect( page ).to have_link( "Beitreten" )
          end

          it "should redirect to the discussion if link is clicked" do
            click_link "Zusagen"
            click_link "Beitreten"
            expect( current_path ).to eq discussion_path(@discussion)
          end
        end
      end
    end

    describe "user is moderator" do
      before do
        @moderator = F.create(:moderator)
        login_as(@moderator, scope: :user)
      end
      describe "profile page" do
        before do
          visit "/profile"
        end
        it "redirects to the new discussion page when link is clicked" do
          click_link 'Neue Diskussion erstellen'
          expect( current_path ).to eq new_discussion_path
        end

        it "redirects to the new company page when link was clicked" do
          click_link 'Neuen Kunden anlegen'
          expect( current_path ).to eq new_company_path
        end
        describe "Discussion" do
          before do
            @discussion = F.create(:discussion, moderator: @moderator)
            visit "/profile"
          end
          it "redirects to the edit discussion page when link was clicked" do
            click_link "Bearbeiten"
            expect( current_path ).to eq edit_discussion_path(@discussion)
          end
          it "should be possible to delete a discussion" do
            expect{
              click_link "Löschen"
            }.to change(Discussion, :count).by(-1)
          end

          it "should not nessary to accept a discussion" do
            expect( page ).to_not have_link("Zusagen")
          end
        end

        describe "Company" do
          before do
            @research_institute = F.create(:research_institute, deputy: @moderator)
            @company = F.create(:company, research_institute: @research_institute)
            @moderator.research_institutes << @research_institute
            @moderator.save
            visit "/profile"
          end
          it "redirects to the edit company page when link was clicked" do
            click_link "Bearbeiten"
            expect( current_path ).to eq edit_company_path(@company)
          end
          it "should be possible to delete a company" do
            expect{
              click_link "Löschen"
            }.to change(Company, :count).by(-1)
          end
        end
      end
    end
  end
end
