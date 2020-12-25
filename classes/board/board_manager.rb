# frozen_string_literal: true

require_relative 'board.rb'

class BoardManager
  def initialize
    @board = Board.new
    @generation = 0
    @can_evolve = true

    tick
  end

  def draw
    @board.draw
  end

  def activate_electron(mouse_x, mouse_y)
    @board.activate_electron(mouse_x, mouse_y)
    @can_evolve = true
  end

  def activate_conductor(mouse_x, mouse_y)
    @board.activate_conductor(mouse_x, mouse_y)
    @can_evolve = true
  end

  def deactivate_conductor(mouse_x, mouse_y)
    @board.deactivate_conductor(mouse_x, mouse_y)
  end

  private

  def tick
    every(0.3) do
      @generation += 1
      @board.evolve
      @board.update
    end
  end

  def every(seconds)
    Thread.new do
      last_tick = Time.now
      loop do
        sleep 0.1
        if Time.now - last_tick >= seconds
          last_tick += seconds
          yield
        end
      end
    end
  end
end
