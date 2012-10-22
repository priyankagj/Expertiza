module ParticipantsHelper

  def self.make_user_a_participant(attrs, home_page, params, user)
    if (params[:course_id] != nil)
      participant = make_user_course_participant(params, user)
    elsif (params[:assignment_id] != nil)
      participant = make_user_assignment_participant(params, user)
    end
    set_participant_attributes(attrs, home_page, participant)
  end

  def self.set_participant_attributes(attrs, home_page, participant)
    if participant != nil
      participant.email(attrs["clear_password"], home_page)
    end
  end

  def self.make_user_assignment_participant(params, user)
    if (AssignmentParticipant.find(:all,{:conditions => ['user_id=? AND parent_id=?', user.id, params[:assignment_id]]}).size == 0)
      return AssignmentParticipant.create(:parent_id => params[:assignment_id], :user_id => user.id)
    end
  end

  def self.make_user_course_participant(params, user)
    if (CourseParticipant.find(:all, {:conditions => ['user_id=? AND parent_id=?', user.id, params[:course_id]]}).size == 0)
      CourseParticipant.create(:user_id => user.id, :parent_id => params[:course_id])
    end
  end
end