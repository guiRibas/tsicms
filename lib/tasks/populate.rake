namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [CategoryRecommendation,
     Recommendation,
     Activity,
     Professor,
     ProfessorCategory,
     ProfessorTitle,
     Academic,
     Discipline,
     Period,
     Matrix].each(&:delete_all)

    categories = %w[Documentário Filme Livro Seriado]
    categories.each do |category|
      CategoryRecommendation.create!(name: category)
    end

    CategoryRecommendation.all.each do |category|
      5.times do
        category.recommendations.create! title: Faker::Name.name,
          description: Faker::Lorem.paragraph(2),
          image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample)
      end
    end

    categories = %w[Efetivo Temporário]
    categories.each do |category|
      ProfessorCategory.create!(name: category)
    end

    titles = [
      {name: 'Especialista', abbrev: 'Esp.'},
      {name: 'Mestre', abbrev: 'Me.'},
      {name: 'Doutor', abbrev: 'Dr.'}
    ]

    titles.each do |title|
      ProfessorTitle.create!(name: title[:name], abbrev: title[:abbrev])
    end

    10.times do
      Professor.create!(name: Faker::Name.name, lattes: Faker::Internet.url,
                        image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample),
                        occupation_area: Faker::Job.title, email: Faker::Internet.email,
                        gender: Professor.genders.values.sample,
                        professor_title: ProfessorTitle.all.sample,
                        professor_category: ProfessorCategory.all.sample)
    end

    6.times do
      Academic.create!(
        name: Faker::Name.unique.name,
        image: File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample),
        contact: Faker::Internet.url,
        graduated: [true, false].sample
      )
    end

    10.times do
      Activity.create!(
        name: Faker::Job.unique.title,
        description: Faker::Lorem.paragraph(2)
      )
    end

    10.times do
      start_date = Faker::Date.between(1.year.ago, 5.months.ago)
      end_date = Faker::Date.between(5.months.ago, Date.today)
      end_date = [nil, end_date].sample

      ActivityProfessor.create!(
        professor: Professor.all.sample,
        activity: Activity.all.sample,
        start_date: start_date,
        end_date: end_date
      )
    end

    3.times do |m_index|
      matrix = Matrix.create!(name: Faker::DragonBall.character)
      10.times do |p_index|
        period = Period.create!(
          name: "#{Faker::Company.suffix}-#{m_index}#{p_index}",
          matrix: matrix
        )

        10.times do |d_index|
          Discipline.create!(
            name: "#{Faker::Company.industry}-#{m_index}#{p_index}-#{d_index}",
            code: Faker::Code.nric(27, 34),
            hours: Faker::Number.number(2),
            period: period,
            menu: Faker::Markdown.random
          )
        end
      end
    end
  end
end
