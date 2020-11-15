# frozen_string_literal: true

class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name 

  extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # soft delete
  # def destroy
  # update(:deleted_at, Time.current)
  # end


end
