#
# Cookbook Name:: resource-helper-test
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'resource-helper-test::test_resource' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(:step_into => ['my_test_resource', 'my_test_resource2'])
    runner.converge(described_recipe)
  end

  context 'by default' do
    it 'does not log the first message' do
      expect(chef_run).not_to write_log "something must be done"
    end
    it 'does log the second message' do
      expect(chef_run).to write_log "nothing will be done"
    end
    it 'does not log the third message' do
      expect(chef_run).not_to write_log "something else must be done"
    end
    it 'does log the fourth message' do
      expect(chef_run).to write_log "nothing else will be done"
    end
  end

  context 'when the helper method is stubbed' do
    before do
      # Filename "my_test_resource.rb"
      # resource_name :my_test_resource
      allow_any_instance_of(Chef::Resource::ResourceHelperTestMyTestResource)
        .to receive(:do_something?).and_return(true)

      # Filename "another_test_resource.rb"
      # resource_name :my_test_resource2
      allow_any_instance_of(Chef::Resource::ResourceHelperTestAnotherTestResource)
        .to receive(:do_something?).and_return(true)
    end

    it 'does log the first message' do
      expect(chef_run).to write_log "something must be done"
    end
    it 'does not log the second message' do
      expect(chef_run).not_to write_log "nothing will be done"
    end
    it 'does log the third message' do
      expect(chef_run).to write_log "something else must be done"
    end
    it 'does not log the fourth message' do
      expect(chef_run).not_to write_log "nothing else will be done"
    end
  end
end
