# frozen_string_literal: true

require_relative './board/board_manager.rb'

class GameWindow < Gosu::Window
  def initialize
    super 576, 576
    self.caption = 'Wireworld'
    @board_manager = BoardManager.new
    @mouse_button_pressed = false
  end

  def needs_cursor?
    true
  end

  def draw
    @board_manager.draw
  end

  def update
    @board_manager.activate_conductor(mouse_x, mouse_y) if @mouse_button_pressed
  end

  def button_down(id)
    @mouse_button_pressed = id == Gosu::MsLeft
    @board_manager.activate_electron(mouse_x, mouse_y) if id == Gosu::MsLeft
    @board_manager.deactivate_conductor(mouse_x, mouse_y) if id == Gosu::MsRight
  end

  def button_up(_id)
    @mouse_button_pressed = false
  end
end
