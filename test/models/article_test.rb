require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should validate presence and length of title" do
    article = Article.new(description: "Test description")
    assert_not article.valid?, "Article is valid without title"
    assert_equal ["can't be blank", "is too short (minimum is 6 characters)"], article.errors[:title], "Incorrect validation error messages for title presence and length"

    article.title = "short"
    assert_not article.valid?, "Article is valid with a short title"
    assert_equal ["is too short (minimum is 6 characters)"], article.errors[:title], "Incorrect validation error message for title length"

    article.title = "a" * 101
    assert_not article.valid?, "Article is valid with a long title"
    assert_equal ["is too long (maximum is 100 characters)"], article.errors[:title], "Incorrect validation error message for title length"
  end

  test "should validate presence and length of description" do
    article = Article.new(title: "Test title")
    assert_not article.valid?, "Article is valid without description"
    assert_equal ["can't be blank", "is too short (minimum is 10 characters)"], article.errors[:description], "Incorrect validation error messages for description presence and length"

    article.description = "short"
    assert_not article.valid?, "Article is valid with a short description"
    assert_equal ["is too short (minimum is 10 characters)"], article.errors[:description], "Incorrect validation error message for description length"

    article.description = "a" * 301
    assert_not article.valid?, "Article is valid with a long description"
    assert_equal ["is too long (maximum is 300 characters)"], article.errors[:description], "Incorrect validation error message for description length"
  end

  test "should have associations with user, article_categories, and categories" do
    article = Article.new(title: "Test title", description: "Test description")
    assert_respond_to article, :user
    assert_respond_to article, :article_categories
    assert_respond_to article, :categories
  end
end
