# Suj Commentable Plugin

This plugin allows any mongoid class to become commentable, a comment or an
author. These three classes then implement a complete commenting engine for
your Rails application.

## Usage

### Configuring your models

You must first create a Comment class for your application. It does not
necesarily needs to be called Comment but for this example we will use this
class:

```bash
rails g model Comment
```

Once the model is created you must include the commentable plugin comment
module in it:

```ruby
class Comment
  include Mongoid::Document
  include Suj::Commentable::Comment
end
```

Next include the commentable module to the class you want to comment on:

```ruby
class Book
  include Mongoid::Document
  include Suj::Commentable
end

this module will add a has_many relationship with the Comment class.

If you want each comment to have an author then include the author module in
the class that is to be used as author. Usually, if you use devise, this class
is User or Admin:

```ruby
class User
  include Mongoid::Document
  include Suj::Commentable::Author
end
```
First you must select three classes in your application to become a commentable
class, a comment class and an author class. For example if you have a Book
management application you usually have a Book class, a User class and a
Comment class.

### Testing the models

After configuring the models you should be able to add comments to the Book
class via the comments association:

```bash
@book = Book.first
@book.comments
@book.comments.create(:text => "New Comment")
@book.comments.create(:text => "Other comment", :author => User.first)
```

### Configuring the routes

The comments class is only valid under the commentable scope. To this end the
comments route must be nested inside the commentable (e.g. Book) class. In your
config/routes.rb file the comments route should look like:

```ruby
resources :books do
  resources :comments
end
```

Adapt the names (:books and :comments) to the classes you use in your
application. If your commentable class is Video and your comments class is
Comentario then change the routes accordingly.

### Configuring the views

This plugin includes some partials and a helper used to render the comments.
Also a default stylesheet is provided. To display the comments in you own views
simply use the comments_for helper method:

```ruby
<%= comments_for(@book, @user) %>
```

This will render a list with the current comments and a form to add new
comments. The @book object should be the commentable and the @user the author
object for new comments.

### Customizing the view

If you want to change the default view you can use the following generator:

```bash
rails g suj:commentable:views
```

This generator will create a stylesheet and a views folder with some partials in your application
that can be used to override the default view.

