# frozen_string_literal: true

require 'spec_helper'

describe 'updater' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts.merge(servermonitor: 'root@localhost') }

      it { is_expected.to compile }
    end
  end
end
