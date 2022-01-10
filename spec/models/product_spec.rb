require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
  it 'should save successfully with all four fields set' do
    @product = Product.new 
    @category = Category.new
    @category.name = 'Test'
    @product.name = 'test'
    @product.price_cents = 12345
    @product.quantity = 5
    @product.category = @category
    expect(@product.valid?).to be true
  end

  it 'should validate if name is present in product' do
    @product = Product.new
    @product.name = nil
    @product.valid? 
    expect(@product.errors[:name]).to include("can't be blank")

    @product.name = 'test'
    @product.valid?
    expect(@product.errors[:name]).not_to include("can't be blank")
  end

  it 'should validate if price_cents present in product' do
    @product = Product.new
    @product.price_cents = nil
    @product.valid?
    expect(@product.errors[:price_cents]).to include("is not a number")

    @product.price_cents = 12345
    @product.valid?
    expect(@product.errors[:price_cents]).not_to include("can't be blank")
  end

  it "should validate if quantity is present in product" do
    @product = Product.new
    @product.quantity = nil 
    @product.valid?
    expect(@product.errors[:quantity]).to  include("can't be blank")

    @product.quantity = 5
    @product.valid? 
    expect(@product.errors[:quantity]).not_to  include("can't be blank")
  end

  it "should validate if category id is present in product" do
    @category = Category.new
    @product = Product.new
    @product.category = nil 
    @product.valid?
    expect(@product.errors[:category]).to  include("can't be blank")

    @product.category = @category 
    @product.valid? 
    expect(@product.errors[:category]).not_to  include("can't be blank")
  end
  end 
end
