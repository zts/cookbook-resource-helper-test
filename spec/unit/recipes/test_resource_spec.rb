#
# Cookbook Name:: resource-helper-test
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'resource-helper-test::test_resource' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(:step_into => ['my_test_resource'])
    runner.converge(described_recipe)
  end

  context 'by default' do
    it 'does not log the first message' do
      expect(chef_run).not_to write_log "something must be done"
    end
    it 'does log the second message' do
      expect(chef_run).to write_log "nothing will be done"
    end
  end

  context 'when the helper method is stubbed' do
    before do
      allow_any_instance_of(Chef::Resource::ResourceHelperTestMyTestResource)
        .to receive(:do_something?).and_return(true)
    end

    it 'does log the first message' do
      expect(chef_run).to write_log "something must be done"
    end
    it 'does not log the second message' do
      expect(chef_run).not_to write_log "nothing will be done"
    end
  end
end
