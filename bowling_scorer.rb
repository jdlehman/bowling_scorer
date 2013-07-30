def checkargs
  #check number of args
  if ARGV.count != 1
    puts "Bowling Scorer must be run with 1 argument"
    exit 1
  end

  #check formatting of arg
  unless ARGV[0].match /((X|\d\d|\d\/)-){9}(\d\d|(\d\/-(X|\d)|X-(\d\d|\d\/|X\d|XX)))/
    puts "Must be 10 valid frames. Eg: 44-44-X-5/-X-30-90-4/-36-X5/"
    exit 1
  end
end

def score(game)
  score = 0
  countNext = []
  prev = 0
  gameArray = game.split('-')
  gameArray.each_with_index do |frame, num|
    frame.each_char do |pins|
      case pins
        when 'X'
          score += 10
          unless countNext.empty?
            countNext.map! { |x| score += 10; x - 1 }.select! { |x| x > 0}
          end
          countNext << 2 unless num > 8
        when '/'
          score += (10 - prev)
          unless countNext.empty?
            countNext.map! { |x| score += (10 - prev); x - 1 }.select! { |x| x > 0}
          end
          countNext << 1 unless num > 8
        else
          score += pins.to_i
          prev = pins.to_i
          unless countNext.empty?
            countNext.map! { |x| score += pins.to_i; x - 1 }.select! { |x| x > 0}
          end
      end
    end
  end
  puts score
end

#check arguments
checkargs
#run game
score ARGV[0]
