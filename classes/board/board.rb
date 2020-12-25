# frozen_string_literal: true

require_relative 'cell.rb'

class Board
  def initialize
    @size = 24
    @cols = 24
    @rows = 24
    @cells = []

    prepare
  end

  def prepare
    (0...@rows).each do |row|
      (0...@cols).each do |col|
        offset = 1
        @cells << Cell.new(col * (@size + offset), row * (@size + offset), @size, Gosu::Color::GRAY)
      end
    end
  end

  def draw
    @cells.each(&:draw)
  end

  def update
    @cells.each(&:update)
  end

  def evolve
    (0...@rows).each do |row|
      (0...@cols).each do |col|
        index = ((row * @cols) + col).ceil
        electron_count = electron_neighbours(col, row)
        @cells[index].evolve(electron_count)
      end
    end
  end

  def activate_electron(mouse_x, mouse_y)
    index = index_at(mouse_x, mouse_y)
    @cells[index].activate_electron
  end

  def deactivate_conductor(mouse_x, mouse_y)
    index = index_at(mouse_x, mouse_y)
    @cells[index].deactivate_conductor
  end

  def activate_conductor(mouse_x, mouse_y)
    index = index_at(mouse_x, mouse_y)
    @cells[index].activate_conductor if index < @cells.size
  end

  private

  def index_at(mouse_x, mouse_y)
    col = ((mouse_x - mouse_x / @cols) / @cols).truncate
    row = ((mouse_y - mouse_y / @rows) / @rows).truncate
    ((row * @cols) + col).ceil
  end

  def electron_neighbours(col, row)
    electron_count = 0
    electron_count += count_electron_at(col - 1, row) # w
    electron_count += count_electron_at(col + 1, row) # e
    electron_count += count_electron_n(col, row) # n
    electron_count += count_electron_s(col, row) # s
    electron_count
  end

  def count_electron_n(col, row)
    res = count_electron_at(col, row - 1) # n
    res += count_electron_at(col - 1, row - 1) # nw
    res + count_electron_at(col + 1, row - 1) # ne
  end

  def count_electron_s(col, row)
    res = count_electron_at(col, row + 1) # s
    res += count_electron_at(col - 1, row + 1) # sw
    res + count_electron_at(col + 1, row + 1) # se
  end

  def count_electron_at(col, row)
    if col >= 0 && col < @cols && row >= 0 && row < @rows
      @cells[(row * @cols) + col].electron? ? 1 : 0
    else 0
    end
  end
end
