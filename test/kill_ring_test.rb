require 'helper'

class Reline::KillRing::Test < Reline::TestCase
  def setup
    @prompt = '> '
    @kill_ring = Reline::KillRing.new
  end

  def test_append_one
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('a')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    assert_equal('a', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal('a', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['a', 'a'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['a', 'a'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
  end

  def test_append_two
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('a')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('b')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    assert_equal('b', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal('b', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['a', 'b'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['b', 'a'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
  end

  def test_append_three
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('a')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('b')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('c')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    assert_equal('c', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal('c', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['b', 'c'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['a', 'b'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['c', 'a'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
  end

  def test_append_after
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('a')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('b')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    assert_equal('ab', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal('ab', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['ab', 'ab'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['ab', 'ab'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
  end

  def test_append_before
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('a')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('b', true)
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    assert_equal('ba', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal('ba', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['ba', 'ba'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['ba', 'ba'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
  end

  def test_append_chain_two
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('a')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('b')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::FRESH, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('c')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.append('d')
    assert_equal(Reline::KillRing::State::CONTINUED, @kill_ring.instance_variable_get(:@state))
    @kill_ring.process
    assert_equal(Reline::KillRing::State::PROCESSED, @kill_ring.instance_variable_get(:@state))
    assert_equal('cd', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal('cd', @kill_ring.yank)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['ab', 'cd'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
    assert_equal(['cd', 'ab'], @kill_ring.yank_pop)
    assert_equal(Reline::KillRing::State::YANK, @kill_ring.instance_variable_get(:@state))
  end
end
