require 'spec_helper'
require 'robot'
require 'table'

RSpec.describe Robot do
  let(:robot) { Robot.new(pos_x: 1, pos_y: 2, direction: 'NORTH') }
  let(:table) { Table.new }

  before do
    robot.table = table
  end

  describe '.move' do
    subject { robot.move }

    context 'when robot will not move out of boundary' do
      let(:robot) { Robot.new(pos_x: 1, pos_y: 2, direction: direction) }

      context 'when direction is NORTH' do
        let(:direction) { 'NORTH' }

        it 'will increase position y' do
          expect { subject }.to change { robot.pos_y }.from(2).to(3)
        end
      end

      context 'when direction is SOUTH' do
        let(:direction) { 'SOUTH' }

        it 'will decrease position y' do
          expect { subject }.to change { robot.pos_y }.from(2).to(1)
        end
      end

      context 'when direction is EAST' do
        let(:direction) { 'EAST' }

        it 'will increase position x' do
          expect { subject }.to change { robot.pos_x }.from(1).to(2)
        end
      end

      context 'when direction is WEST' do
        let(:direction) { 'WEST' }

        it 'will decrease position x' do
          expect { subject }.to change { robot.pos_x }.from(1).to(0)
        end
      end
    end

    context 'when robot will move out of boundary' do
      let(:robot) { Robot.new(pos_x: 0, pos_y: 1, direction: 'WEST') }

      it 'will raise error' do
        expect { subject }.to raise_error(Errors::MoveOutBoundary)
      end
    end
  end

  describe '.turn_left' do
    subject { robot.turn_left }

    it 'should turn left of current direction' do
      expect { subject }.to change { robot.direction }.from('NORTH').to('WEST')
    end
  end

  describe '.turn_right' do
    subject { robot.turn_right }

    it 'should turn right of current direction' do
      expect { subject }.to change { robot.direction }.from('NORTH').to('EAST')
    end
  end

  describe '.display_report' do
    subject { robot.display_report }

    it 'should display current robot position and direction' do
      expect(subject).to eq("Output: #{robot.pos_x },#{robot.pos_y},#{robot.direction}")
    end
  end
end
