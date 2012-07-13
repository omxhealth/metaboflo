class Patient < TestSubject

  def to_label
    self.code
  end
end

