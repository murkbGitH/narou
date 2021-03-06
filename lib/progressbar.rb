# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

class ProgressBar
  class OverRangeError < StandardError; end
  
  def initialize(max, interval = 1, width = 50, char = "*")
    @max = max == 0 ? 1.0 : max.to_f
    @interval = interval
    @width = width
    @char = char
    @counter = 0
  end

  def output(num)
    return if silence?
    if num > @max
      raise OverRangeError, "`#{num}` over `#{@max}(max)`"
    end
    @counter += 1
    return unless @counter % @interval == 0
    ratio = calc_ratio(num)
    now = (@width * ratio).round
    rest = @width - now
    STDOUT.print "[" + @char * now + ' ' * rest + "] #{(ratio * 100).round}%\r"
  end

  def clear
    return if silence?
    STDOUT.print " " * 79 + "\r"
  end

  def calc_ratio(num)
    num / @max
  end

  def silence?
    $debug || ENV["NAROU_ENV"] == "test"
  end
end
