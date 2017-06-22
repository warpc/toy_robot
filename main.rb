require_relative 'lib/toy_robot'
include ToyRobot

table = SquareTabletop.new(length: 5)
robot = Robot.new(table: table)

puts 'The toy robot simulator'
puts 'Available commands:'
puts <<-EOF
  PLACE X,Y,(NORTH | SOUTH | EAST | WEST)
  MOVE
  LEFT
  RIGHT
  REPORT
  EXIT
EOF

loop do
  begin
    puts 'input command (EXIT to quit): '
    input = gets.chomp
    command, *params = input.split(/\s/)
    if params.empty?
      case command
      when 'EXIT' then break
      when 'MOVE' then robot.move
      when 'LEFT' then robot.left
      when 'RIGHT' then robot.right
      when 'REPORT'
        report = robot.report
        puts report unless report.empty?
      end
    else
      case command
      when 'PLACE'
        x, y, direction, *other = params.join(' ').split(',')
        if other.empty?
          robot.place(x: Integer(x), y: Integer(y), direction: direction)
        end
      end
    end
  rescue
    next
  end
end
