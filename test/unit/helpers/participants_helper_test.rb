require 'test_helper'

class ParticipantHelperTest < ActiveSupport::TestCase
  fixtures :participants
  fixtures :courses
  fixtures :assignments
  fixtures :users

  #test to check if the user is made a course participant
  def test_make_user_course_participant
    course_part = ParticipantsHelper.make_user_course_participant(courses(:course1), users(:student3))
    assert_equal "CourseParticipant", course_part.type
  end

  #test to check if the user is made a assignment participant
  def test_make_user_assignment_participant
    assign_part = ParticipantsHelper.make_user_assignment_participant(assignments(:assignment_project2), users(:student4))
    assert_equal "AssignmentParticipant", assign_part.type
  end
end