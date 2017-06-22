require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/robot'
include ToyRobot

describe Robot do
  before do
    @table = MiniTest::Mock.new
    @robot = Robot.new(table: @table)
  end

  describe '#place' do
    it 'should setup place for table' do
      @table.expect :placing!, [1, 2], [1, 2]
      @robot.place(x: 1, y: 2, direction: 'NORTH')
      @table.verify
    end

    it 'should setup direction for robot' do
      @table.expect :placing!, [1, 2], [1, 2]
      @robot.place(x: 1, y: 2, direction: 'NORTH')
      assert_equal(@robot.direction, 'NORTH')
    end

    it 'should not setup place if direction is wrong' do
      @robot.place(x: 1, y: 2, direction: 'NORTHWEST')
      assert_nil(@robot.direction)
    end

    it 'should not setup direction if place is wrong' do
      @table.expect :placing!, nil, [1, 2]
      @robot.place(x: 1, y: 2, direction: 'NORTH')
      assert_nil(@robot.direction)
    end
  end

  describe '#move' do
    it 'should placing relatively using direction' do
      @table.expect :placing!, [1, 2], [1, 2]
      @robot.place(x: 1, y: 2, direction: 'NORTH')
      @table.expect :placing_relatively!, [1, 3], Robot::DIRECTIONS['NORTH']
      @robot.move

      @table.verify
    end
  end

  describe '#report' do
    it 'should return coordinates and directions' do
      @table.expect :placing!, [1, 2], [1, 2]
      @robot.place(x: 1, y: 2, direction: 'NORTH')

      @table.expect :placed?, true
      # FIXME: Workaround for to_s method which not worked from box
      # @table.expect :to_s, "1,2"
      def @table.to_s; '1,2'; end
      assert_equal(@robot.report, '1,2,NORTH')
      @table.verify
    end

    it 'should return nothing if robot has not been placed' do
      @table.expect :placed?, false
      assert_equal(@robot.report, '')
      @table.verify
    end
  end

  describe '#left' do
    it 'should turn to left if robot has been placed' do
      @table.expect :placing!, [1, 2], [1, 2]
      @robot.place(x: 1, y: 2, direction: 'NORTH')
      @table.expect :placed?, true
      assert_equal(@robot.left, 'WEST')
      assert_equal(@robot.direction, 'WEST')

      @table.expect :placed?, true
      assert_equal(@robot.left, 'SOUTH')
      assert_equal(@robot.direction, 'SOUTH')
    end

    it 'should not turn if robot has not been placed' do
      @table.expect :placed?, false
      assert_nil(@robot.left)
    end
  end

  describe '#right' do
    it 'should turn to right if robot has been placed' do
      @table.expect :placing!, [1, 2], [1, 2]
      @robot.place(x: 1, y: 2, direction: 'WEST')
      @table.expect :placed?, true
      assert_equal(@robot.right, 'NORTH')
      assert_equal(@robot.direction, 'NORTH')

      @table.expect :placed?, true
      assert_equal(@robot.right, 'EAST')
      assert_equal(@robot.direction, 'EAST')
    end

    it 'should not turn if robot has not been placed' do
      @table.expect :placed?, false
      assert_nil(@robot.right)
    end
  end
end
