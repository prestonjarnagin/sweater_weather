class Directory

  def self.welcome
    File.read('./app/views/welcome.txt')
  end

end
