# Suj Commentable Plugin

This plugin allows any mongoid class to become commentable, a comment or an
author. These three classes then implement a complete commenting engine for
your Rails application.

## Usage

### Run the gem generator

rails generator suj:commentable:install

This command will generate some views and a controller in your application. You
can use these files to customize the behaviour and look of the gem.

### Configure the controller

In the controller you need to override the commentable_user method to return
the currently logged in user. This user is used by the controller to create and
rate comments.


```ruby
def commentable_user
  current_user
end
```

### Configuring your models

You need to include the commentable module to the class you want to comment on
(e.g. Book):

```ruby
class Book
  include Mongoid::Document
  include Suj::Commentable
  acts_as_commentable :order => :desc, :max_depth = 10
end

This module adds a has_many association with an internal
Suj::Commentable::Comments class. The order parameter can be to show the
comments ordered in ascending or descending order and the max_depth can be used
to limit replies depth to certain value. If max_depth is set to -1 then
unlimited reply depth is allowed.

Next you must add the Commentable::Author module to one of your clases (e.g.
User or Author):

```ruby
class User
  include Mongoid::Document
  include Suj::Commentable
  acts_as_commentable_author :name_field => "name", :avatar_field => "avatar"
end
```

Suj::Commentable::Comments and will be used to assign ratings to each comment.
The name_field is used by the views to obtain the author name and the
avatar_field is used to obtain the avatar (image) url of the author. Both of
these fields if available will be rendered on each comment.

### Testing the models

After configuring the models you should be able to add comments to the Book
class via the comments association:

```bash
@book = Book.first
@book.comments
@book.comments.create(:text => "New Comment", :author => User.first)
```

Comments are threaded so they can have parents and childrens:

@book.comments.create(:text => "Threaded Comment", :author => User.first,
:parent => Comment.first)

@comment.children

### Configuring the routes

In your routes.rb config file add this command:

```ruby
commentable_for :books
```

This will create routes needed to create/destroy/like/dislike comments. Use
rake routes to check the generated routes.

### Display comments in your view

This plugin includes some partials and a helper used to render the comments.
Also a default stylesheet is provided. To display the comments in you own views
simply use the comments_for helper method:

```ruby
<%= comments_for(@book) %>
```

This will render a list with the current comments and a form to add new
comments.
