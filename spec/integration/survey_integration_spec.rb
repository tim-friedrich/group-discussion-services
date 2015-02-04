require 'spec_helper'
require 'integration/integration_helpers'


describe 'Survey App' do
  describe 'auth' do
    it 'must be an authed user who starts the test' do
      pending
    end

    it 'is not allowed to start if it has been done before' do
      pending
    end
  end

  describe 'welcome page' do
    it 'does not show the progress bar'
  end


  describe 'filling out' do
    it 'shows the progress bar' do
      pending
    end

    it 'goes to the next page when answer selected and submit button is pressed' do
      pending
    end

    it 'shows error and stays on the same page when no anwser is selected' do
      pending
    end

    it 'changes the progress when you go the next page' do
      pending
    end

    context '[reload]' do
      it 'can be continued to fill out at the last question' do
        pending
      end
    end
  end

  describe 'when finished' do
    it 'submits results to server' do
      pending
    end

    it 'shows analysis page' do
      pending
    end

    # ...
  end
end