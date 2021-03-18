require 'spec_helper'
require 'robot'
require 'table'

RSpec.describe Table do
  let(:table) { Table.new }

  it 'should set defaults width and height' do
    expect(table.width).to eq(5)
    expect(table.height).to eq(5)
  end

  describe '.place_robot' do
    let(:direction) { 'NORTH' }
    let(:robot) { Robot.new(pos_x: pos_x, pos_y: pos_y, direction: direction) }
    subject { table.place_robot(pos_x: pos_x, pos_y: pos_y, direction: direction) }

    context 'when place position which is out of boundary' do
      let(:pos_x) { -1 }
      let(:pos_y) { 6 }

      it 'should raise error' do
        expect { subject }.to raise_error(Errors::PlaceOutBoundary)
      end
    end

    context 'when place position which is not out of boundary' do
      let(:pos_x) { 1 }
      let(:pos_y) { 2 }

      it 'should set up robot and return it' do
        expect(Robot).to receive(:new).with(pos_x: pos_x, pos_y: pos_y, direction: direction).and_return(robot)
        expect(subject).to eq(robot)
        expect(robot.table).to eq(table)
      end
    end
  end
end
