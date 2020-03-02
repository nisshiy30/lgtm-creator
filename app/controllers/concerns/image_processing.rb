require 'mini_magick'

module ImageProcessing
  extend ActiveSupport::Concern

  GRAVITY = 'center'.freeze
  TEXT_POSITION = '0,0'.freeze
  FONT = './app/assets/fonts/OpenSans-SemiboldItalic.ttf'.freeze
  FONT_SIZE = 72.freeze
  INDENTION_COUNT = 11.freeze
  FONT_COLOR = '#FFFFFF'.freeze
  STOROKE_COLOR = '#000000'.freeze
  STOROKE_WITDH = 1.freeze

  TXT_LGTM = 'LGTM'.freeze

  def build(image)
    @image = MiniMagick::Image.open(image)
    configuration(TXT_LGTM)
  end

  private

  def configuration(text)
    @image.combine_options do |config|
      config.font FONT
      config.fill FONT_COLOR
      config.gravity GRAVITY
      config.pointsize FONT_SIZE
      config.draw "text #{TEXT_POSITION} '#{text}'"
      config.stroke STOROKE_COLOR
      config.strokewidth STOROKE_WITDH
    end
  end
end