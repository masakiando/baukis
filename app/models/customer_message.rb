class CustomerMessage < Message
  # このクラスないのレコードで範囲、第一引数：加工されていないのも。第二引数：statusがnewでdeletedフラグがfalseの値をwhereする
  scope :unprocessed, -> { where(status: 'new', deleted: false) }
end
