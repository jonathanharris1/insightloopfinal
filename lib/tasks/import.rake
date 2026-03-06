require "csv"

namespace :import do
  desc "Import customers from CSV. Usage: rake import:customers[path/to/file.csv]"
  task :customers, [:file] => :environment do |_t, args|
    file_path = args[:file]
    abort "Usage: rake import:customers[path/to/file.csv]" unless file_path
    abort "File not found: #{file_path}" unless File.exist?(file_path)

    user = User.first
    abort "No user found in the database. Create a user first." unless user

    rows = CSV.read(file_path, headers: true, liberal_parsing: true)
    total = rows.size

    puts "Importing #{total} customers for user #{user.email}..."

    rows.each_with_index do |row, index|
      external_id = row["external_id"].to_s.strip
      next if external_id.blank?

      customer = Customer.find_or_initialize_by(external_id: external_id)
      customer.assign_attributes(
        name: row["name"].to_s.strip.presence,
        email: row["email"].to_s.strip.presence,
        mrr: row["mrr"].present? ? row["mrr"].to_d : nil,
        plan: row["plan"].to_s.strip.presence,
        status: row["status"].to_s.strip.presence || "active",
        churned_at: row["churned_at"].present? ? Date.parse(row["churned_at"]) : nil,
        user: user
      )
      customer.save!

      puts "Processando #{index + 1}/#{total}... #{external_id}"
    end

    puts "Done! #{total} customers imported."
  end

  desc "Import conversations from CSV. Usage: rake import:conversations[path/to/file.csv]"
  task :conversations, [:file] => :environment do |_t, args|
    file_path = args[:file]
    abort "Usage: rake import:conversations[path/to/file.csv]" unless file_path
    abort "File not found: #{file_path}" unless File.exist?(file_path)

    user = User.first
    abort "No user found in the database. Create a user first." unless user

    rows = CSV.read(file_path, headers: true, liberal_parsing: true)
    total = rows.size

    puts "Importing #{total} conversations for user #{user.email}..."

    rows.each_with_index do |row, index|
      customer = nil
      customer_external_id = row["customer_external_id"].to_s.strip
      if customer_external_id.present?
        customer = Customer.find_by(external_id: customer_external_id)
      end

      occurred_on = row["occurred_on"].present? ? Date.parse(row["occurred_on"]) : Date.current
      channel = row["channel"].to_s.strip.presence
      content = row["content"].to_s.strip

      if content.blank?
        puts "Skipping row #{index + 1}/#{total} — empty content"
        next
      end

      Conversation.create!(
        user: user,
        customer: customer,
        channel: channel,
        content: content,
        occurred_on: occurred_on
      )

      puts "Processando #{index + 1}/#{total}..."
      sleep 1
    end

    puts "Done! Conversations imported."
  end
end
