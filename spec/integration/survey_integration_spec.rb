require 'spec_helper'


describe 'Survey App', js: true do
  let(:user){ F.create(:user) }
  let(:user_with_survey){ F.create(:user_with_survey) }

  def send_enter_key
    page.execute_script('e = jQuery.Event("keypress"); e.which = 13; $("body").trigger(e);')
  end

  def go_to_first_questions_page
    visit '/survey'
    while page.find('#pm-survey-options').text.blank?
      send_enter_key
    end
  end

  def fill_out_question
    unless page.find('#pm-survey-options').text.blank?
      number_of_options = page.all('#pm-survey-options input[type=radio]').size
      choose 'answers', option: rand(number_of_options).to_s
      send_enter_key
    end
  end

  def fill_out_completely
    go_to_first_questions_page
    while page.find('#pm-survey-progress', visible: false).visible?
      fill_out_question
    end
  rescue Capybara::Webkit::InvalidResponseError # TODO why?
  end

  describe 'auth' do
    it 'must be an authed user who starts the test' do
      visit '/survey'
      expect( page ).to have_content 'anmelden oder registrieren'
    end

    it 'will redirect /survey/result to /survey if it has not been done, yet' do
      login_as(user, scope: :user)
      visit '/survey/result'
      expect( current_path ).to eq "/survey"
    end
  end

  context '[signed in]' do
    use_before_unload_hack

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

      describe 'reload' do
        it 'will warn you if you try to navigate away' do
          visit '/survey'
          confirmText = accept_confirm do
            visit '/survey'
          end
          expect( confirmText ).to match /Anfang an|confirm|bestätigen/
        end

        it 'can be continued to fill out at the last question' do
          go_to_first_questions_page
          old_text = page.find('#pm-survey-text').text
          accept_confirm do
            visit '/survey'
          end
          new_text = page.find('#pm-survey-text').text

          expect( new_text ).to eq old_text
        end
      end

      describe 'back button' do
        before do
          go_to_first_questions_page
          fill_out_question
          fill_out_question
          fill_out_question
        end

        it 'goes back to previous question' do
          old_text = page.find('#pm-survey-text').text
          page.evaluate_script('window.history.back()')
          new_text = page.find('#pm-survey-text').text

          expect( new_text ).not_to eq old_text
        end

        it 'cannot go back to question before previous question' do
          page.evaluate_script('window.history.back()')
          old_text = page.find('#pm-survey-text').text
          page.evaluate_script('window.history.back()')
          new_text = page.find('#pm-survey-text').text

          expect( new_text ).to eq old_text
        end
      end
    end

    describe 'when finished' do
      it 'shows analysis page' do
        expect( page ).to have_no_content 'Herzlichen Dank'
        fill_out_completely
        expect( page ).to have_content 'Herzlichen Dank'
      end
    end
  end

  context '[already done]' do
    before do
      login_as(user_with_survey, scope: :user)
    end

    it 'will redirect to /survey/result' do
      visit '/survey'
      expect( current_path ).to eq "/survey/result"
    end

    describe 'results can be viewed later' do
      it 'shows analysis page' do
        visit '/survey'
        expect( page ).to have_content 'Herzlichen Dank'
      end
    end
  end
end