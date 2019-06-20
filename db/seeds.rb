5.times do
  WorkOrder.create({
    title: Faker::Job.field,
    description: Faker::Lorem.sentence,
    deadline: Faker::Date.forward(30)
  })
end

10.times do
  Worker.create({
    name: Faker::Name.name,
    company_name: Faker::Company.name,
    email: Faker::Internet.email
  })
end

20.times do
  Assignment.create({
    work_order_id: rand(1..5),
    worker_id: rand(1..10)
  })
end