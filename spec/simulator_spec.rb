require 'simulator'

RSpec.describe Simulator, integration: true do
  let(:simulator) { Simulator.new }

  context 'invalid command' do
    it 'command not found' do
      expect { simulator.run('TEST') }.to raise_error(Errors::InvalidAction)
    end

    it 'no any robot place' do
      expect { simulator.run('MOVE') }.to raise_error(Errors::RobotNotPlace)
    end

    it 'wrong place command' do
      expect { simulator.run('PLACE 1,2') }.to raise_error(Errors::WrongNumberArgs)
    end

    it 'wrong action command after PLACE action' do
      simulator.run('PLACE 1,2,NORTH')
      expect { simulator.run('MOVE TEST') }.to raise_error(Errors::WrongNumberArgs)
    end
  end

  context 'valid command' do
    subject { simulator.run('REPORT') }

    it 'place move command' do
      simulator.run('PLACE 0,0,NORTH')
      simulator.run('MOVE')
      expect(subject).to  eq('Output: 0,1,NORTH')
    end

    it 'place left command' do
      simulator.run('PLACE 0,0,NORTH')
      simulator.run('LEFT')
      expect(subject).to eq('Output: 0,0,WEST')
    end

    it 'place move move left move command' do
      simulator.run('PLACE 1,2,EAST')
      simulator.run('MOVE')
      simulator.run('MOVE')
      simulator.run('LEFT')
      simulator.run('MOVE')
      expect(subject).to eq('Output: 3,3,NORTH')
    end

    it 'place move move right move command' do
      simulator.run('PLACE 1,2,EAST')
      simulator.run('MOVE')
      simulator.run('MOVE')
      simulator.run('RIGHT')
      simulator.run('MOVE')
      expect(subject).to eq('Output: 3,1,SOUTH')
    end
  end
end
