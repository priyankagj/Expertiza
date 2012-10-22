require File.dirname(__FILE__) + '/../test_helper'


class ParticipantTest < ActiveSupport::TestCase
	fixtures :participants
	fixtures :courses
	fixtures :assignments
  fixtures :sign_up_topics
  fixtures :users
	
	def test_add_participant()
		participant = Participant.new
    assert participant.valid?
		#TODO Should an empty Participant be allowed?
		# assert !participant.valid?
		#TODO Define required fields in test and add those validations to the model so test passes.
    user = users(:student1)
    participant.user= user
    participant.assignment= assignments(:assignment1)
		assert participant.valid?
    assert "student1", participant.name
    assert "student1_fullname", participant.fullname
    assert "assignment 1", participant.assignment.name
	end
	
	def test_add_course_participant()
		participant = CourseParticipant.new
    assert !participant.valid?
		#TODO read TODO tag in lines 11-13
		
		assert participant.valid?
	end
	
	def test_add_assignment_participant()
		participant = AssignmentParticipant.new
		assert !participant.valid?
		
		#TODO read TODO tag in line 13
		
		participant.handle = 'test_handle'
		assert participant.valid?
	end
	
	def test_delete_not_force
		participant = participants(:par1)
		participant.delete
		assert participant.valid?
  end

  def test_get_topic_string_when_topic_is_unset
    participant = Participant.new
    assert_not_nil participant
    #when topic is not set, check for default string
    assert_equal "<center>&#8212;</center>", participant.get_topic_string
  end

  def test_get_topic_string_for_valid_topic
    participant = Participant.new
    assert_not_nil participant
    #set the topic and then assert
    topic = sign_up_topics(:Topic5)
    participant.topic_id= topic.id
    assert_equal "Research Communication", participant.get_topic_string
  end

  def test_get_average
    participant = participants(:par1)
    assert_equal 5, participant.getAverage(25, 5)
  end

  def test_returns_zero_when_total_is_zero
    participant = participants(:par1)
    assert_equal 0, participant.getAverage(0, 0)
  end

  def test_update_topic_for_individual_assignment
    participant = participants(:par19)
    topic = sign_up_topics(:Topic5)
    participant.update_topic_id topic.id
    assert_equal "Research Communication", participant.get_topic_string
  end

  def test_update_topic_for_team_assignment
    participant1 = participants(:par17)
    participant2 = participants(:par18)
    assert_not_nil participant1
    assert_not_nil participant2
    assert_nil participant1.topic
    assert_nil participant2.topic
    topic = sign_up_topics(:Topic4)
    participant1.update_topic_id topic.id
    assert_not_nil participant1.topic
    assert_not_nil participant2.topic
    assert_equal "Research EPA", participant1.get_topic_string
    assert_equal "Research EPA", participant2.get_topic_string
  end

  def test_get_average_score

  end

  def test_get_average_score_per_question

  end

end
