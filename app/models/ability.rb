# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post

    if user.present?
      can :manage, Conversation do |c|
        c.sender_id == user.id || c.recipient_id == user.id
      end

      can :create, Message do |m|
        m.conversation.sender_id == user.id || m.conversation.recipient_id == user.id if m.conversation
      end

      can :create, Comment
      can :destroy, Comment, user_id: user.id

      can %i[create like], Post
      can %i[update destroy], Post, user_id: user.id

      if user.admin?
        can :manage, Invite
      end
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
