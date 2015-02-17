require 'spec_helper'


describe 'Survey App', js: true do
  let(:user){ create(:user) }
  let(:user_with_survey){ create(:user_with_survey) }

  def send_enter_key
    page.execute_script('e = jQuery.Event("keypress"); e.which = 13; $("body").trigger(e);')
  end

  def go_to_first_questions_page
    visit '/survey'
    while page.find('#pm-survey-options').text.blank?
      send_enter_key
    end
  end

  def fill_out_completely
    go_to_first_questions_page
    while page.find('#pm-survey-progress', visible: false).visible?
      unless page.find('#pm-survey-options').text.blank?
        number_of_options = page.all('#pm-survey-options input[type=radio]').size
        choose 'answers', option: rand(number_of_options).to_s
      end
      send_enter_key
    end
  rescue Capybara::Webkit::InvalidResponseError # TODO why?
  end

  describe 'auth' do
    it 'must be an authed user who starts the test' do
      visit '/survey'
      expect( page ).to have_content 'anmelden oder registrieren'
    end

    it 'is not allowed to start if it has been done before' do
      login_as(user_with_survey, scope: :user)
      visit '/survey'
      expect( page ).to have_content 'bereits durchgeführt'
    end
  end

  context '[signed in]' do
    before do
      login_as(user, scope: :user)
    end

    describe 'welcome page' do
      it 'shows welcome message on start' do
        visit '/survey'
        expect( page ).to have_content 'Registrierung'
      end

      it 'does not show the progress bar' do
        visit '/survey'
        element = page.find('#pm-survey-progress', visible: false)
        expect( element ).not_to be_visible
      end
    end


    describe 'filling out' do
      it 'shows the progress bar' do
        go_to_first_questions_page
        element = page.find('#pm-survey-progress', visible: false)
        expect( element ).to be_visible
      end

      it 'goes to the next page when answer selected and submit button is pressed' do
        go_to_first_questions_page
        old_text = page.find('#pm-survey-text').text
        choose 'answers', option: '0'
        send_enter_key
        new_text = page.find('#pm-survey-text').text

        expect( new_text ).not_to eq old_text
      end

      it 'shows error and stays on the same page when no anwser is selected' do
        go_to_first_questions_page
        old_text = page.find('#pm-survey-text').text
        send_enter_key
        new_text = page.find('#pm-survey-text').text

        expect( new_text ).to eq old_text
        expect( page.find('#pm-survey-error', visible: false) ).to be_visible
        expect( page.find('#pm-survey-error') ).to have_content 'Bitte wählen Sie'
      end

      it 'changes the progress when you go the next page' do
        go_to_first_questions_page
        old_progress = page.find('#pm-survey-progress').value
        choose 'answers', option: '0'
        send_enter_key
        new_progress = page.find('#pm-survey-progress').value

        expect( new_progress ).not_to eq old_progress
      end

      context '[reload]' do
        before do
          if Capybara.javascript_driver == :webkit
            page.driver.browser.accept_js_confirms
          end
        end

        # it 'will warn you if you try to navigate away' do
        #   pending 'js confirm'
        # end

        it 'can be continued to fill out at the last question' do
          go_to_first_questions_page
          old_text = page.find('#pm-survey-text').text
          visit '/survey'
          new_text = page.find('#pm-survey-text').text

          expect( new_text ).to eq old_text
        end
      end
    end

    describe 'when finished' do
      it 'shows analysis page' do
        expect( page ).not_to have_content 'Herzlichen Dank'
        fill_out_completely
        expect( page ).to have_content 'Herzlichen Dank'
      end
    end

  end
end