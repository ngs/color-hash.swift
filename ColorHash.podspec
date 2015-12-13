Pod::Spec.new do |s|
  s.name             = "ColorHash"
  s.version          = "0.1.0"
  s.summary          = "Color Generator Based on Swift String"
  s.description      = <<-DESC
      This is a Swift port of [Color Hash](https://github.com/zenozeng/color-hash).

      Generates UIColor and NSColor from given string.

      ```
      let str = "こんにちは、世界"
      let saturation = 0.30
      let lightness = 0.70

      ColorHash(str, [CGFloat(saturation)], [CGFloat(lightness)]).color
      ```
                        DESC
  s.homepage         = "https://github.com/ngs/color-hash.swift"
  s.license          = 'MIT'
  s.author           = { "Atsushi Nagase" => "a@ngs.io" }
  s.source           = { :git => "https://github.com/ngs/color-hash.swift.git", :tag => s.version.to_s }

  s.requires_arc          = true

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files          = 'ColorHash/*.swift'
end
