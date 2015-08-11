require 'active_record'
require 'mysql2'


ActiveRecord::Base.establish_connection(:adapter => "mysql2",
  :host     => "127.0.0.1", 
  :username => "root",
  :password => "JasonSi",
  :database => "msgboard")  

class Message < ActiveRecord::Base
end


class MsgManager 

  def add(msg, user_id)
    raise '留言不可以少于十个字' if msg.strip.length <10
    temp = Message.new
    temp.msg = msg.strip  
    temp.user_id = user_id
    temp.save
  end

  def delete(id)
    del = Message.find_by(id: id)
    return 0 if del == nil
    del.destroy
  end

  def edit(id, msg)
    edt = Message.find_by(id: id)
    raise '留言不可以少于十个字' if msg.strip.length <10
    edt.msg = msg.strip
    edt.save    
  end

  def query_by_id(id)
    qid = Message.find_by(id: id) 
  end

  def query_by_author(author)
    qau = Message.where("author = ?",author)
  end

  def query_by_user(username)
    temp = User.find_by(username: username)
    if temp ==nil
      qus = []
    else
      qus = Message.where("user_id = ?",temp.id)
    end
  end  
end