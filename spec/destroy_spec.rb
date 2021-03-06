require 'spec_helper'

describe VagrantPlugins::VSphere::Action::Destroy do
  before :each do
    @env[:vSphere_connection] = @vim
  end

  it 'should set the machine id to nil' do
    @env[:machine].stub(:id).and_return(MISSING_UUID)

    call

    @env[:machine].should have_received(:id=).with(nil)
  end

  it 'should not create a Destroy task if VM is not found' do
    @env[:machine].stub(:id).and_return(MISSING_UUID)

    call

    @vm.should_not have_received :Destroy_Task
  end

  it 'should create a VM Destroy task if the VM exists' do
    @env[:machine].stub(:id).and_return(EXISTING_UUID)

    call

    @vm.should have_received :Destroy_Task
  end
end