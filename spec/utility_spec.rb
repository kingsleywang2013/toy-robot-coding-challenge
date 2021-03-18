require 'utility'
require 'simulator'

class DummyTestClass
  include Utility
end

describe Utility do
  let(:dummy) { DummyTestClass.new }

  describe '.extract_action_args_from_command' do
    subject { dummy.extract_action_args_from_command(command) }

    context 'when command contains only one word' do
      let(:command) { 'PLACE' }

      it 'should return only action' do
        expect(subject).to eq(['PLACE'])
      end
    end

    context 'when command contains multiple words that seperate by space' do
      let(:command) { 'PLACE 1,2,NORTH' }

      it 'should return action and args' do
        expect(subject).to eq(['PLACE', '1,2,NORTH'])
      end
    end
  end

  describe '.validate_action_args' do
    subject { dummy.validate_action_args(action, args) }
    let(:args) { '1,2,NORTH' }

    context 'when action is invalid' do
      let(:action) { 'TEST' }

      it 'should raise error' do
        expect { subject }.to raise_error(Errors::InvalidAction)
      end
    end

    context "when action is 'PLACE'" do
      let(:action) { 'PLACE' }

      it 'should call validate_place_action_args' do
        expect(dummy).to receive(:validate_place_action_args).with(args)

        subject
      end
    end

    context "when action is other valid action which is not 'PLACE'" do
      let(:action) { 'MOVE' }

      it 'should call validate_robot_actions_args' do
        expect(dummy).to receive(:validate_robot_actions_args).with(action, args)

        subject
      end
    end
  end

  describe '.validate_robot_position' do
    let(:table) { Table.new }
    subject { dummy.validate_robot_position(pos_x: -1, pos_y: 1, table: table, robot: robot) }

    context 'when validate for place' do
      let(:robot) { nil }

      it 'should raise PlaceOutBoundary' do
        expect { subject }.to raise_error(Errors::PlaceOutBoundary)
      end
    end

    context 'when validate for move' do
      let(:robot) { instance_double("Robot") }

      it 'should raise MoveOutBoundary' do
        expect { subject }.to raise_error(Errors::MoveOutBoundary)
      end
    end
  end

  describe '.is_integer?' do
    subject { dummy.send(:is_integer?, n) }

    context 'when arg is a string of integer' do
      let(:n) { '2' }

      it { is_expected.to eq(true) }
    end

    context 'when arg is not a string of integer' do
      let(:n) { 'a' }

      it { is_expected.to eq(false) }
    end
  end

  describe '.validate_place_args' do
    subject { dummy.send(:validate_place_args, args) }

    context 'when args is nil' do
      let(:args) { nil }

      it 'should raise error' do
        expect { subject }.to raise_error(Errors::WrongNumberArgs)
      end
    end

    context 'when args format is incorrect' do
      let(:args) { '1,1,' }

      it 'should raise error' do
        expect { subject }.to raise_error(Errors::WrongNumberArgs)
      end
    end
  end

  describe '.validate_place_positions' do
    subject { dummy.send(:validate_place_positions, x, y) }

    context 'when either x or y is not integer' do
      let(:x) { '1' }
      let(:y) { 'a' }

      it 'should raise error' do
        expect { subject }.to raise_error(Errors::WrongPostionType)
      end
    end

    context 'when both x and y is not integer' do
      let(:x) { 'a' }
      let(:y) { 'b' }

      it 'should raise error' do
        expect { subject }.to raise_error(Errors::WrongPostionType)
      end
    end
  end

  describe '.validate_place_direction' do
    subject { dummy.send(:validate_place_direction, direction) }

    context 'when direction is incorrect' do
      let(:direction) { 'NORRTH' }

      it 'should raise error' do
        expect { subject }.to raise_error(Errors::InvalidDirection)
      end
    end
  end
end
