require 'spec_helper'

describe ProfitCalculator do
  before :each do
    Actor.any_instance.stub(:get_data_for).and_return({})
  end

  describe '.profit' do
    subject { ProfitCalculator.profit(healer, patient, spell) }

    let(:healer) { Actor.new healer_params }
    let(:patient) { Actor.new patient_params }
    let(:healer_params) do
      {
          base: { magicka: 400 },
          current: { magicka: healer_current_magicka },
      }
    end
    let(:patient_params) do
      {
          base: { health: 300 },
          current: { health: patient_current_health },
      }
    end

    let(:spell) { {:cost=>cost, :power=>power, :period=>period, :target=>1, :school=>"restoration"} }

    context 'healer has 50% magicka and patient has 50% health' do
      let(:patient_current_health) { 15 }
      let(:healer_current_magicka) { 60 }
      let(:power) { 50 }
      let(:period) { 0 }
      let(:cost) { 40 }
      let(:expected_percentage) { -0.15000000000000002 }

      it { should eq expected_percentage }
    end

    context 'healer has 30% magicka and patient has 20% health' do
      let(:patient_current_health) { 250 }
      let(:healer_current_magicka) { 300 }
      let(:power) { 500 }
      let(:period) { 0 }
      let(:cost) { 300 }
      let(:expected_percentage) { 0}

      it { should eq expected_percentage }
    end
  end

  describe '.stat_percentage_gain' do
    subject { ProfitCalculator.send(:stat_percentage_gain, :health, actor, spell) }

    let(:actor) { Actor.new actor_params }
    let(:actor_params) do
      {
          base: { health: 300 },
          current: { health: 230 },
      }
    end
    let(:spell) { {:cost=>9.015999999999998, :power=>power, :period=>0, :target=>0, :school=>"restoration"} }

    context 'small increase, does not reach max health' do
      let(:power) { 8 }
      let(:expected_percentage) { 0.026666666666666616 }

      it { should eq expected_percentage }
    end

    context 'large increase, does not reach max health' do
      let(:power) { 60 }
      let(:expected_percentage) { 0.19999999999999996 }

      it { should eq expected_percentage }
    end

    context 'very large increase, reaches past max health' do
      let(:expected_percentage) { 0.23333333333333328 }

      context 'just hits max health' do
        let(:power) { 70 }

        it { should eq expected_percentage }
      end

      context 'reaches past max health' do
        let(:power) { 500 }

        it { should eq expected_percentage }
      end
    end
  end
end