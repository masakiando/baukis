class Customer::Authenticator
  def initialize(customer)
    @customer = customer
  end

  def authenticate(raw_password)
    @customer &&
      @customer.hashed_password &&
      BCrypt::Password.new(@customer.hashed_password) == raw_password
      #上記メソッドでraw_passwordをハッシュ関数化する。
      # それが@csutomerオブジェクトないのハッシュ関数パスと同じであれば真を返す。
  end
end
