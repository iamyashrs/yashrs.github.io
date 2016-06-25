module Jekyll
  class IconsTag < Liquid::Tag
    def initialize(tag_name, icons, tokens)
      super
      arguments = icons.split(",")
      @icons  = arguments[0].strip

      if arguments.size > 1
        @filetype = arguments[1].strip
      else
        @filetype = "png"
      end
    end

    def render(context)
      %|<img src="/assets/images/icons/#{@icons}.#{@filetype}" retina="/assets/images/icons/#{@icons}@2x.#{@filetype}">|
    end

    Liquid::Template.register_tag "icons", self
  end

  class MakesTag < Liquid::Tag
    def initialize(tag_name, makes, tokens)
      super
      arguments = makes.split(",")
      @path     = arguments[0].strip
      @makes  = arguments[1].strip

      if arguments.size > 2
        @filetype = arguments[2].strip
      else
        @filetype = "png"
      end
    end

    def render(context)
      %|<img src="/assets/images/makes/#{@path}/#{@makes}.#{@filetype}" retina="/assets/images/makes/#{@path}/#{@makes}@2x.#{@filetype}">|
    end

    Liquid::Template.register_tag "makes", self
  end

  class ProjectTag < Liquid::Tag
    def initialize(tag_name, project, tokens)
      super
      arguments = project.split(",")
      @path     = arguments[0].strip
      @project  = arguments[1].strip

      if arguments.size > 2
        @filetype = arguments[2].strip
      else
        @filetype = "png"
      end
    end

    def render(context)
      %|<img src="/assets/images/projects/#{@path}/#{@project}.#{@filetype}" retina="/assets/images/projects/#{@path}/#{@project}@2x.#{@filetype}">|
    end

    Liquid::Template.register_tag "project", self
  end
end