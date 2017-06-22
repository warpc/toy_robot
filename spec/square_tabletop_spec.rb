require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/square_tabletop'
include ToyRobot

describe SquareTabletop do
  before { @tabletop = SquareTabletop.new(length: 5) }

  describe '#current_position' do
    it 'is undefined after initialization' do
      assert_nil(@tabletop.current_position)
    end

    it 'is defined after placing' do
      @tabletop.placing!(0, 1)
      assert_equal(@tabletop.current_position, {x: 0, y: 1})
    end
  end

  describe '#placed?' do
    it 'is not placed after initialization' do
      refute(@tabletop.placed?)
    end

    it 'is placed after placing' do
      @tabletop.placing!(0, 0)
      assert(@tabletop.placed?)
    end
  end

  describe '#placing!' do
    it 'setup initial current position' do
      @tabletop.placing!(0, 2)
      assert_equal(@tabletop.current_position, {x: 0, y: 2})
    end

    it 'setup new current position' do
      @tabletop.placing!(0, 2)
      assert_equal(@tabletop.current_position, {x: 0, y: 2})
      @tabletop.placing!(4, 0)
      assert_equal(@tabletop.current_position, {x: 4, y: 0})
    end

    it 'do not setup incorrect position' do
      @tabletop.placing!(5, 5)
      assert_nil(@tabletop.current_position)
    end

    it 'do not erase previous position in case of fail' do
      @tabletop.placing!(0, 2)
      @tabletop.placing!(5, 5)
      assert_equal(@tabletop.current_position, {x: 0, y: 2})
    end
  end

  describe '#placing_relatively!' do
    it 'do not setup initial current position' do
      @tabletop.placing_relatively!(0, 2)
      assert_nil(@tabletop.current_position)
    end

    it 'setup new current position after placing' do
      @tabletop.placing!(0, 2)
      assert_equal(@tabletop.current_position, {x: 0, y: 2})
      @tabletop.placing_relatively!(1, 1)
      assert_equal(@tabletop.current_position, {x: 1, y: 3})
    end

    it 'do not change position to incorrect' do
      @tabletop.placing!(4, 3)
      assert_equal(@tabletop.current_position, {x: 4, y: 3})
      @tabletop.placing_relatively!(1, 1)
      assert_equal(@tabletop.current_position, {x: 4, y: 3})
    end
  end

  describe '#to_s' do
    it 'show current position' do
      @tabletop.placing!(4, 3)
      assert_equal(@tabletop.to_s, '4,3')
    end

    it 'should not show position if object not placed' do
      assert_equal(@tabletop.to_s, '')
    end
  end
end
