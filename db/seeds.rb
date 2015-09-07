# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Board.create(grade: 3,
             description: "색동_저고리");
Board.create(grade: 3,
             description: "배냇_저고리");
Board.create(grade: 3,
             description: "반짇_고리");
Board.create(grade: 3,
             description: "연결_고리");


# Post.create(user_id: 1,
#             board_id: 3,
#             context: "첫번째 게시물",
#             color: 0,
#             like_count: 0);
            
# Post.create(user_id: 1,
#             board_id: 2,
#             context: "두번째 게시물",
#             color: 0,
#             like_count: 0);
            
# Post.create(user_id: 1,
#             board_id: 1,
#             context: "세번째 게시물",
#             color: 0,
#             like_count: 0);
            
# Post.create(user_id: 1,
#             board_id: 1,
#             context: "네번째 게시물",
#             color: 0,
#             like_count: 0);
            