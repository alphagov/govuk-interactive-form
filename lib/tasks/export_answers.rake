require 'csv'

desc "Exports all selected answer models to csv"
task "export_collection", [:collection] => :environment do |_, args|
  records = SelectedAnswer.where(collection: args[:collection])
  puts "Exporting #{records.count} answers to csv"
  column_names = SelectedAnswer.column_names.reject { |column_name| column_name == "id" }
  filename = "#{args[:collection]}_export.csv"
  CSV.open(filename, "wb") do |csv|
    csv << column_names
    records.each do |result|
      csv << result.attributes.values_at(*column_names)
    end
  end
  puts "Finished! Written to '#{filename}'"
end

desc "Exports decisions for a collection to csv"
task "export_decisions", [:collection] => :environment do |_, args|
  puts "Exporting decisions to csv"
  filename = "#{args[:collection]}_decisions_export.csv"
  answer_names = SelectedAnswer.where(collection: args[:collection]).pluck(:answer).to_a.uniq.sort
  CSV.open(filename, "wb") do |csv|
    csv << [ "Item id", "Most popular answer", "Unanimous?" ] + answer_names.map { |name| "#{name} count" } + answer_names.map { |name| "#{name} explanations" }

    SelectedAnswer.where(collection: args[:collection]).group_by{ |answer| answer.item_id + answer.question }.each do |item_id, answers|
      answer_counts = Hash.new(0)
      answer_explanations = Hash.new { |h,k|  h[k] = Array.new }
      answers.each do |answer|
        answer_counts[answer.answer] += 1
        if answer.explanation.present?
          answer_explanations[answer.answer] << answer.explanation
        end
      end
      answer_counts.sort_by { |_key, value| value }.to_h
      most_popular_answer = answer_counts.keys.first

      is_unanimous = answer_counts.values.reject { |num| num.zero? }.one?
      is_unanimous_text = is_unanimous ? "Yes" : ""

      csv << [answers.first.item_id, most_popular_answer, is_unanimous_text] + answer_names.map { |name| answer_counts.fetch(name, 0) } + answer_names.map { |name| answer_explanations.fetch(name, []).join("\n") }
    end
  end

  puts "Finished! Written to '#{filename}'"
end

