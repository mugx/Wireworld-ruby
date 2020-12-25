# frozen_string_literal: true

class Cell
  attr_reader :color

  def initialize(cell_x, cell_y, size, color)
    @cell_x = cell_x
    @cell_y = cell_y
    @size = size
    @color = color
  end

  def draw
    Gosu.draw_rect(@cell_x, @cell_y, @size, @size, @color)
  end

  def electron?
    @color == Gosu::Color::BLUE
  end

  def activate_electron
    if @color == Gosu::Color::GRAY
      change_color(Gosu::Color::YELLOW)
    elsif @color == Gosu::Color::YELLOW
      change_color(Gosu::Color::BLUE)
    end
  end

  def activate_conductor
    change_color(Gosu::Color::YELLOW) if @color == Gosu::Color::GRAY
  end

  def deactivate_conductor
    @next_color = Gosu::Color::GRAY
  end

  def evolve(electron_neighbours)
    if @color == Gosu::Color::BLUE
      @next_color = Gosu::Color::RED
    elsif @color == Gosu::Color::RED
      @next_color = Gosu::Color::YELLOW
    elsif @color == Gosu::Color::YELLOW && [1, 2].include?(electron_neighbours)
      @next_color = Gosu::Color::BLUE
    end
  end

  def update
    change_color(@next_color) unless @next_color.nil?
    @next_color = nil
  end

  private

  def change_color(value)
    @color = value
  end
end
