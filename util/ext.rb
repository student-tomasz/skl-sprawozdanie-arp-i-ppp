class String
  def ext(new_ext)
      self.chomp(File.extname(self)) + ".#{new_ext}"
  end
end
