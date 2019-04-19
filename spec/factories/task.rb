FactoryBot.define do
  factory :task do
    name { 'test_task_01'}
    detail { 'testtesttest' }
  end

  factory :second_task, class: Task do
    name { 'test_task_03'}
    detail { 'samplesample' }
  end
end
